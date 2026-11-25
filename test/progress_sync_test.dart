import 'package:faith_mission_app/models/faith_journey_model.dart';
import 'package:faith_mission_app/models/user_model.dart';
import 'package:faith_mission_app/services/local_storage_service.dart';
import 'package:faith_mission_app/services/progress_sync_service.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/test_storage.dart';

void main() {
  group('mergeJourneys', () {
    final monday = DateTime(2026, 11, 23, 8);
    final tuesday = DateTime(2026, 11, 24, 21);

    test('keeps every chapter and the latest streak, and recounts books', () {
      final phone = FaithJourney(
        userId: 'u',
        currentRole: UserRole.believer,
        chaptersCompleted: const ['John 1', 'John 2'],
        consecutiveDays: 4,
        longestStreak: 9,
        totalDaysRead: 20,
        versesRead: 100,
        lastReadingDate: monday,
      );
      final tablet = FaithJourney(
        userId: 'u',
        currentRole: UserRole.preacher,
        chaptersCompleted: const ['John 2', 'Psalms 23'],
        consecutiveDays: 31,
        longestStreak: 31,
        totalDaysRead: 18,
        versesRead: 80,
        lastReadingDate: tuesday,
        hasReachedPreacher: true,
      );
      final merged = ProgressSyncService.mergeJourneys(phone, tablet);
      expect(merged.chaptersCompleted, ['John 1', 'John 2', 'Psalms 23']);
      expect(merged.chaptersRead, 3);
      expect(merged.bookProgress, {'John': 2, 'Psalms': 1});
      expect(merged.consecutiveDays, 31, reason: 'tablet read most recently');
      expect(merged.lastReadingDate, tuesday);
      expect(merged.longestStreak, 31);
      expect(merged.totalDaysRead, 20);
      expect(merged.versesRead, 100);
      expect(merged.currentRole, UserRole.preacher);
      expect(merged.hasReachedPreacher, isTrue);
    });

    test('never takes Bishop or follower count from the synced copy', () {
      const local = FaithJourney(userId: 'u', currentRole: UserRole.believer, followerCount: 7);
      const remote = FaithJourney(userId: 'u', currentRole: UserRole.bishop, followerCount: 5000);
      final merged = ProgressSyncService.mergeJourneys(local, remote);
      expect(merged.currentRole, isNot(UserRole.bishop));
      expect(merged.followerCount, 7);
    });

    test('a Bishop stays a Bishop', () {
      const local = FaithJourney(userId: 'u', currentRole: UserRole.bishop);
      const remote = FaithJourney(userId: 'u', currentRole: UserRole.preacher);
      expect(ProgressSyncService.mergeJourneys(local, remote).currentRole, UserRole.bishop);
    });
  });

  group('sync with Firestore', () {
    late LocalStorageService storage;
    late FakeFirebaseFirestore db;
    late ProgressSyncService sync;
    const uid = 'ruth';

    Future<void> settle() => Future<void>.delayed(const Duration(milliseconds: 80));

    setUp(() async {
      storage = await createTestStorage();
      db = FakeFirebaseFirestore();
      sync = ProgressSyncService(db, storage);
      await storage.createUser(UserModel(id: uid, email: 'r@x.com', displayName: 'Ruth'));
    });
    tearDown(() async {
      await sync.stop();
      await disposeTestStorage();
    });

    test('a new phone gets the progress saved from another phone', () async {
      await db.collection('users').doc(uid).collection('private').doc('progress').set({
        'journey': const FaithJourney(
          userId: uid,
          currentRole: UserRole.preacher,
          chaptersCompleted: ['Genesis 1'],
          consecutiveDays: 30,
          totalDaysRead: 45,
        ).toJson(),
        'savedVerseIds': ['John.3.16'],
        'blockedUserIds': ['troll'],
      });

      await sync.start(uid);
      await settle();

      final journey = (await storage.getFaithJourney(uid))!;
      expect(journey.chaptersCompleted, ['Genesis 1']);
      expect(journey.consecutiveDays, 30);
      final user = (await storage.getUser(uid))!;
      expect(user.savedVerseIds, ['John.3.16']);
      expect(user.blockedUserIds, ['troll']);
      expect(user.role, UserRole.preacher);
      expect(user.consecutiveReadingDays, 30);
    });

    test('reading on this phone is uploaded', () async {
      await storage.createFaithJourney(const FaithJourney(userId: uid, currentRole: UserRole.believer));
      await sync.start(uid);
      await storage.updateFaithJourney(uid, {'chaptersCompleted': ['Ruth 1'], 'chaptersRead': 1});
      await sync.flush();
      await settle();
      await sync.flush();

      final remote = (await db.collection('users').doc(uid).collection('private').doc('progress').get()).data()!;
      expect((remote['journey'] as Map)['chaptersCompleted'], ['Ruth 1']);
    });

    test('changes from another phone arrive live, including un-saving a verse', () async {
      await storage.updateUser(uid, {'savedVerseIds': ['John.3.16', 'Ps.23.1']});
      await sync.start(uid);
      await settle();

      await db.collection('users').doc(uid).collection('private').doc('progress').update({
        'savedVerseIds': ['John.3.16'],
      });
      await settle();
      expect((await storage.getUser(uid))!.savedVerseIds, ['John.3.16']);
    });
  });
}
