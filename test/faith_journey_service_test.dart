import 'package:faith_mission_app/models/faith_journey_model.dart';
import 'package:faith_mission_app/models/user_model.dart';
import 'package:faith_mission_app/services/bible_service.dart';
import 'package:faith_mission_app/services/faith_journey_service.dart';
import 'package:faith_mission_app/services/local_storage_service.dart';
import 'package:faith_mission_app/services/notification_service.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/test_storage.dart';

void main() {
  late LocalStorageService storage;
  late FaithJourneyService journeys;
  const userId = 'u1';

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    storage = await createTestStorage();
    await storage.createUser(UserModel(id: userId, email: 'e@x.com', displayName: 'E'));
    journeys = FaithJourneyService(
      localStorageService: storage,
      bibleService: BibleService(),
      notificationService: NotificationService(localStorageService: storage),
    );
    await journeys.createFaithJourney(userId);
  });
  tearDown(disposeTestStorage);

  Future<void> read(String book, int chapter) => journeys.updateReadingProgress(
      userId: userId, book: book, chapter: chapter, versesCount: 20);

  Future<void> setLastRead(DateTime date, {int streak = 1}) =>
      storage.updateFaithJourney(userId, {'lastReadingDate': date, 'consecutiveDays': streak});

  test('several chapters on the same day count as one streak day', () async {
    await read('John', 1);
    await read('John', 2);
    await read('John', 3);
    final j = (await journeys.getFaithJourney(userId))!;
    expect(j.consecutiveDays, 1);
    expect(j.totalDaysRead, 1);
    expect(j.chaptersRead, 3);
    expect(await journeys.isChapterCompleted(userId, 'John', 2), isTrue);
  });

  test('re-reading a chapter does not inflate counts', () async {
    await read('John', 1);
    await read('John', 1);
    final j = (await journeys.getFaithJourney(userId))!;
    expect(j.chaptersRead, 1);
    expect(j.versesRead, 20);
  });

  test('reading on consecutive days grows the streak; a gap resets it', () async {
    final now = DateTime.now();
    await setLastRead(now.subtract(const Duration(days: 1)), streak: 4);
    await read('Acts', 1);
    expect((await journeys.getFaithJourney(userId))!.consecutiveDays, 5);

    await setLastRead(now.subtract(const Duration(days: 3)), streak: 5);
    await read('Acts', 2);
    expect((await journeys.getFaithJourney(userId))!.consecutiveDays, 1);
  });

  test('promotes to Preacher at 30 days (not 7) and never to Bishop by streak', () async {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    await setLastRead(yesterday, streak: 6);
    await read('Romans', 1);
    expect((await storage.getUser(userId))!.role, UserRole.believer);

    await setLastRead(yesterday, streak: 29);
    await read('Romans', 2);
    expect((await storage.getUser(userId))!.role, UserRole.preacher);
    expect((await journeys.getFaithJourney(userId))!.currentRole, UserRole.preacher);

    await storage.updateUser(userId, {'role': UserRole.shepherd});
    await storage.updateFaithJourney(userId, {'currentRole': UserRole.shepherd});
    await setLastRead(yesterday, streak: 500);
    await read('Romans', 3);
    expect((await storage.getUser(userId))!.role, UserRole.shepherd);
  });

  test('stats report progress toward the next role', () async {
    await storage.updateFaithJourney(userId, {'consecutiveDays': 15});
    final stats = journeys.getFaithJourneyStats((await journeys.getFaithJourney(userId))!);
    expect(stats.nextRoleName, 'Preacher');
    expect(stats.daysToNextRole, 15);
    expect(stats.progressToNextRole, closeTo(0.5, 0.001));
    expect(stats.hasNextRole, isTrue);
  });
}
