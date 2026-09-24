import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../models/user_model.dart';
import 'database_service.dart';

// Auth Service Provider
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(
    firebaseAuth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
    databaseService: ref.read(databaseServiceProvider),
  );
});

// Auth State Provider
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(authServiceProvider).authStateChanges;
});

// Current User Provider
final currentUserProvider = StreamProvider<UserModel?>((ref) async* {
  final authState = ref.watch(authStateProvider);
  
  await for (final user in authState) {
    if (user != null) {
      final userModel = await ref
          .read(authServiceProvider)
          .getUser(user.uid);
      yield userModel;
    } else {
      yield null;
    }
  }
});

class AuthService {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final DatabaseService _databaseService;

  AuthService({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore,
    required DatabaseService databaseService,
  })  : _firebaseAuth = firebaseAuth,
        _firestore = firestore,
        _databaseService = databaseService;

  // Auth state stream
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // User stream
  Stream<User?> get user => _firebaseAuth.userChanges();

  // Sign in with email and password
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      final user = userCredential.user!;
      
      // Check if user exists in Firestore
      final userModel = await getUser(user.uid);
      
      if (userModel == null) {
        // Create user document if it doesn't exist
        final newUser = UserModel(
          id: user.uid,
          email: user.email ?? email,
          displayName: user.displayName ?? email.split('@')[0],
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        
        await _databaseService.createUser(newUser);
        return newUser;
      }
      
      // Update last login
      await _databaseService.updateUser(
        user.uid,
        {'lastLoginAt': FieldValue.serverTimestamp()},
      );
      
      return userModel;
    } catch (e) {
      rethrow;
    }
  }

  // Sign up with email and password
  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
    String? photoUrl,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      final user = userCredential.user!;
      
      // Create user document
      final newUser = UserModel(
        id: user.uid,
        email: user.email ?? email,
        displayName: displayName,
        photoUrl: photoUrl,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      await _databaseService.createUser(newUser);
      
      return newUser;
    } catch (e) {
      rethrow;
    }
  }

  // Sign in with Google
  Future<UserModel> signInWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();
      
      if (googleUser == null) {
        throw Exception('Google sign in cancelled');
      }
      
      final googleAuth = await googleUser.authentication;
      final oAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      
      final userCredential = await _firebaseAuth.signInWithCredential(
        oAuthCredential,
      );
      
      final user = userCredential.user!;
      
      // Check if user exists in Firestore
      final userModel = await getUser(user.uid);
      
      if (userModel == null) {
        // Create user document
        final newUser = UserModel(
          id: user.uid,
          email: user.email ?? googleUser.email,
          displayName: user.displayName ?? googleUser.displayName ?? 'User',
          photoUrl: user.photoURL ?? googleUser.photoUrl,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        
        await _databaseService.createUser(newUser);
        return newUser;
      }
      
      // Update user info if needed
      if (userModel.photoUrl != user.photoURL ||
          userModel.displayName != user.displayName) {
        await _databaseService.updateUser(
          user.uid,
          {
            'photoUrl': user.photoURL ?? userModel.photoUrl,
            'displayName': user.displayName ?? userModel.displayName,
            'updatedAt': FieldValue.serverTimestamp(),
          },
        );
      }
      
      return userModel;
    } catch (e) {
      rethrow;
    }
  }

  // Sign in with Apple
  Future<UserModel> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      
      final oAuthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );
      
      final userCredential = await _firebaseAuth.signInWithCredential(
        oAuthCredential,
      );
      
      final user = userCredential.user!;
      
      // Check if user exists in Firestore
      final userModel = await getUser(user.uid);
      
      if (userModel == null) {
        // Create user document
        final displayName = appleCredential.givenName != null && 
            appleCredential.familyName != null
            ? '${appleCredential.givenName} ${appleCredential.familyName}'
            : 'User';
        
        final newUser = UserModel(
          id: user.uid,
          email: user.email ?? appleCredential.email ?? '',
          displayName: displayName,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        
        await _databaseService.createUser(newUser);
        return newUser;
      }
      
      return userModel;
    } catch (e) {
      rethrow;
    }
  }

  // Get user from Firestore
  Future<UserModel?> getUser(String userId) async {
    try {
      final doc = await _firestore
          .collection('users')
          .doc(userId)
          .get();
      
      if (doc.exists) {
        return UserModel.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Update user password
  Future<void> updatePassword(String newPassword) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
        await _databaseService.updateUser(
          user.uid,
          {'updatedAt': FieldValue.serverTimestamp()},
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  // Update email
  Future<void> updateEmail(String newEmail) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        await user.updateEmail(newEmail);
        await _databaseService.updateUser(
          user.uid,
          {
            'email': newEmail,
            'updatedAt': FieldValue.serverTimestamp(),
          },
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  // Update profile
  Future<void> updateProfile({
    String? displayName,
    String? photoUrl,
    String? bio,
  }) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        final updates = <String, dynamic>{'updatedAt': FieldValue.serverTimestamp()};
        
        if (displayName != null) {
          updates['displayName'] = displayName;
          await user.updateDisplayName(displayName);
        }
        if (photoUrl != null) {
          updates['photoUrl'] = photoUrl;
          await user.updatePhotoURL(photoUrl);
        }
        if (bio != null) {
          updates['bio'] = bio;
        }
        
        await _databaseService.updateUser(user.uid, updates);
      }
    } catch (e) {
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await GoogleSignIn().signOut();
    } catch (e) {
      rethrow;
    }
  }

  // Delete account
  Future<void> deleteAccount() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        // Delete user data from Firestore
        await _databaseService.deleteUser(user.uid);
        
        // Delete user from Firebase Auth
        await user.delete();
      }
    } catch (e) {
      rethrow;
    }
  }

  // Reauthenticate user
  Future<void> reauthenticateUser(String password) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null && user.email != null) {
        final credential = EmailAuthProvider.credential(
          email: user.email!,
          password: password,
        );
        await user.reauthenticateWithCredential(credential);
      }
    } catch (e) {
      rethrow;
    }
  }

  // Check if email is verified
  bool get isEmailVerified {
    final user = _firebaseAuth.currentUser;
    return user?.emailVerified ?? false;
  }

  // Send email verification
  Future<void> sendEmailVerification() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
    } catch (e) {
      rethrow;
    }
  }

  // Get current user ID
  String? get currentUserId {
    return _firebaseAuth.currentUser?.uid;
  }

  // Get current Firebase User
  User? get currentFirebaseUser {
    return _firebaseAuth.currentUser;
  }
}
