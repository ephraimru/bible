import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../models/user_model.dart';
import '../models/faith_journey_model.dart';
import 'local_storage_service.dart';
import 'bible_service.dart';
import 'auth_service.dart';
import 'notification_service.dart';

// Faith Journey Service Provider
final faithJourneyServiceProvider = Provider<FaithJourneyService>((ref) {
  return FaithJourneyService(
    localStorageService: ref.read(localStorageServiceProvider),
    bibleService: ref.read(bibleServiceProvider),
    notificationService: ref.read(notificationServiceProvider),
  );
});

// Faith Journey Stream Provider
final faithJourneyStreamProvider = StreamProvider<FaithJourney?>((ref) {
  // Re-subscribe whenever a different user signs in.
  final userId = ref.watch(authStateProvider).value?.id ??
      ref.read(authServiceProvider).currentUserId;
  if (userId == null) return Stream.value(null);
  
  return ref.read(faithJourneyServiceProvider).streamFaithJourney(userId);
});

// Faith Journey Stats Provider
final faithJourneyStatsProvider = Provider<FaithJourneyStats?>((ref) {
  final journey = ref.watch(faithJourneyStreamProvider).value;
  if (journey == null) return null;
  
  return ref.read(faithJourneyServiceProvider).getFaithJourneyStats(journey);
});

class FaithJourneyService {
  final LocalStorageService _localStorageService;
  final BibleService _bibleService;
  final NotificationService _notificationService;

  FaithJourneyService({
    required LocalStorageService localStorageService,
    required BibleService bibleService,
    required NotificationService notificationService,
  })  : _localStorageService = localStorageService,
        _bibleService = bibleService,
        _notificationService = notificationService;

  // ============ FAITH JOURNEY MANAGEMENT ============

  /// Get faith journey for a user
  Future<FaithJourney?> getFaithJourney(String userId) async {
    return _localStorageService.getFaithJourney(userId);
  }

  /// Stream faith journey for a user
  Stream<FaithJourney?> streamFaithJourney(String userId) {
    return _localStorageService.streamFaithJourney(userId);
  }

  /// Create faith journey for a new user
  Future<void> createFaithJourney(String userId) async {
    final journey = FaithJourney(
      userId: userId,
      currentRole: UserRole.believer,
      progressList: _getInitialProgressList(),
      milestones: [],
      startedAt: DateTime.now(),
      lastUpdatedAt: DateTime.now(),
    );
    
    await _localStorageService.createFaithJourney(journey);
  }

  /// Get initial progress list for a new user
  List<FaithProgress> _getInitialProgressList() {
    return [
      FaithProgress(
        targetRole: UserRole.believer,
        status: FaithProgressStatus.completed,
        currentProgress: 7,
        requiredProgress: 7,
        description: 'Read for 7 consecutive days to become a Believer',
        startedAt: DateTime.now(),
        completedAt: DateTime.now(),
      ),
      FaithProgress(
        targetRole: UserRole.preacher,
        status: FaithProgressStatus.locked,
        currentProgress: 0,
        requiredProgress: 30,
        description: 'Read for 30 consecutive days to become a Preacher',
      ),
      FaithProgress(
        targetRole: UserRole.shepherd,
        status: FaithProgressStatus.locked,
        currentProgress: 0,
        requiredProgress: 365,
        description: 'Read for 1 year to become a Shepherd',
      ),
      FaithProgress(
        targetRole: UserRole.bishop,
        status: FaithProgressStatus.locked,
        currentProgress: 0,
        requiredProgress: 1000,
        description: 'Have 1000+ followers or pay to skip to become a Bishop',
      ),
    ];
  }

  /// Records that [userId] read [book] [chapter] ([versesCount] verses).
  ///
  /// Streaks count calendar days: reading several chapters on the same day
  /// extends the streak only once; missing a day resets it to 1.
  Future<void> updateReadingProgress({
    required String userId,
    required String book,
    required int chapter,
    int verse = 1,
    required int versesCount,
  }) async {
    var journey = await getFaithJourney(userId);
    if (journey == null) {
      await createFaithJourney(userId);
      journey = await getFaithJourney(userId);
      if (journey == null) return;
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final last = journey.lastReadingDate;
    final daysSinceLast = last == null
        ? null
        : today.difference(DateTime(last.year, last.month, last.day)).inDays;

    var consecutiveDays = journey.consecutiveDays;
    var totalDaysRead = journey.totalDaysRead;
    var streakStart = journey.streakStartDate;
    if (daysSinceLast == null || daysSinceLast > 1) {
      consecutiveDays = 1; // first reading, or the streak was broken
      totalDaysRead += 1;
      streakStart = today;
    } else if (daysSinceLast == 1) {
      consecutiveDays += 1;
      totalDaysRead += 1;
    } // daysSinceLast == 0: already counted today
    final longestStreak =
        consecutiveDays > journey.longestStreak ? consecutiveDays : journey.longestStreak;

    final chapterKey = '$book $chapter';
    final isNewChapter = !journey.chaptersCompleted.contains(chapterKey);
    final bookProgress = Map<String, int>.from(journey.bookProgress);
    if (isNewChapter) bookProgress[book] = (bookProgress[book] ?? 0) + 1;

    await _localStorageService.updateFaithJourney(userId, {
      'versesRead': journey.versesRead + (isNewChapter ? versesCount : 0),
      'chaptersRead': journey.chaptersRead + (isNewChapter ? 1 : 0),
      'chaptersCompleted':
          isNewChapter ? [...journey.chaptersCompleted, chapterKey] : journey.chaptersCompleted,
      'bookProgress': bookProgress,
      'consecutiveDays': consecutiveDays,
      'longestStreak': longestStreak,
      'totalDaysRead': totalDaysRead,
      'lastReadingDate': now,
      'streakStartDate': streakStart,
      'readingHistory': [
        ...journey.readingHistory.where((d) => now.difference(d).inDays < 400),
        now,
      ],
    });

    // Mirror the headline numbers on the user profile.
    final user = await _localStorageService.getUser(userId);
    if (user != null) {
      await _localStorageService.updateUser(userId, {
        'lastReadingDate': now,
        'consecutiveReadingDays': consecutiveDays,
        'totalReadingDays': totalDaysRead,
      });
    }

    await _checkRoleProgression(userId);
    try {
      await _checkAndSendNotifications(userId);
    } catch (_) {
      // Notifications are best-effort (unsupported on some platforms).
    }
  }

  /// Whether [userId] has already marked [book] [chapter] as read.
  Future<bool> isChapterCompleted(String userId, String book, int chapter) async {
    final journey = await getFaithJourney(userId);
    return journey?.chaptersCompleted.contains('$book $chapter') ?? false;
  }

  /// Check role progression
  Future<void> _checkRoleProgression(String userId) async {
    final journey = await getFaithJourney(userId);
    final user = await _localStorageService.getUser(userId);
    
    if (journey == null || user == null) return;
    
    // Streak-based promotion only: Preacher (30 days) and Shepherd (365 days).
    // Bishop needs 1000+ followers or a verified purchase (see promoteToBishop).
    final nextRole = getNextRole(journey);
    final requiredDays = nextRole?.requirements['days'] as int?;
    final shouldPromote =
        requiredDays != null && journey.consecutiveDays >= requiredDays;

    if (shouldPromote && nextRole != null) {
      // Update user role
      await _localStorageService.updateUser(userId, {'role': nextRole});
      
      // Update faith journey
      await _localStorageService.updateFaithJourney(userId, {
        'currentRole': nextRole,
        'hasReached${nextRole.name.capitalize()}': true,
      });

      // Send notification
      await _notificationService.sendNotification(
        userId: userId,
        title: 'Congratulations!',
        body: 'You have been promoted to ${nextRole.displayName}!',
        data: {
          'type': 'role_promotion',
          'newRole': nextRole.name,
        },
      );
    }
  }

  /// Check and send notifications based on progress
  Future<void> _checkAndSendNotifications(String userId) async {
    final journey = await getFaithJourney(userId);
    final user = await _localStorageService.getUser(userId);
    
    if (journey == null || user == null) return;
    
    final currentRole = journey.currentRole;
    
    // Check for milestone achievements
    final milestones = await _checkMilestones(userId, journey);
    
    for (final milestone in milestones) {
      await _notificationService.sendNotification(
        userId: userId,
        title: 'Faith Journey Milestone!',
        body: milestone.title,
        data: {
          'type': 'milestone',
          'milestoneType': milestone.type.name,
        },
      );
    }
    
    // Check for role promotion notifications
    if (currentRole == UserRole.believer && !journey.hasReachedPreacher) {
      final daysLeft = 30 - journey.consecutiveDays;
      if (daysLeft <= 7 && daysLeft > 0) {
        await _notificationService.sendNotification(
          userId: userId,
          title: 'Almost There!',
          body: 'Only $daysLeft more days of reading to become a Preacher!',
          data: {'type': 'role_progress', 'targetRole': 'preacher'},
        );
      }
    }
    
    if (currentRole == UserRole.preacher && !journey.hasReachedShepherd) {
      final daysLeft = 365 - journey.consecutiveDays;
      if (daysLeft <= 30 && daysLeft > 0) {
        await _notificationService.sendNotification(
          userId: userId,
          title: 'Keep Going!',
          body: 'Only $daysLeft more days to become a Shepherd!',
          data: {'type': 'role_progress', 'targetRole': 'shepherd'},
        );
      }
    }
    
    // Check for bishop eligibility
    if (user.role != UserRole.bishop && 
        user.followersCount >= 1000 &&
        !user.hasPaidToSkipLadder) {
      await _notificationService.sendNotification(
        userId: userId,
        title: 'Bishop Eligibility!',
        body: 'You now have 1000+ followers and are eligible to become a Bishop!',
        data: {
          'type': 'bishop_eligibility',
          'followers': user.followersCount,
        },
      );
    }
  }

  /// Check for milestone achievements
  Future<List<FaithMilestone>> _checkMilestones(
    String userId,
    FaithJourney journey,
  ) async {
    final milestones = <FaithMilestone>[];
    final now = DateTime.now();
    
    // Check if milestones are already achieved
    final achievedMilestoneTypes = journey.milestones.map((m) => m.type).toSet();
    
    // Check for first reading
    if (journey.versesRead >= 1 && !achievedMilestoneTypes.contains(FaithMilestoneType.firstReading)) {
      milestones.add(
        FaithMilestone(
          id: '',
          userId: userId,
          type: FaithMilestoneType.firstReading,
          title: 'First Bible Reading',
          description: 'You have read your first Bible verse! Welcome to your faith journey.',
          achievedAt: now,
          isAchieved: true,
          createdAt: now,
        ),
      );
    }
    
    // Check for 7-day streak
    if (journey.consecutiveDays >= 7 && !journey.hasReachedBeliever && !achievedMilestoneTypes.contains(FaithMilestoneType.sevenDayStreak)) {
      milestones.add(
        FaithMilestone(
          id: '',
          userId: userId,
          type: FaithMilestoneType.sevenDayStreak,
          title: '7-Day Reading Streak',
          description: 'You have read the Bible for 7 consecutive days! You are now a Believer.',
          achievedAt: now,
          isAchieved: true,
          createdAt: now,
        ),
      );
    }
    
    // Check for 30-day streak
    if (journey.consecutiveDays >= 30 && !journey.hasReachedPreacher && !achievedMilestoneTypes.contains(FaithMilestoneType.thirtyDayStreak)) {
      milestones.add(
        FaithMilestone(
          id: '',
          userId: userId,
          type: FaithMilestoneType.thirtyDayStreak,
          title: '30-Day Reading Streak',
          description: 'You have read the Bible for 30 consecutive days! You are now a Preacher.',
          achievedAt: now,
          isAchieved: true,
          createdAt: now,
        ),
      );
    }
    
    // Check for 1-year streak
    if (journey.consecutiveDays >= 365 && !journey.hasReachedShepherd && !achievedMilestoneTypes.contains(FaithMilestoneType.oneYearStreak)) {
      milestones.add(
        FaithMilestone(
          id: '',
          userId: userId,
          type: FaithMilestoneType.oneYearStreak,
          title: '1-Year Reading Streak',
          description: 'You have read the Bible for 1 year! You are now a Shepherd.',
          achievedAt: now,
          isAchieved: true,
          createdAt: now,
        ),
      );
    }
    
    // Check for first saved verse
    final userModel = await _localStorageService.getUser(userId);
    if (userModel != null && userModel.savedVersesCount >= 1 && !achievedMilestoneTypes.contains(FaithMilestoneType.firstSavedVerse)) {
      milestones.add(
        FaithMilestone(
          id: '',
          userId: userId,
          type: FaithMilestoneType.firstSavedVerse,
          title: 'First Saved Verse',
          description: 'You have saved your first Bible verse!',
          achievedAt: now,
          isAchieved: true,
          createdAt: now,
        ),
      );
    }
    
    // Save milestones to faith journey
    if (milestones.isNotEmpty) {
      final allMilestones = [...journey.milestones, ...milestones];
      await _localStorageService.updateFaithJourney(userId, {
        'milestones': allMilestones.map((m) => m.toJson()).toList(),
      });
    }
    
    return milestones;
  }

  // ============ ROLE PROGRESSION ============

  /// Get current role progress
  FaithProgress getCurrentRoleProgress(FaithJourney journey) {
    return journey.progressList.firstWhere(
      (progress) => progress.status == FaithProgressStatus.inProgress,
      orElse: () => journey.progressList.first,
    );
  }

  /// Get next role to achieve
  UserRole? getNextRole(FaithJourney journey) {
    final currentRole = journey.currentRole;
    
    switch (currentRole) {
      case UserRole.believer:
        return UserRole.preacher;
      case UserRole.preacher:
        return UserRole.shepherd;
      case UserRole.shepherd:
        return UserRole.bishop;
      case UserRole.bishop:
        return null; // No next role
    }
  }

  /// Get progress to next role
  Map<String, dynamic> getProgressToNextRole(FaithJourney journey) {
    final currentRole = journey.currentRole;
    final nextRole = getNextRole(journey);
    
    if (nextRole == null) {
      return {
        'hasNextRole': false,
        'progress': 1.0,
        'currentRole': currentRole.displayName,
      };
    }
    
    final requiredDays = nextRole.requirements['days'] as int?;
    if (requiredDays == null) {
      // Bishop: measured in followers rather than reading days.
      const requiredFollowers = 1000;
      return {
        'hasNextRole': true,
        'nextRole': nextRole.displayName,
        'progress': (journey.followerCount / requiredFollowers).clamp(0.0, 1.0),
        'current': journey.followerCount,
        'required': requiredFollowers,
        'description': nextRole.requirements['description'],
      };
    }

    return {
      'hasNextRole': true,
      'nextRole': nextRole.displayName,
      'progress': (journey.consecutiveDays / requiredDays).clamp(0.0, 1.0),
      'current': journey.consecutiveDays,
      'required': requiredDays,
      'description': nextRole.requirements['description'],
    };
  }

  // ============ FAITH JOURNEY STATISTICS ============

  /// Get faith journey statistics for display
  FaithJourneyStats getFaithJourneyStats(FaithJourney journey) {
    final userId = journey.userId;
    final currentRole = journey.currentRole;
    final nextRole = getNextRole(journey);
    final progressToNext = getProgressToNextRole(journey);
    
    // Get recent milestones
    final recentMilestones = journey.milestones
        .where((m) => m.isAchieved)
        .toList()
      ..sort((a, b) => b.achievedAt?.compareTo(a.achievedAt ?? DateTime.now()) ?? 0);
    
    // Get role progress
    final roleProgress = journey.progressList
        .map((p) => p.copyWith(
              description: p.targetRole.requirements['description'] ?? '',
            ))
        .toList();
    
    // Calculate days to next role (0 for Bishop, which isn't streak-based)
    final requiredDays = nextRole?.requirements['days'] as int?;
    final daysToNextRole = requiredDays == null
        ? 0
        : (requiredDays - journey.consecutiveDays).clamp(0, requiredDays);

    // Get available titles
    List<String> availableTitles = [];
    if (currentRole == UserRole.bishop) {
      availableTitles = AvailableTitle.values
          .where((t) => t.minimumRole.index <= currentRole.index)
          .map((t) => t.displayName)
          .toList();
    } else if (currentRole == UserRole.shepherd) {
      availableTitles = AvailableTitle.values
          .where((t) => t.minimumRole.index <= UserRole.shepherd.index)
          .map((t) => t.displayName)
          .toList();
    }
    
    return FaithJourneyStats(
      userId: userId,
      currentRole: currentRole,
      currentRoleDisplayName: currentRole.displayName,
      daysToNextRole: daysToNextRole,
      progressToNextRole: (progressToNext['progress'] as num?)?.toDouble() ?? 0.0,
      nextRoleName: nextRole?.displayName ?? currentRole.displayName,
      recentMilestones: recentMilestones.take(5).toList(),
      roleProgress: roleProgress,
      totalReadingStreak: journey.consecutiveDays,
      totalVersesRead: journey.versesRead,
      totalFollowers: 0, // Will be populated from user data
      canBecomeBishop: nextRole == UserRole.bishop,
      canPostOnBlog: journey.canPostOnBlog || currentRole == UserRole.bishop,
      chosenTitle: journey.chosenTitle,
      availableTitles: availableTitles,
    );
  }

  // ============ READING HABIT TRACKING ============

  /// Get reading habit for user
  Future<ReadingHabit?> getReadingHabit(String userId) async {
    return _localStorageService.getReadingHabit(userId);
  }

  /// Update reading habit
  Future<void> updateReadingHabit(String userId, {
    List<int>? preferredHours,
    List<int>? preferredDays,
    bool? notificationsEnabled,
    String? reminderTime,
    bool? remindOnOffWorkHours,
  }) async {
    final updates = <String, dynamic>{'updatedAt': DateTime.now()};
    
    if (preferredHours != null) {
      updates['preferredHours'] = preferredHours;
    }
    if (preferredDays != null) {
      updates['preferredDays'] = preferredDays;
    }
    if (notificationsEnabled != null) {
      updates['notificationsEnabled'] = notificationsEnabled;
    }
    if (reminderTime != null) {
      updates['reminderTime'] = reminderTime;
    }
    if (remindOnOffWorkHours != null) {
      updates['remindOnOffWorkHours'] = remindOnOffWorkHours;
    }
    
    await _localStorageService.updateReadingHabit(userId, updates);
  }

  /// Record reading session
  Future<void> recordReadingSession(ReadingSession session) async {
    final habit = await getReadingHabit(session.userId);
    
    final recent = [...?habit?.recentSessions, session];
    final trimmed = recent.length > 10 ? recent.sublist(recent.length - 10) : recent;
    final hours = {...?habit?.preferredHours, session.startedAt.hour}.toList()..sort();
    final days = {...?habit?.preferredDays, session.startedAt.weekday % 7}.toList()..sort();

    await _localStorageService.updateReadingHabit(session.userId, {
      'recentSessions': trimmed,
      'preferredHours': hours,
      'preferredDays': days,
      'averageDurationMinutes': trimmed.isEmpty
          ? 0
          : trimmed.map((s) => s.durationMinutes).reduce((a, b) => a + b) ~/ trimmed.length,
    });
    await _localStorageService.recordReadingSession(session);
  }

  /// Get preferred reading times
  Future<List<String>> getPreferredReadingTimes(String userId) async {
    final habit = await getReadingHabit(userId);
    if (habit == null) return [];
    
    final times = <String>[];
    for (final hour in habit.preferredHours) {
      final time = DateTime(2024, 1, 1, hour);
      final formatted = DateFormat('h:mm a').format(time);
      times.add(formatted);
    }
    
    return times;
  }

  /// Get preferred reading days
  Future<List<String>> getPreferredReadingDays(String userId) async {
    final habit = await getReadingHabit(userId);
    if (habit == null) return [];
    
    const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    
    return habit.preferredDays
        .map((index) => days[index % days.length])
        .toList();
  }

  /// Get reading streak information
  Future<Map<String, dynamic>> getReadingStreak(String userId) async {
    final journey = await getFaithJourney(userId);
    if (journey == null) return {};
    
    final streakStart = journey.streakStartDate;

    return {
      'consecutiveDays': journey.consecutiveDays,
      'longestStreak': journey.longestStreak,
      'streakStart': streakStart,
      'totalDaysRead': journey.totalDaysRead,
      'lastReadingDate': journey.lastReadingDate,
    };
  }

  // ============ BISHOP FEATURES ============

  /// Check if user can become a bishop
  Future<bool> canBecomeBishop(String userId) async {
    final user = await _localStorageService.getUser(userId);
    if (user == null) return false;
    
    return user.followersCount >= 1000 || user.hasPaidToSkipLadder;
  }

  /// Promote user to bishop
  Future<void> promoteToBishop(String userId) async {
    final user = await _localStorageService.getUser(userId);
    if (user == null) return;
    
    if (user.followersCount >= 1000) {
      await _localStorageService.updateUser(userId, {
        'role': UserRole.bishop.name,
        'canPostOnBlog': true,
        'updatedAt': DateTime.now(),
      });
      
      final journey = await getFaithJourney(userId);
      if (journey != null) {
        await _localStorageService.updateFaithJourney(userId, {
          'currentRole': UserRole.bishop.name,
          'hasReachedBishop': true,
          'canPostOnBlog': true,
          'updatedAt': DateTime.now(),
        });
      }
    }
  }

  /// Set user's chosen title
  Future<void> setChosenTitle(String userId, String title) async {
    await _localStorageService.updateUser(userId, {
      'chosenTitle': title,
      'updatedAt': DateTime.now(),
    });
    
    final journey = await getFaithJourney(userId);
    if (journey != null) {
      await _localStorageService.updateFaithJourney(userId, {
        'chosenTitle': title,
        'updatedAt': DateTime.now(),
      });
    }
  }

  /// Get available titles for user
  Future<List<String>> getAvailableTitles(String userId) async {
    final user = await _localStorageService.getUser(userId);
    if (user == null) return [];
    
    final currentRole = user.role;
    
    return AvailableTitle.values
        .where((t) => t.minimumRole.index <= currentRole.index)
        .map((t) => t.displayName)
        .toList();
  }

  // ============ NOTIFICATIONS ============

  /// Setup reading reminders
  Future<void> setupReadingReminders(String userId) async {
    final habit = await getReadingHabit(userId);
    if (habit == null || !habit.notificationsEnabled) return;
    
    // Schedule daily reminder
    await _notificationService.scheduleDailyNotification(
      userId: userId,
      hour: int.tryParse(habit.reminderTime.split(':')[0]) ?? 9,
      minute: int.tryParse(habit.reminderTime.split(':')[1]) ?? 0,
      title: 'Daily Bible Reading Reminder',
      body: 'Don\'t forget to read your Bible today!',
      data: {'type': 'reading_reminder'},
    );
    
    // Schedule off-work hours reminder if enabled
    if (habit.remindOnOffWorkHours) {
      // Typical off-work hours: 6 PM - 8 PM
      for (int hour = 18; hour <= 20; hour++) {
        await _notificationService.scheduleDailyNotification(
          userId: userId,
          hour: hour,
          minute: 0,
          title: 'Read Your Bible',
          body: 'This is a great time to read God\'s Word!',
          data: {'type': 'reading_reminder'},
        );
      }
    }
  }

  /// Send milestone notification
  Future<void> sendMilestoneNotification({
    required String userId,
    required FaithMilestoneType milestoneType,
    String? title,
    String? description,
  }) async {
    final milestoneTitle = title ?? _getMilestoneTitle(milestoneType);
    final milestoneDescription = description ?? _getMilestoneDescription(milestoneType);
    
    await _notificationService.sendNotification(
      userId: userId,
      title: 'Faith Journey Achievement!',
      body: milestoneTitle,
      data: {
        'type': 'milestone',
        'milestoneType': milestoneType.name,
        'title': milestoneTitle,
        'description': milestoneDescription,
      },
    );
  }

  String _getMilestoneTitle(FaithMilestoneType type) {
    switch (type) {
      case FaithMilestoneType.firstReading:
        return 'First Bible Reading';
      case FaithMilestoneType.sevenDayStreak:
        return '7-Day Reading Streak';
      case FaithMilestoneType.thirtyDayStreak:
        return '30-Day Reading Streak';
      case FaithMilestoneType.oneYearStreak:
        return '1-Year Reading Streak';
      case FaithMilestoneType.firstSavedVerse:
        return 'First Saved Verse';
      case FaithMilestoneType.firstBlogPost:
        return 'First Blog Post';
      case FaithMilestoneType.firstChatMessage:
        return 'First Chat Message';
      case FaithMilestoneType.rolePromotion:
        return 'Role Promotion';
      case FaithMilestoneType.followerMilestone:
        return 'Follower Milestone';
      case FaithMilestoneType.custom:
        return 'Custom Milestone';
    }
  }

  String _getMilestoneDescription(FaithMilestoneType type) {
    switch (type) {
      case FaithMilestoneType.firstReading:
        return 'You have read your first Bible verse! Welcome to your faith journey.';
      case FaithMilestoneType.sevenDayStreak:
        return 'You have read the Bible for 7 consecutive days! You are now a Believer.';
      case FaithMilestoneType.thirtyDayStreak:
        return 'You have read the Bible for 30 consecutive days! You are now a Preacher.';
      case FaithMilestoneType.oneYearStreak:
        return 'You have read the Bible for 1 year! You are now a Shepherd.';
      case FaithMilestoneType.firstSavedVerse:
        return 'You have saved your first Bible verse!';
      case FaithMilestoneType.firstBlogPost:
        return 'You have published your first blog post!';
      case FaithMilestoneType.firstChatMessage:
        return 'You have sent your first chat message!';
      case FaithMilestoneType.rolePromotion:
        return 'You have been promoted to a new role in your faith journey!';
      case FaithMilestoneType.followerMilestone:
        return 'You have reached a follower milestone!';
      case FaithMilestoneType.custom:
        return 'You have achieved a custom milestone!';
    }
  }
}

extension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}
