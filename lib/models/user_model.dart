import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// User roles in the faith journey
enum UserRole {
  believer,
  preacher,
  shepherd,
  bishop,
}

/// User status for tracking
enum UserStatus {
  active,
  inactive,
  suspended,
  banned,
}

/// Premium subscription tier
enum PremiumTier {
  free,
  basic,
  pro,
  bishop,
}

extension PremiumTierExtension on PremiumTier {
  String get displayName {
    switch (this) {
      case PremiumTier.free:
        return 'Free';
      case PremiumTier.basic:
        return 'Basic';
      case PremiumTier.pro:
        return 'Pro';
      case PremiumTier.bishop:
        return 'Bishop';
    }
  }
}

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    required String displayName,
    String? photoUrl,
    String? bio,
    @Default(UserRole.believer) UserRole role,
    @Default(PremiumTier.free) PremiumTier premiumTier,
    @Default(UserStatus.active) UserStatus status,
    @Default(0) int followingCount,
    @Default(0) int followersCount,
    @Default(0) int savedVersesCount,
    @Default(0) int likedVersesCount,
    @Default(0) int blogPostsCount,
    @Default([]) List<String> savedVerseIds,
    @Default([]) List<String> likedVerseIds,
    @Default([]) List<String> bookmarkedBlogPostIds,
    @Default({}) Map<String, dynamic> readingStats,
    @Default(0) int consecutiveReadingDays,
    @Default(0) int totalReadingDays,
    @Default(0) int streakStartDate,
    @Default([]) List<String> badges,
    @Default(false) bool hasPaidToSkipLadder,
    @Default(null) DateTime? lastReadingDate,
    @Default(null) DateTime? lastNotificationDate,
    @Default(null) String? chosenTitle,
    @Default([]) List<String> blockedUserIds,
    @Default({}) Map<String, bool> preferences,
    @Default(null) DateTime? createdAt,
    @Default(null) DateTime? updatedAt,
    // Reading habit tracking
    @Default([]) List<int> readingHours, // Hours of day user typically reads
    @Default([]) List<int> readingDays, // Days of week (0-6, Sunday=0)
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel.fromJson({...data, 'id': doc.id});
  }
}

/// Extension for role progression logic
extension UserRoleExtension on UserRole {
  int get level {
    switch (this) {
      case UserRole.believer:
        return 1;
      case UserRole.preacher:
        return 2;
      case UserRole.shepherd:
        return 3;
      case UserRole.bishop:
        return 4;
    }
  }

  String get displayName {
    switch (this) {
      case UserRole.believer:
        return 'Believer';
      case UserRole.preacher:
        return 'Preacher';
      case UserRole.shepherd:
        return 'Shepherd';
      case UserRole.bishop:
        return 'Bishop';
    }
  }

  /// Requirements to reach this role
  Map<String, dynamic> get requirements {
    switch (this) {
      case UserRole.believer:
        return {'days': 7, 'description': 'Read for 7 consecutive days'};
      case UserRole.preacher:
        return {'days': 30, 'description': 'Read for 30 consecutive days'};
      case UserRole.shepherd:
        return {'days': 365, 'description': 'Read for 1 year'};
      case UserRole.bishop:
        return {
          'followers': 1000,
          'description': 'Have 1000+ followers or pay to skip'
        };
    }
  }
}

/// Reading statistics model
@freezed
class ReadingStats with _$ReadingStats {
  const factory ReadingStats({
    @Default(0) int totalVersesRead,
    @Default(0) int totalChaptersRead,
    @Default(0) int totalBooksRead,
    @Default({}) Map<String, int> bookProgress,
    @Default({}) Map<String, DateTime> lastRead,
    @Default(0) int longestStreak,
    @Default([]) List<DateTime> readingHistory,
  }) = _ReadingStats;

  factory ReadingStats.fromJson(Map<String, dynamic> json) =>
      _$ReadingStatsFromJson(json);
}
