// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: json['id'] as String,
  email: json['email'] as String,
  displayName: json['displayName'] as String,
  photoUrl: json['photoUrl'] as String?,
  bio: json['bio'] as String?,
  role:
      $enumDecodeNullable(_$UserRoleEnumMap, json['role']) ?? UserRole.believer,
  premiumTier:
      $enumDecodeNullable(_$PremiumTierEnumMap, json['premiumTier']) ??
      PremiumTier.free,
  status:
      $enumDecodeNullable(_$UserStatusEnumMap, json['status']) ??
      UserStatus.active,
  followingCount: (json['followingCount'] as num?)?.toInt() ?? 0,
  followersCount: (json['followersCount'] as num?)?.toInt() ?? 0,
  savedVersesCount: (json['savedVersesCount'] as num?)?.toInt() ?? 0,
  likedVersesCount: (json['likedVersesCount'] as num?)?.toInt() ?? 0,
  blogPostsCount: (json['blogPostsCount'] as num?)?.toInt() ?? 0,
  savedVerseIds:
      (json['savedVerseIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  likedVerseIds:
      (json['likedVerseIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  bookmarkedBlogPostIds:
      (json['bookmarkedBlogPostIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  followingUserIds:
      (json['followingUserIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  readingStats: json['readingStats'] as Map<String, dynamic>? ?? const {},
  consecutiveReadingDays:
      (json['consecutiveReadingDays'] as num?)?.toInt() ?? 0,
  totalReadingDays: (json['totalReadingDays'] as num?)?.toInt() ?? 0,
  streakStartDate: (json['streakStartDate'] as num?)?.toInt() ?? 0,
  badges:
      (json['badges'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  hasPaidToSkipLadder: json['hasPaidToSkipLadder'] as bool? ?? false,
  canPostOnBlog: json['canPostOnBlog'] as bool? ?? false,
  suspensionEndDate: json['suspensionEndDate'] == null
      ? null
      : DateTime.parse(json['suspensionEndDate'] as String),
  lastReadingDate: json['lastReadingDate'] == null
      ? null
      : DateTime.parse(json['lastReadingDate'] as String),
  lastNotificationDate: json['lastNotificationDate'] == null
      ? null
      : DateTime.parse(json['lastNotificationDate'] as String),
  chosenTitle: json['chosenTitle'] as String? ?? null,
  blockedUserIds:
      (json['blockedUserIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  preferences: json['preferences'] as Map<String, dynamic>? ?? const {},
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  readingHours:
      (json['readingHours'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  readingDays:
      (json['readingDays'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'displayName': instance.displayName,
      'photoUrl': instance.photoUrl,
      'bio': instance.bio,
      'role': _$UserRoleEnumMap[instance.role]!,
      'premiumTier': _$PremiumTierEnumMap[instance.premiumTier]!,
      'status': _$UserStatusEnumMap[instance.status]!,
      'followingCount': instance.followingCount,
      'followersCount': instance.followersCount,
      'savedVersesCount': instance.savedVersesCount,
      'likedVersesCount': instance.likedVersesCount,
      'blogPostsCount': instance.blogPostsCount,
      'savedVerseIds': instance.savedVerseIds,
      'likedVerseIds': instance.likedVerseIds,
      'bookmarkedBlogPostIds': instance.bookmarkedBlogPostIds,
      'followingUserIds': instance.followingUserIds,
      'readingStats': instance.readingStats,
      'consecutiveReadingDays': instance.consecutiveReadingDays,
      'totalReadingDays': instance.totalReadingDays,
      'streakStartDate': instance.streakStartDate,
      'badges': instance.badges,
      'hasPaidToSkipLadder': instance.hasPaidToSkipLadder,
      'canPostOnBlog': instance.canPostOnBlog,
      'suspensionEndDate': instance.suspensionEndDate?.toIso8601String(),
      'lastReadingDate': instance.lastReadingDate?.toIso8601String(),
      'lastNotificationDate': instance.lastNotificationDate?.toIso8601String(),
      'chosenTitle': instance.chosenTitle,
      'blockedUserIds': instance.blockedUserIds,
      'preferences': instance.preferences,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'readingHours': instance.readingHours,
      'readingDays': instance.readingDays,
    };

const _$UserRoleEnumMap = {
  UserRole.believer: 'believer',
  UserRole.preacher: 'preacher',
  UserRole.shepherd: 'shepherd',
  UserRole.bishop: 'bishop',
};

const _$PremiumTierEnumMap = {
  PremiumTier.free: 'free',
  PremiumTier.basic: 'basic',
  PremiumTier.pro: 'pro',
  PremiumTier.bishop: 'bishop',
};

const _$UserStatusEnumMap = {
  UserStatus.active: 'active',
  UserStatus.inactive: 'inactive',
  UserStatus.suspended: 'suspended',
  UserStatus.banned: 'banned',
};

_ReadingStats _$ReadingStatsFromJson(Map<String, dynamic> json) =>
    _ReadingStats(
      totalVersesRead: (json['totalVersesRead'] as num?)?.toInt() ?? 0,
      totalChaptersRead: (json['totalChaptersRead'] as num?)?.toInt() ?? 0,
      totalBooksRead: (json['totalBooksRead'] as num?)?.toInt() ?? 0,
      bookProgress:
          (json['bookProgress'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {},
      lastRead:
          (json['lastRead'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, DateTime.parse(e as String)),
          ) ??
          const {},
      longestStreak: (json['longestStreak'] as num?)?.toInt() ?? 0,
      readingHistory:
          (json['readingHistory'] as List<dynamic>?)
              ?.map((e) => DateTime.parse(e as String))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ReadingStatsToJson(
  _ReadingStats instance,
) => <String, dynamic>{
  'totalVersesRead': instance.totalVersesRead,
  'totalChaptersRead': instance.totalChaptersRead,
  'totalBooksRead': instance.totalBooksRead,
  'bookProgress': instance.bookProgress,
  'lastRead': instance.lastRead.map((k, e) => MapEntry(k, e.toIso8601String())),
  'longestStreak': instance.longestStreak,
  'readingHistory': instance.readingHistory
      .map((e) => e.toIso8601String())
      .toList(),
};
