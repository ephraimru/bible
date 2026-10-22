import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../models/user_model.dart';
import 'local_storage_service.dart';

// Auth Service Provider - uses LocalStorageService (Hive)
final localAuthServiceProvider = Provider<LocalAuthService>((ref) {
  return LocalAuthService(
    localStorageService: ref.read(localStorageServiceProvider),
  );
});

// Auth State Provider
final localAuthStateProvider = StreamProvider<UserModel?>((ref) {
  return ref.read(localAuthServiceProvider).authStateChanges;
});

// Current User Provider
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

  // Sign up with email and password (simulated for local storage)
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
      role: UserRole.believer,
      premiumTier: PremiumTier.free,
      followingCount: 0,
      followersCount: 0,
      savedVersesCount: 0,
      likedVersesCount: 0,
      blogPostsCount: 0,
      savedVerseIds: [],
      likedVerseIds: [],
      bookmarkedBlogPostIds: [],
      readingStats: {},
      consecutiveReadingDays: 0,
      totalReadingDays: 0,
      streakStartDate: DateTime.now().millisecondsSinceEpoch,
      badges: [],
      hasPaidToSkipLadder: false,
      lastReadingDate: null,
      lastNotificationDate: null,
      chosenTitle: null,
      blockedUserIds: [],
      preferences: {},
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      followingUserIds: [],
    );
    
    await _localStorageService.createUser(newUser);
    
    // Set as current user
    _currentUser = newUser;
    await _setStoredUserId(userId);
    _authStateController.add(newUser);
    
    return newUser;
  }

  // Sign in with email and password (simulated for local storage)
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final existingUsers = await _localStorageService.getAllUsers();
    final user = existingUsers.firstWhere(
      (u) => u.email == email,
      orElse: () => throw Exception('User not found'),
    );
    
    // In a real app, you would verify the password here
    // For local storage demo, we just check if user exists
    
    // Set as current user
    _currentUser = user;
    await _setStoredUserId(user.id);
    _authStateController.add(user);
    
    // Update last login
    await _localStorageService.updateUser(user.id, {
      'lastLoginAt': DateTime.now(),
      'updatedAt': DateTime.now(),
    });
    
    return user;
  }

  // Sign out
  Future<void> signOut() async {
    _currentUser = null;
    await _setStoredUserId(null);
    _authStateController.add(null);
  }

  // Delete account
  Future<void> deleteAccount() async {
    if (_currentUser != null) {
      await _localStorageService.deleteUser(_currentUser!.id);
      await signOut();
    }
  }

  // Update profile
  Future<void> updateProfile({
    String? displayName,
    String? photoUrl,
    String? bio,
  }) async {
    if (_currentUser != null) {
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
  }

  // Update email
  Future<void> updateEmail(String newEmail) async {
    if (_currentUser != null) {
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
  }

  // Update password (simulated - in real app would hash and store)
  Future<void> updatePassword(String newPassword) async {
    // In a real app with backend, this would update the password
    // For local storage, we don't store passwords
    if (_currentUser != null) {
      await _localStorageService.updateUser(_currentUser!.id, {
        'updatedAt': DateTime.now(),
      });
    }
  }

  // Reset password (simulated)
  Future<void> resetPassword(String email) async {
    // In a real app, this would send a password reset email
    // For local storage, we just verify the email exists
    final existingUsers = await _localStorageService.getAllUsers();
    final userExists = existingUsers.any((u) => u.email == email);
    
    if (!userExists) {
      throw Exception('User with this email not found');
    }
  }

  // Get user by ID
  Future<UserModel?> getUser(String userId) async {
    return _localStorageService.getUser(userId);
  }

  // Dispose
  void dispose() {
    _authStateController.close();
  }
}

// Old AuthService for Firebase (kept for reference but not used)
class AuthService {
  final LocalAuthService _localAuthService;
  final DatabaseService _databaseService;

  AuthService({
    required LocalAuthService localAuthService,
    required DatabaseService databaseService,
  })  : _localAuthService = localAuthService,
        _databaseService = databaseService;

  // Sign in with email and password
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return _localAuthService.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Sign up with email and password
  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
    String? photoUrl,
  }) async {
    return _localAuthService.signUpWithEmailAndPassword(
      email: email,
      password: password,
      displayName: displayName,
      photoUrl: photoUrl,
    );
  }

  // Get user
  Future<UserModel?> getUser(String userId) async {
    return _localAuthService.getUser(userId);
  }

  // Sign out
  Future<void> signOut() async {
    await _localAuthService.signOut();
  }

  // Delete account
  Future<void> deleteAccount() async {
    await _localAuthService.deleteAccount();
  }

  // Update profile
  Future<void> updateProfile({
    String? displayName,
    String? photoUrl,
    String? bio,
  }) async {
    await _localAuthService.updateProfile(
      displayName: displayName,
      photoUrl: photoUrl,
      bio: bio,
    );
  }

  // Update email
  Future<void> updateEmail(String newEmail) async {
    await _localAuthService.updateEmail(newEmail);
  }

  // Update password
  Future<void> updatePassword(String newPassword) async {
    await _localAuthService.updatePassword(newPassword);
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    await _localAuthService.resetPassword(email);
  }

  // Get current user ID
  String? get currentUserId => _localAuthService.currentUserId;

  // Get current user
  UserModel? get currentUser => _localAuthService.currentUser;

  // Check if logged in
  bool get isLoggedIn => _localAuthService.isLoggedIn;

  // Auth state stream
  Stream<UserModel?> get authStateChanges => _localAuthService.authStateChanges;
}
