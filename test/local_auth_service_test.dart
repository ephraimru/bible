import 'package:faith_mission_app/services/local_auth_service.dart';
import 'package:faith_mission_app/services/local_storage_service.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/test_storage.dart';

void main() {
  late LocalStorageService storage;
  late LocalAuthService auth;

  setUp(() async {
    storage = await createTestStorage();
    auth = LocalAuthService(localStorageService: storage);
  });

  tearDown(() async {
    auth.dispose();
    await disposeTestStorage();
  });

  test('sign up stores a salted hash, never the password', () async {
    final user = await auth.signUpWithEmailAndPassword(
      email: 'Grace@Example.com',
      password: 'amazing-grace',
      displayName: 'Grace',
    );
    expect(user.email, 'grace@example.com');
    final creds = storage.getCredentials(user.id)!;
    expect(creds['hash'], isNot(contains('amazing-grace')));
    expect(creds['salt'], isNotEmpty);
    expect(auth.currentUserId, user.id);
  });

  test('sign in requires the correct password', () async {
    await auth.signUpWithEmailAndPassword(
      email: 'paul@example.com', password: 'tarsus123', displayName: 'Paul');
    await auth.signOut();
    expect(auth.isLoggedIn, isFalse);

    expect(
      () => auth.signInWithEmailAndPassword(email: 'paul@example.com', password: 'wrong-pass'),
      throwsA(isA<AuthException>()),
    );
    expect(
      () => auth.signInWithEmailAndPassword(email: 'nobody@example.com', password: 'tarsus123'),
      throwsA(isA<AuthException>()),
    );

    final user = await auth.signInWithEmailAndPassword(
      email: ' PAUL@example.com ', password: 'tarsus123');
    expect(user.displayName, 'Paul');
  });

  test('rejects duplicate emails and short passwords', () async {
    await auth.signUpWithEmailAndPassword(
      email: 'a@example.com', password: 'secret1', displayName: 'A');
    expect(
      () => auth.signUpWithEmailAndPassword(
          email: 'A@example.com', password: 'secret2', displayName: 'B'),
      throwsA(isA<AuthException>()),
    );
    expect(
      () => auth.signUpWithEmailAndPassword(
          email: 'b@example.com', password: '123', displayName: 'B'),
      throwsA(isA<AuthException>()),
    );
  });

  test('session is restored synchronously on restart', () async {
    final user = await auth.signUpWithEmailAndPassword(
      email: 'lydia@example.com', password: 'purple-cloth', displayName: 'Lydia');
    final restarted = LocalAuthService(localStorageService: storage);
    expect(restarted.currentUserId, user.id);
    expect(restarted.currentUser!.displayName, 'Lydia');
    restarted.dispose();
  });

  test('google sign-in is refused rather than faked', () async {
    expect(() => auth.signInWithGoogle(), throwsA(isA<AuthException>()));
  });

  test('changing password needs the current password', () async {
    await auth.signUpWithEmailAndPassword(
      email: 'tim@example.com', password: 'first-pass', displayName: 'Tim');
    expect(
      () => auth.updatePassword(currentPassword: 'nope', newPassword: 'second-pass'),
      throwsA(isA<AuthException>()),
    );
    await auth.updatePassword(currentPassword: 'first-pass', newPassword: 'second-pass');
    await auth.signOut();
    await auth.signInWithEmailAndPassword(email: 'tim@example.com', password: 'second-pass');
    expect(auth.isLoggedIn, isTrue);
  });
}
