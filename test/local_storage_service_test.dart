import 'package:faith_mission_app/models/faith_journey_model.dart';
import 'package:faith_mission_app/models/user_model.dart';
import 'package:faith_mission_app/services/local_storage_service.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/test_storage.dart';

void main() {
  late LocalStorageService storage;

  setUp(() async => storage = await createTestStorage());
  tearDown(disposeTestStorage);

  test('stores and reloads Freezed models without Hive adapters', () async {
    final user = UserModel(id: 'u1', email: 'e@x.com', displayName: 'E');
    await storage.createUser(user);
    expect(await storage.getUser('u1'), user);
  });

  test('partial updates accept enums, dates and any model field', () async {
    await storage.createUser(UserModel(id: 'u1', email: 'e@x.com', displayName: 'E'));
    final when = DateTime(2026, 1, 2, 3, 4);
    await storage.updateUser('u1', {
      'role': UserRole.preacher, // enum value
      'premiumTier': 'pro', // enum by name
      'lastReadingDate': when,
      'hasPaidToSkipLadder': true,
      'preferences': {'reminderTime': '07:30', 'dailyReminders': false},
    });
    final updated = (await storage.getUser('u1'))!;
    expect(updated.role, UserRole.preacher);
    expect(updated.premiumTier, PremiumTier.pro);
    expect(updated.lastReadingDate, when);
    expect(updated.hasPaidToSkipLadder, isTrue);
    expect(updated.stringPref('reminderTime', '09:00'), '07:30');
    expect(updated.boolPref('dailyReminders'), isFalse);
  });

  test('faith journey updates persist fields the old code silently dropped', () async {
    await storage.createFaithJourney(
        const FaithJourney(userId: 'u1', currentRole: UserRole.believer));
    await storage.updateFaithJourney('u1', {
      'consecutiveDays': 5,
      'hasReachedPreacher': true,
      'chaptersCompleted': ['John 3'],
    });
    final journey = (await storage.getFaithJourney('u1'))!;
    expect(journey.consecutiveDays, 5);
    expect(journey.hasReachedPreacher, isTrue);
    expect(journey.chaptersCompleted, ['John 3']);
  });

  test('streams emit the current value first', () async {
    await storage.createUser(UserModel(id: 'u1', email: 'e@x.com', displayName: 'E'));
    final first = await storage.streamUser('u1').first;
    expect(first!.displayName, 'E');
  });
}
