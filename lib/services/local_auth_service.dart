import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../models/user_model.dart';
import 'local_storage_service.dart';

// Local Auth Service Provider
final localAuthServiceProvider = Provider<LocalAuthService>((ref) {
  return LocalAuthService(
    localStorageService: ref.read(localStorageServiceProvider),
  );
});

// Auth State Provider for Local Auth
final localAuthStateProvider = StreamProvider<UserModel?>((ref) {
  return ref.read(localAuthServiceProvider).authStateChanges;
});

// Current User Provider for Local Auth
final localCurrentUserProvider = Provider<UserModel?>((ref) {
  return ref.read(localAuthServiceProvider).currentUser;
});

class LocalAuthService {
  final LocalStorageService _localStorageService;
  final Uuid _uuid = const Uuid();
  
  // Keys for storing auth state
  static const String _currentUserIdKey = 'current_user_id';
  static const String _isLoggedInKey = 'is_logged_in';
  
  // Current user
  UserModel? _currentUser;
  
  // Stream controller for auth state changes
  final _authStateController = StreamController<UserModel?>.broadcast();
  
  LocalAuthService({
    required LocalStorageService localStorageService,
  }) : _localStorageService = localStorageService {
    // Load current user on initialization
    _loadCurrentUser();
  }

  // Load current user from storage
  Future<void> _loadCurrentUser() async {
    final userId = await _getStoredUserId();
    if (userId != null) {
      _currentUser = await _localStorageService.getUser(userId);
      _authStateController.add(_currentUser);
    }
  }

  // Get stored user ID
  Future<String?> _getStoredUserId() async {
    return _localStorageService.getAppSetting<String>(_currentUserIdKey);
  }

  // Set stored user ID
  Future<void> _setStoredUserId(String? userId) async {
    if (userId != null) {
      await _localStorageService.setAppSetting(_currentUserIdKey, userId);
      await _localStorageService.setAppSetting(_isLoggedInKey, true);
    } else {
      await _localStorageService.setAppSetting(_currentUserIdKey, null);
      await _localStorageService.setAppSetting(_isLoggedInKey, false);
    }
  }

  // Auth state stream
  Stream<UserModel?> get authStateChanges => _authStateController.stream;

  // Get current user
  UserModel? get currentUser => _currentUser;

  // Get current user ID
  String? get currentUserId => _currentUser?.id;

  // Check if user is logged in
  bool get isLoggedIn => _currentUser != null;

  // Sign up with email and password (simulated)
  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
    String? photoUrl,
  }) async {
    // Check if user already exists
    final existingUsers = await _localStorageService.getAllUsers();
    final userExists = existingUsers.any((u) => u.email == email);
    
    if (userExists) {
      throw Exception('User with this email already exists');
    }
    
    // Create new user
    final userId = _uuid.v4();
    final newUser = UserModel(
      id: userId,
      email: email,
      displayName: displayName,
      photoUrl: photoUrl,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    // Store user
    await _localStorageService.createUser(newUser);
    
    // Set as current user
    _currentUser = newUser;
    await _setStoredUserId(userId);
    _authStateController.add(_currentUser);
    
    return newUser;
  }

  // Sign in with email and password (simulated - no actual password checking)
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    // Find user by email
    final existingUsers = await _localStorageService.getAllUsers();
    final user = existingUsers.firstWhere(
      (u) => u.email == email,
      orElse: () => null,
    );
    
    if (user == null) {
      throw Exception('User not found');
    }
    
    // In a real app, you would verify the password here
    // For now, we'll just accept any non-empty password
    if (password.isEmpty) {
      throw Exception('Invalid password');
    }
    
    // Update last login
    final updatedUser = user.copyWith(
      lastNotificationDate: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await _localStorageService.updateUser(user.id, {'lastNotificationDate': DateTime.now(), 'updatedAt': DateTime.now()});
    
    // Set as current user
    _currentUser = updatedUser;
    await _setStoredUserId(user.id);
    _authStateController.add(_currentUser);
    
    return updatedUser;
  }

  // Sign up/sign in with Google (simulated)
  Future<UserModel> signInWithGoogle() async {
    // For local mode, we'll create a test user if one doesn't exist
    final existingUsers = await _localStorageService.getAllUsers();
    
    // Check if there's a user with google email
    final googleUser = existingUsers.firstWhere(
      (u) => u.email.endsWith('@gmail.com'),
      orElse: () => null,
    );
    
    if (googleUser != null) {
      // Update last login
      final updatedUser = googleUser.copyWith(
        lastNotificationDate: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await _localStorageService.updateUser(googleUser.id, {'lastNotificationDate': DateTime.now(), 'updatedAt': DateTime.now()});
      
      _currentUser = updatedUser;
      await _setStoredUserId(googleUser.id);
      _authStateController.add(_currentUser);
      
      return updatedUser;
    }
    
    // Create new test user
    final userId = _uuid.v4();
    final newUser = UserModel(
      id: userId,
      email: 'test_${_uuid.v4().substring(0, 8)}@gmail.com',
      displayName: 'Test User',
      photoUrl: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    await _localStorageService.createUser(newUser);
    _currentUser = newUser;
    await _setStoredUserId(userId);
    _authStateController.add(_currentUser);
    
    return newUser;
  }

  // Get user by ID
  Future<UserModel?> getUser(String userId) async {
    return _localStorageService.getUser(userId);
  }

  // Update profile
  Future<void> updateProfile({
    String? displayName,
    String? photoUrl,
    String? bio,
  }) async {
    if (_currentUser == null) {
      throw Exception('No user logged in');
    }
    
    final updates = <String, dynamic>{'updatedAt': DateTime.now()};
    
    if (displayName != null) {
      updates['displayName'] = displayName;
    }
    if (photoUrl != null) {
      updates['photoUrl'] = photoUrl;
    }
    if (bio != null) {
      updates['bio'] = bio;
    }
    
    await _localStorageService.updateUser(_currentUser!.id, updates);
    
    // Update current user
    _currentUser = _currentUser!.copyWith(
      displayName: displayName ?? _currentUser!.displayName,
      photoUrl: photoUrl ?? _currentUser!.photoUrl,
      bio: bio ?? _currentUser!.bio,
      updatedAt: DateTime.now(),
    );
    
    _authStateController.add(_currentUser);
  }

  // Update password (simulated - no actual password storage)
  Future<void> updatePassword(String newPassword) async {
    if (_currentUser == null) {
      throw Exception('No user logged in');
    }
    
    // In a real app, you would store/update the password hash
    // For local mode, we just pretend it worked
    await _localStorageService.updateUser(_currentUser!.id, {'updatedAt': DateTime.now()});
    
    _currentUser = _currentUser!.copyWith(updatedAt: DateTime.now());
    _authStateController.add(_currentUser);
  }

  // Reset password (simulated)
  Future<void> resetPassword(String email) async {
    // In a real app, this would send an email
    // For local mode, we just pretend it worked
  }

  // Update email
  Future<void> updateEmail(String newEmail) async {
    if (_currentUser == null) {
      throw Exception('No user logged in');
    }
    
    // Check if email is already in use
    final existingUsers = await _localStorageService.getAllUsers();
    final emailExists = existingUsers.any((u) => u.email == newEmail && u.id != _currentUser!.id);
    
    if (emailExists) {
      throw Exception('Email already in use');
    }
    
    await _localStorageService.updateUser(_currentUser!.id, {
      'email': newEmail,
      'updatedAt': DateTime.now(),
    });
    
    _currentUser = _currentUser!.copyWith(
      email: newEmail,
      updatedAt: DateTime.now(),
    );
    
    _authStateController.add(_currentUser);
  }

  // Sign out
  Future<void> signOut() async {
    _currentUser = null;
    await _setStoredUserId(null);
    _authStateController.add(null);
  }

  // Delete account
  Future<void> deleteAccount() async {
    if (_currentUser == null) {
      throw Exception('No user logged in');
    }
    
    // Delete user
    await _localStorageService.deleteUser(_currentUser!.id);
    
    // Clear current user
    _currentUser = null;
    await _setStoredUserId(null);
    _authStateController.add(null);
  }

  // Check if email is verified (always true for local mode)
  bool get isEmailVerified => true;

  // Send email verification (no-op for local mode)
  Future<void> sendEmailVerification() async {
    // No-op for local mode
  }

  // Reauthenticate user (no-op for local mode)
  Future<void> reauthenticateUser(String password) async {
    // No-op for local mode
  }

  // Dispose
  void dispose() {
    _authStateController.close();
  }
}
