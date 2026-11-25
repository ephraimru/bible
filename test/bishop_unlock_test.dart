import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:faith_mission_app/config/app_config.dart';
import 'package:faith_mission_app/models/faith_journey_model.dart';
import 'package:faith_mission_app/models/user_model.dart';
import 'package:faith_mission_app/services/bishop_unlock.dart';
import 'package:faith_mission_app/services/local_storage_service.dart';
import 'package:faith_mission_app/services/premium_service.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/test_storage.dart';

void main() {
  // A throwaway key pair for tests only. The real private key is kept by the
  // admin and is never in the repository.
  final testSeed = List<int>.generate(32, (i) => i * 7 % 256);
  late String testPublicKey;

  setUpAll(() async {
    final keyPair = await Ed25519().newKeyPairFromSeed(testSeed);
    testPublicKey = base64.encode((await keyPair.extractPublicKey()).bytes);
  });

  group('BishopUnlock codes', () {
    test('a code verifies only for the email it was made for', () async {
      final code = await BishopUnlock.sign('Ruth@Example.com', testSeed);
      expect(code, startsWith('FMB1.'));
      expect(code, hasLength(91));
      expect(await BishopUnlock.verify(code, 'ruth@example.com', publicKeyBase64: testPublicKey), isTrue);
      expect(await BishopUnlock.verify(code, ' RUTH@example.com ', publicKeyBase64: testPublicKey), isTrue);
      expect(await BishopUnlock.verify(code, 'naomi@example.com', publicKeyBase64: testPublicKey), isFalse);
    });

    test('tolerates spaces and line breaks from copy-paste', () async {
      final code = await BishopUnlock.sign('a@b.com', testSeed);
      final messy = ' ${code.substring(0, 40)}\n${code.substring(40)} ';
      expect(await BishopUnlock.verify(messy, 'a@b.com', publicKeyBase64: testPublicKey), isTrue);
    });

    test('rejects tampered, truncated and malformed codes', () async {
      final code = await BishopUnlock.sign('a@b.com', testSeed);
      final tampered = code.substring(0, 50) + (code[50] == 'A' ? 'B' : 'A') + code.substring(51);
      for (final bad in [tampered, code.substring(0, 80), 'FMB1.hello', 'not a code', '']) {
        expect(await BishopUnlock.verify(bad, 'a@b.com', publicKeyBase64: testPublicKey), isFalse,
            reason: bad);
      }
    });

    test('codes from another key are rejected by the real app key', () async {
      final code = await BishopUnlock.sign('a@b.com', testSeed);
      expect(await BishopUnlock.verify(code, 'a@b.com'), isFalse);
      expect(base64.decode(AppConfig.bishopUnlockPublicKey), hasLength(32));
    });
  });

  group('PremiumService', () {
    late LocalStorageService storage;
    late PremiumService premium;
    const userId = 'u1';

    setUp(() async {
      storage = await createTestStorage();
      premium = PremiumService(localStorageService: storage, unlockPublicKey: testPublicKey);
      await storage.createUser(UserModel(id: userId, email: 'ruth@example.com', displayName: 'Ruth'));
      await storage.createFaithJourney(const FaithJourney(userId: userId, currentRole: UserRole.believer));
    });
    tearDown(disposeTestStorage);

    test('every feature is free; blog posting stays a Bishop privilege', () async {
      final features = await premium.getFeatures(userId);
      expect(features['search'], isTrue);
      expect(features['adFree'], isTrue);
      expect(features['offlineReading'], isTrue);
      expect(features['canPostOnBlog'], isFalse);
    });

    test('a valid code makes the user a Bishop', () async {
      final code = await BishopUnlock.sign('ruth@example.com', testSeed);
      expect(await premium.redeemBishopCode(userId, code), RedeemResult.unlocked);

      final user = (await storage.getUser(userId))!;
      expect(user.role, UserRole.bishop);
      expect(user.hasPaidToSkipLadder, isTrue);
      expect(user.canPostOnBlog, isTrue);
      final journey = (await storage.getFaithJourney(userId))!;
      expect(journey.currentRole, UserRole.bishop);
      expect(journey.hasReachedBishop, isTrue);
      expect((await premium.getFeatures(userId))['canPostOnBlog'], isTrue);

      expect(await premium.redeemBishopCode(userId, code), RedeemResult.alreadyBishop);
    });

    test("someone else's code does not unlock this account", () async {
      final code = await BishopUnlock.sign('naomi@example.com', testSeed);
      expect(await premium.redeemBishopCode(userId, code), RedeemResult.invalidCode);
      expect((await storage.getUser(userId))!.role, UserRole.believer);
    });
  });
}
