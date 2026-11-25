
import 'package:freezed_annotation/freezed_annotation.dart';
import 'user_model.dart';

part 'faith_journey_model.freezed.dart';
part 'faith_journey_model.g.dart';

/// Faith journey milestone
enum FaithMilestoneType {
  firstReading,
  sevenDayStreak,
  thirtyDayStreak,
  oneYearStreak,
  firstSavedVerse,
  firstBlogPost,
  firstChatMessage,
  rolePromotion,
  followerMilestone,
  custom,
}

/// Faith journey progress status
enum FaithProgressStatus {
  inProgress,
  completed,
  locked,
  skipped,
}

@freezed
abstract class FaithMilestone with _$FaithMilestone {
  const factory FaithMilestone({
    required String id,
    required String userId,
    required FaithMilestoneType type,
    required String title,
    required String description,
    String? icon,
    String? imageUrl,
    @Default(null) DateTime? achievedAt,
    @Default(false) bool isAchieved,
    @Default({}) Map<String, dynamic> metadata,
    @Default(null) DateTime? createdAt,
  }) = _FaithMilestone;

  factory FaithMilestone.fromJson(Map<String, dynamic> json) =>
      _$FaithMilestoneFromJson(json);

}

/// Faith journey progress for each role
@freezed
abstract class FaithProgress with _$FaithProgress {
  const factory FaithProgress({
    required UserRole targetRole,
    @Default(FaithProgressStatus.locked) FaithProgressStatus status,
    @Default(0) int currentProgress,
    @Default(100) int requiredProgress,
    String? description,
    @Default(null) DateTime? startedAt,
    @Default(null) DateTime? completedAt,
    @Default([]) List<FaithMilestone> milestones,
    @Default({}) Map<String, dynamic> requirements,
  }) = _FaithProgress;

  factory FaithProgress.fromJson(Map<String, dynamic> json) =>
      _$FaithProgressFromJson(json);

}

/// Complete faith journey tracking
@freezed
abstract class FaithJourney with _$FaithJourney {
  const factory FaithJourney({
    required String userId,
    required UserRole currentRole,
    @Default([]) List<FaithProgress> progressList,
    @Default([]) List<FaithMilestone> milestones,
    @Default(0) int totalDaysRead,
    @Default(0) int consecutiveDays,
    @Default(0) int longestStreak,
    @Default(0) int versesRead,
    @Default(0) int chaptersRead,
    @Default([]) List<DateTime> readingHistory,
    @Default({}) Map<String, int> bookProgress,
    @Default([]) List<String> achievements,
    @Default(null) DateTime? startedAt,
    @Default(null) DateTime? lastUpdatedAt,
    // Role progression tracking
    @Default(false) bool hasReachedBeliever,
    @Default(false) bool hasReachedPreacher,
    @Default(false) bool hasReachedShepherd,
    @Default(false) bool hasReachedBishop,
    @Default(false) bool hasPaidToSkip,
    // Bishop requirements
    @Default(0) int followerCount,
    @Default(false) bool canPostOnBlog,
    @Default(null) String? chosenTitle,
    // Premium features tracking
    @Default(false) bool hasAccessToPremiumContent,
    @Default([]) List<String> premiumFeaturesUnlocked,
  }) = _FaithJourney;

  factory FaithJourney.fromJson(Map<String, dynamic> json) =>
      _$FaithJourneyFromJson(json);

}

/// Reading habit tracking
@freezed
abstract class ReadingHabit with _$ReadingHabit {
  const factory ReadingHabit({
    required String userId,
    @Default([]) List<int> preferredHours, // 0-23
    @Default([]) List<int> preferredDays, // 0-6 (Sunday=0)
    @Default(null) DateTime? mostActiveTime,
    @Default(0) int averageReadsPerDay,
    @Default(0) int averageDurationMinutes,
    @Default([]) List<ReadingSession> recentSessions,
    @Default(null) DateTime? lastReminderSent,
    @Default(false) bool notificationsEnabled,
    @Default('09:00') String reminderTime,
    @Default(true) bool remindOnOffWorkHours,
  }) = _ReadingHabit;

  factory ReadingHabit.fromJson(Map<String, dynamic> json) =>
      _$ReadingHabitFromJson(json);

}

/// Individual reading session
@freezed
abstract class ReadingSession with _$ReadingSession {
  const factory ReadingSession({
    required String id,
    required String userId,
    required DateTime startedAt,
    @Default(null) DateTime? endedAt,
    @Default(0) int durationMinutes,
    @Default(0) int versesRead,
    @Default(0) int chaptersRead,
    String? book,
    @Default([]) List<String> verses,
    @Default(null) String? notes,
    @Default(false) bool isCompleted,
  }) = _ReadingSession;

  factory ReadingSession.fromJson(Map<String, dynamic> json) =>
      _$ReadingSessionFromJson(json);

}

/// Faith journey statistics for display
@freezed
abstract class FaithJourneyStats with _$FaithJourneyStats {
  const factory FaithJourneyStats({
    required String userId,
    required UserRole currentRole,
    required String currentRoleDisplayName,
    required int daysToNextRole,
    required double progressToNextRole,
    required String nextRoleName,
    required List<FaithMilestone> recentMilestones,
    required List<FaithProgress> roleProgress,
    required int totalReadingStreak,
    required int totalVersesRead,
    required int totalFollowers,
    @Default(false) bool canBecomeBishop,
    @Default(false) bool canPostOnBlog,
    String? chosenTitle,
    @Default([]) List<String> availableTitles,
  }) = _FaithJourneyStats;

  factory FaithJourneyStats.fromJson(Map<String, dynamic> json) =>
      _$FaithJourneyStatsFromJson(json);

}

/// Title options for users who can choose
enum AvailableTitle {
  brother,
  sister,
  servant,
  minister,
  evangelist,
  teacher,
  elder,
  deacon,
  deaconess,
  pastor,
  reverend,
  bishop,
  apostle,
}

extension AvailableTitleExtension on AvailableTitle {
  String get displayName {
    switch (this) {
      case AvailableTitle.brother:
        return 'Brother';
      case AvailableTitle.sister:
        return 'Sister';
      case AvailableTitle.servant:
        return 'Servant';
      case AvailableTitle.minister:
        return 'Minister';
      case AvailableTitle.evangelist:
        return 'Evangelist';
      case AvailableTitle.teacher:
        return 'Teacher';
      case AvailableTitle.elder:
        return 'Elder';
      case AvailableTitle.deacon:
        return 'Deacon';
      case AvailableTitle.deaconess:
        return 'Deaconess';
      case AvailableTitle.pastor:
        return 'Pastor';
      case AvailableTitle.reverend:
        return 'Reverend';
      case AvailableTitle.bishop:
        return 'Bishop';
      case AvailableTitle.apostle:
        return 'Apostle';
    }
  }

  UserRole get minimumRole {
    switch (this) {
      case AvailableTitle.brother:
      case AvailableTitle.sister:
        return UserRole.believer;
      case AvailableTitle.servant:
      case AvailableTitle.minister:
        return UserRole.preacher;
      case AvailableTitle.evangelist:
      case AvailableTitle.teacher:
        return UserRole.shepherd;
      case AvailableTitle.elder:
      case AvailableTitle.deacon:
      case AvailableTitle.deaconess:
      case AvailableTitle.pastor:
      case AvailableTitle.reverend:
        return UserRole.shepherd;
      case AvailableTitle.bishop:
      case AvailableTitle.apostle:
        return UserRole.bishop;
    }
  }
}
