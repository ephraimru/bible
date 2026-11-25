import 'package:faith_mission_app/models/user_model.dart';
import 'package:faith_mission_app/services/auth_service.dart';
import 'package:faith_mission_app/services/local_storage_service.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/test_storage.dart';

void main() {
  late LocalStorageService storage;
  late FakeFirebaseFirestore firestore;
  late MockFirebaseAuth firebaseAuth;
  late AuthService auth;

  Future<void> settle() => Future<void>.delayed(const Duration(milliseconds: 50));

  setUp(() async {
    storage = await createTestStorage();
    firestore = FakeFirebaseFirestore();
    firebaseAuth = MockFirebaseAuth();
    auth = AuthService(auth: firebaseAuth, firestore: firestore, localStorageService: storage);
  });

  tearDown(() async {
    auth.dispose();
    await disposeTestStorage();
  });

  test('sign-up creates a public profile without the email, and a device copy', () async {
    final user = await auth.signUpWithEmailAndPassword(
      email: 'ruth@example.com',
      password: 'whither-thou-goest',
      displayName: 'Ruth',
    );
    expect(auth.currentUserId, user.id);
    expect((await storage.getUser(user.id))!.displayName, 'Ruth');

    final profile = (await firestore.collection('users').doc(user.id).get()).data()!;
    expect(profile['displayName'], 'Ruth');
    expect(profile['role'], 'believer');
    expect(profile['hasPaidToSkipLadder'], isFalse);
    expect(profile.containsKey('email'), isFalse, reason: 'emails stay private');
  });

  test('validates name and password before contacting Firebase', () async {
    expect(
      () => auth.signUpWithEmailAndPassword(email: 'a@b.com', password: '123', displayName: 'A'),
      throwsA(isA<AuthException>()),
    );
    expect(
      () => auth.signUpWithEmailAndPassword(email: 'a@b.com', password: '123456', displayName: ' '),
      throwsA(isA<AuthException>()),
    );
  });

  test('Bishop granted by the admin in Firestore reaches the device', () async {
    final user = await auth.signUpWithEmailAndPassword(
      email: 'paul@example.com', password: 'tarsus123', displayName: 'Paul');
    await settle();

    // The admin edits users/{uid} in the Firebase console:
    await firestore.collection('users').doc(user.id).update({'role': 'bishop'});
    await settle();

    expect((await storage.getUser(user.id))!.role, UserRole.bishop);
  });

  test('profile edits on the device are published, but never a self-made Bishop', () async {
    final user = await auth.signUpWithEmailAndPassword(
      email: 'lydia@example.com', password: 'purple-cloth', displayName: 'Lydia');
    await settle();

    await auth.updateProfile(displayName: 'Lydia of Thyatira', bio: 'Seller of purple');
    await storage.updateUser(user.id, {'role': UserRole.bishop});
    await settle();

    final profile = (await firestore.collection('users').doc(user.id).get()).data()!;
    expect(profile['displayName'], 'Lydia of Thyatira');
    expect(profile['bio'], 'Seller of purple');
    expect(profile['role'], isNot('bishop'));
  });

  test('sign out clears the session', () async {
    await auth.signUpWithEmailAndPassword(email: 'a@b.com', password: 'secret1', displayName: 'A');
    await auth.signOut();
    await settle();
    expect(auth.isLoggedIn, isFalse);
    expect(auth.currentUser, isNull);
  });

  test('without a connected Firebase project, sign-in explains instead of failing', () async {
    final offline = AuthService(
      auth: MockFirebaseAuth(),
      firestore: FakeFirebaseFirestore(),
      localStorageService: storage,
      isBackendConfigured: false,
    );
    expect(
      () => offline.signInWithEmailAndPassword(email: 'a@b.com', password: 'secret1'),
      throwsA(isA<AuthException>().having((e) => e.message, 'message', contains('not set up'))),
    );
    offline.dispose();
  });
}
