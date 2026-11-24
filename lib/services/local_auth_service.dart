import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../models/user_model.dart';
import 'local_storage_service.dart';

/// Overridden in `main.dart` with an instance whose session is already restored.
final localAuthServiceProvider = Provider<LocalAuthService>((ref) {
  final service = LocalAuthService(
    localStorageService: ref.read(localStorageServiceProvider),
  );
  ref.onDispose(service.dispose);
  return service;
});

final localAuthStateProvider = StreamProvider<UserModel?>((ref) async* {
  final auth = ref.watch(localAuthServiceProvider);
  yield auth.currentUser;
  yield* auth.authStateChanges;
});

/// Live view of a stored user record.
final _userRecordProvider = StreamProvider.family<UserModel?, String>((ref, userId) {
  return ref.read(localStorageServiceProvider).streamUser(userId);
});

/// The signed-in user, kept up to date as their profile changes.
final localCurrentUserProvider = Provider<UserModel?>((ref) {
  final authState = ref.watch(localAuthStateProvider);
  final signedIn = authState.hasValue
      ? authState.value
      : ref.read(localAuthServiceProvider).currentUser;
  if (signedIn == null) return null;
  return ref.watch(_userRecordProvider(signedIn.id)).value ?? signedIn;
});

/// Thrown for problems the user can fix (wrong password, email taken, ...).
class AuthException implements Exception {
  AuthException(this.message);
  final String message;
  @override
  String toString() => message;
}

/// Offline, on-device accounts.
///
/// Passwords are never stored: we keep a random salt and a salted, iterated
/// SHA-256 hash, and compare hashes at sign-in.
class LocalAuthService {
  LocalAuthService({required LocalStorageService localStorageService})
      : _storage = localStorageService {
    _restoreSession();
  }

  static const String _currentUserIdKey = 'current_user_id';
  static const int _hashIterations = 10000;
  static const int minPasswordLength = 6;

  final LocalStorageService _storage;
  final Uuid _uuid = const Uuid();
  final _authStateController = StreamController<UserModel?>.broadcast();

  UserModel? _currentUser;

  /// Restores the signed-in user synchronously so the splash screen and the
  /// router see the correct state on the very first frame.
  void _restoreSession() {
    final userId = _storage.getAppSetting<String>(_currentUserIdKey);
    if (userId == null) return;
    _currentUser = _storage.getUserSync(userId);
    if (_currentUser == null) {
      // The stored account no longer exists.
      _storage.setAppSetting(_currentUserIdKey, null);
    }
  }

  Stream<UserModel?> get authStateChanges => _authStateController.stream;
  UserModel? get currentUser => _currentUser;
  String? get currentUserId => _currentUser?.id;
  bool get isLoggedIn => currentUserId != null;

  // ---------------------------------------------------------------- helpers

  static String _newSalt() {
    final random = Random.secure();
    return base64Url.encode(List<int>.generate(16, (_) => random.nextInt(256)));
  }

  static String _hash(String password, String salt) {
    List<int> digest = utf8.encode('$salt:$password');
    for (var i = 0; i < _hashIterations; i++) {
      digest = sha256.convert(digest).bytes;
    }
    return base64Url.encode(digest);
  }

  /// Constant-time comparison so timing doesn't leak how much of a hash matched.
  static bool _safeEquals(String a, String b) {
    if (a.length != b.length) return false;
    var diff = 0;
    for (var i = 0; i < a.length; i++) {
      diff |= a.codeUnitAt(i) ^ b.codeUnitAt(i);
    }
    return diff == 0;
  }

  static String _normalizeEmail(String email) => email.trim().toLowerCase();

  static void _validatePassword(String password) {
    if (password.length < minPasswordLength) {
      throw AuthException('Password must be at least $minPasswordLength characters');
    }
  }

  Future<void> _savePassword(String userId, String password) async {
    final salt = _newSalt();
    await _storage.setCredentials(userId, salt: salt, hash: _hash(password, salt));
  }

  bool _checkPassword(String userId, String password) {
    final creds = _storage.getCredentials(userId);
    if (creds == null) return false;
    return _safeEquals(_hash(password, creds['salt']!), creds['hash']!);
  }

  Future<void> _setCurrentUser(UserModel? user, {bool persist = true}) async {
    _currentUser = user;
    if (persist) {
      await _storage.setAppSetting(_currentUserIdKey, user?.id);
    }
    if (!_authStateController.isClosed) _authStateController.add(user);
  }

  Future<void> _reloadCurrentUser() async {
    final id = currentUserId;
    if (id == null) return;
    await _setCurrentUser(await _storage.getUser(id), persist: false);
  }

  // ------------------------------------------------------------- public API

  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
    String? photoUrl,
  }) async {
    final normalized = _normalizeEmail(email);
    if (normalized.isEmpty || !normalized.contains('@')) {
      throw AuthException('Please enter a valid email address');
    }
    _validatePassword(password);
    if (await _storage.getUserByEmail(normalized) != null) {
      throw AuthException('An account with this email already exists');
    }

    final now = DateTime.now();
    final user = UserModel(
      id: _uuid.v4(),
      email: normalized,
      displayName: displayName.trim(),
      photoUrl: photoUrl,
      createdAt: now,
      updatedAt: now,
    );
    await _storage.createUser(user);
    await _savePassword(user.id, password);
    await _setCurrentUser(user);
    return user;
  }

  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final user = await _storage.getUserByEmail(_normalizeEmail(email));
    // Same message for unknown email and wrong password, so the screen
    // doesn't reveal which emails have accounts.
    if (user == null || !_checkPassword(user.id, password)) {
      throw AuthException('Incorrect email or password');
    }
    if (user.status == UserStatus.banned) {
      throw AuthException('This account has been disabled');
    }
    await _setCurrentUser(user);
    return user;
  }

  /// Google sign-in needs a real identity provider, which the offline build
  /// doesn't have. Kept so callers compile; the UI hides the button.
  Future<UserModel> signInWithGoogle() async {
    throw AuthException('Google sign-in is not available in offline mode');
  }

  static const bool isGoogleSignInAvailable = false;

  Future<UserModel?> getUser(String userId) => _storage.getUser(userId);

  Future<void> updateProfile({String? displayName, String? photoUrl, String? bio}) async {
    final id = currentUserId;
    if (id == null) throw AuthException('No user logged in');
    await _storage.updateUser(id, {
      if (displayName != null) 'displayName': displayName.trim(),
      if (photoUrl != null) 'photoUrl': photoUrl,
      if (bio != null) 'bio': bio,
    });
    await _reloadCurrentUser();
  }

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final id = currentUserId;
    if (id == null) throw AuthException('No user logged in');
    if (!_checkPassword(id, currentPassword)) {
      throw AuthException('Current password is incorrect');
    }
    _validatePassword(newPassword);
    await _savePassword(id, newPassword);
  }

  /// Accounts live only on this device and there is no email server, so a
  /// reset link can't be sent.
  Future<void> resetPassword(String email) async {
    throw AuthException(
      'Password reset by email is not available in offline mode. '
      'If you remember your password, you can change it in Settings.',
    );
  }

  Future<void> updateEmail(String newEmail) async {
    final id = currentUserId;
    if (id == null) throw AuthException('No user logged in');
    final normalized = _normalizeEmail(newEmail);
    final existing = await _storage.getUserByEmail(normalized);
    if (existing != null && existing.id != id) {
      throw AuthException('Email already in use');
    }
    await _storage.updateUser(id, {'email': normalized});
    await _reloadCurrentUser();
  }

  Future<void> signOut() => _setCurrentUser(null);

  Future<void> deleteAccount() async {
    final id = currentUserId;
    if (id == null) throw AuthException('No user logged in');
    await _storage.deleteUser(id);
    await _storage.deleteCredentials(id);
    await _storage.deleteFaithJourney(id);
    await _storage.deleteReadingHabit(id);
    await _setCurrentUser(null);
  }

  bool get isEmailVerified => true;

  void dispose() {
    _authStateController.close();
  }
}
