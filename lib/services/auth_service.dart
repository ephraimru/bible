import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';
import 'local_storage_service.dart';
import 'progress_sync_service.dart';
import 'social_service.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
final firestoreProvider = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final authServiceProvider = Provider<AuthService>((ref) {
  final service = AuthService(
    auth: ref.read(firebaseAuthProvider),
    firestore: ref.read(firestoreProvider),
    localStorageService: ref.read(localStorageServiceProvider),
  );
  ref.onDispose(service.dispose);
  return service;
});

final authStateProvider = StreamProvider<UserModel?>((ref) async* {
  final auth = ref.watch(authServiceProvider);
  yield auth.currentUser;
  yield* auth.authStateChanges;
});

/// Live view of the device's copy of a user record.
final _userRecordProvider = StreamProvider.family<UserModel?, String>((ref, userId) {
  return ref.read(localStorageServiceProvider).streamUser(userId);
});

/// The signed-in user, kept up to date as their profile changes.
final currentUserProvider = Provider<UserModel?>((ref) {
  final authState = ref.watch(authStateProvider);
  final signedIn = authState.hasValue ? authState.value : ref.read(authServiceProvider).currentUser;
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

/// Accounts with Firebase Authentication (email and password).
///
/// Each account has a public profile at `users/{uid}` in Firestore (name,
/// role, title, bio; never the email) and a copy on the device that the
/// offline features (reading progress, saved verses, settings) use.
///
/// Bishop status is controlled by the admin in Firestore and only flows from
/// Firestore to the device. Name, bio, title and the reading-based roles
/// (Preacher, Shepherd) flow from the device to Firestore.
class AuthService {
  AuthService({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
    required LocalStorageService localStorageService,
    this.isBackendConfigured = true,
  })  : _auth = auth,
        _firestore = firestore,
        _storage = localStorageService,
        _progressSync = ProgressSyncService(firestore, localStorageService),
        _social = SocialService(firestore) {
    final user = _auth.currentUser;
    if (user != null) _currentUser = _storage.getUserSync(user.uid);
    _authSub = _auth.authStateChanges().listen(_onAuthChanged);
  }

  static const int minPasswordLength = 6;
  static const bool isGoogleSignInAvailable = false;

  /// False in builds made before a Firebase project was connected: sign-in
  /// then explains that online accounts aren't available yet.
  final bool isBackendConfigured;

  void _requireBackend() {
    if (!isBackendConfigured) {
      throw AuthException(
        'Online accounts are not set up in this version yet. '
        'Please install the latest version of the app.',
      );
    }
  }

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final LocalStorageService _storage;
  final ProgressSyncService _progressSync;
  final SocialService _social;
  final _authStateController = StreamController<UserModel?>.broadcast();

  StreamSubscription<User?>? _authSub;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _remoteSub;
  StreamSubscription<UserModel?>? _localSub;
  UserModel? _currentUser;

  Stream<UserModel?> get authStateChanges => _authStateController.stream;
  UserModel? get currentUser => _currentUser;
  String? get currentUserId => _auth.currentUser?.uid;
  bool get isLoggedIn => _auth.currentUser != null;

  DocumentReference<Map<String, dynamic>> _profileDoc(String uid) =>
      _firestore.collection('users').doc(uid);

  // ------------------------------------------------------------ session

  Future<void> _onAuthChanged(User? user) async {
    await _remoteSub?.cancel();
    await _localSub?.cancel();
    _remoteSub = null;
    _localSub = null;
    if (user == null) {
      await _progressSync.stop();
      _setCurrentUser(null);
      return;
    }
    _setCurrentUser(await _ensureLocalUser(user));
    _startProfileSync(user.uid);
    // Bring reading progress from the member's other devices (and keep it
    // in step from now on).
    unawaited(_progressSync.start(user.uid));
  }

  void _setCurrentUser(UserModel? user) {
    _currentUser = user;
    if (!_authStateController.isClosed) _authStateController.add(user);
  }

  Future<UserModel> _ensureLocalUser(User user, {String? displayName}) async {
    final existing = await _storage.getUser(user.uid);
    if (existing != null) return existing;
    final now = DateTime.now();
    final created = UserModel(
      id: user.uid,
      email: user.email ?? '',
      displayName: displayName ?? user.displayName ?? (user.email ?? 'Friend').split('@').first,
      createdAt: now,
      updatedAt: now,
    );
    await _storage.createUser(created);
    return created;
  }

  static Map<String, dynamic> _publicFields(UserModel u) => {
        'displayName': u.displayName,
        'bio': u.bio,
        'chosenTitle': u.chosenTitle,
        // The device may only report reading-based roles; Bishop is granted
        // by the admin in Firestore (firestore.rules enforces this).
        if (u.role != UserRole.bishop) 'role': u.role.name,
      };

  void _startProfileSync(String uid) {
    // Firestore -> device
    _remoteSub = _profileDoc(uid).snapshots().listen((snap) async {
      final local = await _storage.getUser(uid);
      if (local == null) return;
      if (!snap.exists) {
        await _createRemoteProfile(local);
        return;
      }
      final data = snap.data()!;
      final followers = (data['followersCount'] as num?)?.toInt() ?? 0;
      var remoteRole = UserRole.values.asNameMap()[data['role']] ?? UserRole.believer;

      // 1,000+ verified followers: promote to Bishop (firestore.rules checks
      // the count, so this can't be faked).
      if (remoteRole != UserRole.bishop && followers >= SocialService.bishopFollowers) {
        try {
          await _profileDoc(uid).update({'role': UserRole.bishop.name});
          remoteRole = UserRole.bishop;
        } catch (e) {
          debugPrint('Automatic Bishop promotion failed: $e');
        }
      }

      final updates = <String, dynamic>{};
      final remoteBishop = remoteRole == UserRole.bishop;
      final localBishop = local.role == UserRole.bishop;
      if (remoteBishop != localBishop) {
        updates['role'] = remoteBishop ? UserRole.bishop : remoteRole;
      }
      if (followers != local.followersCount) updates['followersCount'] = followers;
      for (final flag in ['hasPaidToSkipLadder', 'canPostOnBlog']) {
        final remote = data[flag] == true;
        final current = flag == 'hasPaidToSkipLadder' ? local.hasPaidToSkipLadder : local.canPostOnBlog;
        if (remote != current) updates[flag] = remote;
      }
      for (final field in ['displayName', 'bio', 'chosenTitle']) {
        final remote = data[field];
        final current = switch (field) {
          'displayName' => local.displayName,
          'bio' => local.bio,
          _ => local.chosenTitle,
        };
        if (remote is String && remote.isNotEmpty && remote != current) updates[field] = remote;
      }
      await _syncJourney(uid, followers: followers, role: remoteRole);
      if (updates.isNotEmpty) await _storage.updateUser(uid, updates);
    }, onError: (Object e) => debugPrint('Profile sync failed: $e'));

    // device -> Firestore
    _localSub = _storage.streamUser(uid).skip(1).listen((local) async {
      if (local == null) return;
      try {
        final snap = await _profileDoc(uid).get();
        final data = snap.data() ?? {};
        final changes = Map.of(_publicFields(local))
          ..removeWhere((k, v) => data[k] == v);
        if (data['role'] == UserRole.bishop.name) changes.remove('role');
        if (changes.isNotEmpty) await _profileDoc(uid).set(changes, SetOptions(merge: true));
      } catch (e) {
        debugPrint('Profile upload failed: $e');
      }
    });
  }

  /// Keeps the faith journey's follower count and Bishop status in step with
  /// the public profile, so progress screens show them.
  Future<void> _syncJourney(String uid, {required int followers, required UserRole role}) async {
    final journey = await _storage.getFaithJourney(uid);
    if (journey == null) return;
    final bishop = role == UserRole.bishop;
    final updates = <String, dynamic>{
      if (journey.followerCount != followers) 'followerCount': followers,
      if (bishop && journey.currentRole != UserRole.bishop) ...{
        'currentRole': UserRole.bishop,
        'hasReachedBishop': true,
        'canPostOnBlog': true,
      },
      // Bishop was withdrawn by the admin: fall back to the published role.
      if (!bishop && journey.currentRole == UserRole.bishop) ...{
        'currentRole': role,
        'canPostOnBlog': false,
      },
    };
    if (updates.isNotEmpty) await _storage.updateFaithJourney(uid, updates);
  }

  Future<void> _createRemoteProfile(UserModel user) async {
    await _profileDoc(user.id).set({
      ..._publicFields(user),
      'role': user.role == UserRole.bishop ? UserRole.believer.name : user.role.name,
      'hasPaidToSkipLadder': false,
      'canPostOnBlog': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // ------------------------------------------------------------- errors

  static AuthException _friendly(Object e) {
    if (e is AuthException) return e;
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'email-already-in-use':
          return AuthException('An account with this email already exists');
        case 'invalid-email':
          return AuthException('Please enter a valid email address');
        case 'weak-password':
          return AuthException('Password must be at least $minPasswordLength characters');
        case 'user-not-found':
        case 'wrong-password':
        case 'invalid-credential':
          return AuthException('Incorrect email or password');
        case 'user-disabled':
          return AuthException('This account has been disabled');
        case 'too-many-requests':
          return AuthException('Too many attempts. Please wait a moment and try again');
        case 'network-request-failed':
          return AuthException('No internet connection. Please check your connection and try again');
        case 'requires-recent-login':
          return AuthException('For your security, please sign out, sign in again, and retry');
      }
      return AuthException(e.message ?? 'Something went wrong. Please try again');
    }
    return AuthException('Something went wrong. Please try again');
  }

  // ---------------------------------------------------------- public API

  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
    String? photoUrl,
  }) async {
    _requireBackend();
    final name = displayName.trim();
    if (name.isEmpty) throw AuthException('Please enter your name');
    if (password.length < minPasswordLength) {
      throw AuthException('Password must be at least $minPasswordLength characters');
    }
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final user = cred.user!;
      await user.updateDisplayName(name);
      // Firebase may announce the new account (and we may create the device
      // copy) before the name is attached, so set the name explicitly.
      await _ensureLocalUser(user, displayName: name);
      await _storage.updateUser(user.uid, {'displayName': name});
      final local = (await _storage.getUser(user.uid))!;
      await _createRemoteProfile(local);
      _setCurrentUser(local);
      return local;
    } catch (e) {
      throw _friendly(e);
    }
  }

  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    _requireBackend();
    try {
      final cred = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);
      final local = await _ensureLocalUser(cred.user!);
      _setCurrentUser(local);
      return local;
    } catch (e) {
      throw _friendly(e);
    }
  }

  Future<UserModel> signInWithGoogle() async {
    throw AuthException('Google sign-in is not available yet');
  }

  Future<UserModel?> getUser(String userId) => _storage.getUser(userId);

  Future<void> updateProfile({String? displayName, String? photoUrl, String? bio}) async {
    final uid = currentUserId;
    if (uid == null) throw AuthException('No user logged in');
    if (displayName != null) await _auth.currentUser?.updateDisplayName(displayName.trim());
    await _storage.updateUser(uid, {
      if (displayName != null) 'displayName': displayName.trim(),
      if (photoUrl != null) 'photoUrl': photoUrl,
      if (bio != null) 'bio': bio,
    });
    _setCurrentUser(await _storage.getUser(uid));
  }

  Future<void> updatePassword({required String currentPassword, required String newPassword}) async {
    final user = _auth.currentUser;
    if (user == null || user.email == null) throw AuthException('No user logged in');
    if (newPassword.length < minPasswordLength) {
      throw AuthException('Password must be at least $minPasswordLength characters');
    }
    try {
      await user.reauthenticateWithCredential(
        EmailAuthProvider.credential(email: user.email!, password: currentPassword),
      );
      await user.updatePassword(newPassword);
    } catch (e) {
      final friendly = _friendly(e);
      if (friendly.message == 'Incorrect email or password') {
        throw AuthException('Current password is incorrect');
      }
      throw friendly;
    }
  }

  /// Sends a password-reset link to [email].
  Future<void> resetPassword(String email) async {
    _requireBackend();
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      // Don't reveal whether an account exists for this email.
      if (e.code == 'user-not-found') return;
      throw _friendly(e);
    }
  }

  Future<void> signOut() async {
    await _progressSync.flush();
    await _auth.signOut();
  }

  /// Deletes the account, its public profile and this device's copy of it.
  /// Blog posts, comments and chat messages the user wrote are not removed.
  Future<void> deleteAccount() async {
    final user = _auth.currentUser;
    if (user == null) throw AuthException('No user logged in');
    try {
      await _progressSync.stop();
      await _social.unfollowAll(user.uid);
      await _progressSync.deleteRemote(user.uid);
      await _profileDoc(user.uid).delete();
      await user.delete();
    } catch (e) {
      throw _friendly(e);
    }
    await _storage.deleteUser(user.uid);
    await _storage.deleteCredentials(user.uid);
    await _storage.deleteFaithJourney(user.uid);
    await _storage.deleteReadingHabit(user.uid);
  }

  bool get isEmailVerified => _auth.currentUser?.emailVerified ?? false;

  void dispose() {
    _progressSync.stop();
    _authSub?.cancel();
    _remoteSub?.cancel();
    _localSub?.cancel();
    _authStateController.close();
  }
}
