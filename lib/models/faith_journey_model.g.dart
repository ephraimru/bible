// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faith_journey_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FaithMilestone _$FaithMilestoneFromJson(Map<String, dynamic> json) =>
    _FaithMilestone(
      id: json['id'] as String,
      userId: json['userId'] as String,
      type: $enumDecode(_$FaithMilestoneTypeEnumMap, json['type']),
      title: json['title'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String?,
      imageUrl: json['imageUrl'] as String?,
      achievedAt: json['achievedAt'] == null
          ? null
          : DateTime.parse(json['achievedAt'] as String),
      isAchieved: json['isAchieved'] as bool? ?? false,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$FaithMilestoneToJson(_FaithMilestone instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'type': _$FaithMilestoneTypeEnumMap[instance.type]!,
      'title': instance.title,
      'description': instance.description,
      'icon': instance.icon,
      'imageUrl': instance.imageUrl,
      'achievedAt': instance.achievedAt?.toIso8601String(),
      'isAchieved': instance.isAchieved,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$FaithMilestoneTypeEnumMap = {
  FaithMilestoneType.firstReading: 'firstReading',
  FaithMilestoneType.sevenDayStreak: 'sevenDayStreak',
  FaithMilestoneType.thirtyDayStreak: 'thirtyDayStreak',
  FaithMilestoneType.oneYearStreak: 'oneYearStreak',
  FaithMilestoneType.firstSavedVerse: 'firstSavedVerse',
  FaithMilestoneType.firstBlogPost: 'firstBlogPost',
  FaithMilestoneType.firstChatMessage: 'firstChatMessage',
  FaithMilestoneType.rolePromotion: 'rolePromotion',
  FaithMilestoneType.followerMilestone: 'followerMilestone',
  FaithMilestoneType.custom: 'custom',
};

_FaithProgress _$FaithProgressFromJson(Map<String, dynamic> json) =>
    _FaithProgress(
      targetRole: $enumDecode(_$UserRoleEnumMap, json['targetRole']),
      status:
          $enumDecodeNullable(_$FaithProgressStatusEnumMap, json['status']) ??
          FaithProgressStatus.locked,
      currentProgress: (json['currentProgress'] as num?)?.toInt() ?? 0,
      requiredProgress: (json['requiredProgress'] as num?)?.toInt() ?? 100,
      description: json['description'] as String?,
      startedAt: json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      milestones:
          (json['milestones'] as List<dynamic>?)
              ?.map((e) => FaithMilestone.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      requirements: json['requirements'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$FaithProgressToJson(_FaithProgress instance) =>
    <String, dynamic>{
      'targetRole': _$UserRoleEnumMap[instance.targetRole]!,
      'status': _$FaithProgressStatusEnumMap[instance.status]!,
      'currentProgress': instance.currentProgress,
      'requiredProgress': instance.requiredProgress,
      'description': instance.description,
      'startedAt': instance.startedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'milestones': instance.milestones.map((e) => e.toJson()).toList(),
      'requirements': instance.requirements,
    };

const _$UserRoleEnumMap = {
  UserRole.believer: 'believer',
  UserRole.preacher: 'preacher',
  UserRole.shepherd: 'shepherd',
  UserRole.bishop: 'bishop',
};

const _$FaithProgressStatusEnumMap = {
  FaithProgressStatus.inProgress: 'inProgress',
  FaithProgressStatus.completed: 'completed',
  FaithProgressStatus.locked: 'locked',
  FaithProgressStatus.skipped: 'skipped',
};

_FaithJourney _$FaithJourneyFromJson(Map<String, dynamic> json) =>
    _FaithJourney(
      userId: json['userId'] as String,
      currentRole: $enumDecode(_$UserRoleEnumMap, json['currentRole']),
      progressList:
          (json['progressList'] as List<dynamic>?)
              ?.map((e) => FaithProgress.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      milestones:
          (json['milestones'] as List<dynamic>?)
              ?.map((e) => FaithMilestone.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      totalDaysRead: (json['totalDaysRead'] as num?)?.toInt() ?? 0,
      consecutiveDays: (json['consecutiveDays'] as num?)?.toInt() ?? 0,
      longestStreak: (json['longestStreak'] as num?)?.toInt() ?? 0,
      versesRead: (json['versesRead'] as num?)?.toInt() ?? 0,
      chaptersRead: (json['chaptersRead'] as num?)?.toInt() ?? 0,
      readingHistory:
          (json['readingHistory'] as List<dynamic>?)
              ?.map((e) => DateTime.parse(e as String))
              .toList() ??
          const [],
      bookProgress:
          (json['bookProgress'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {},
      achievements:
          (json['achievements'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      startedAt: json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
      lastUpdatedAt: json['lastUpdatedAt'] == null
          ? null
          : DateTime.parse(json['lastUpdatedAt'] as String),
      lastReadingDate: json['lastReadingDate'] == null
          ? null
          : DateTime.parse(json['lastReadingDate'] as String),
      streakStartDate: json['streakStartDate'] == null
          ? null
          : DateTime.parse(json['streakStartDate'] as String),
      chaptersCompleted:
          (json['chaptersCompleted'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      hasReachedBeliever: json['hasReachedBeliever'] as bool? ?? false,
      hasReachedPreacher: json['hasReachedPreacher'] as bool? ?? false,
      hasReachedShepherd: json['hasReachedShepherd'] as bool? ?? false,
      hasReachedBishop: json['hasReachedBishop'] as bool? ?? false,
      hasPaidToSkip: json['hasPaidToSkip'] as bool? ?? false,
      followerCount: (json['followerCount'] as num?)?.toInt() ?? 0,
      canPostOnBlog: json['canPostOnBlog'] as bool? ?? false,
      chosenTitle: json['chosenTitle'] as String? ?? null,
      hasAccessToPremiumContent:
          json['hasAccessToPremiumContent'] as bool? ?? false,
      premiumFeaturesUnlocked:
          (json['premiumFeaturesUnlocked'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$FaithJourneyToJson(_FaithJourney instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'currentRole': _$UserRoleEnumMap[instance.currentRole]!,
      'progressList': instance.progressList.map((e) => e.toJson()).toList(),
      'milestones': instance.milestones.map((e) => e.toJson()).toList(),
      'totalDaysRead': instance.totalDaysRead,
      'consecutiveDays': instance.consecutiveDays,
      'longestStreak': instance.longestStreak,
      'versesRead': instance.versesRead,
      'chaptersRead': instance.chaptersRead,
      'readingHistory': instance.readingHistory
          .map((e) => e.toIso8601String())
          .toList(),
      'bookProgress': instance.bookProgress,
      'achievements': instance.achievements,
      'startedAt': instance.startedAt?.toIso8601String(),
      'lastUpdatedAt': instance.lastUpdatedAt?.toIso8601String(),
      'lastReadingDate': instance.lastReadingDate?.toIso8601String(),
      'streakStartDate': instance.streakStartDate?.toIso8601String(),
      'chaptersCompleted': instance.chaptersCompleted,
      'hasReachedBeliever': instance.hasReachedBeliever,
      'hasReachedPreacher': instance.hasReachedPreacher,
      'hasReachedShepherd': instance.hasReachedShepherd,
      'hasReachedBishop': instance.hasReachedBishop,
      'hasPaidToSkip': instance.hasPaidToSkip,
      'followerCount': instance.followerCount,
      'canPostOnBlog': instance.canPostOnBlog,
      'chosenTitle': instance.chosenTitle,
      'hasAccessToPremiumContent': instance.hasAccessToPremiumContent,
      'premiumFeaturesUnlocked': instance.premiumFeaturesUnlocked,
    };

_ReadingHabit _$ReadingHabitFromJson(Map<String, dynamic> json) =>
    _ReadingHabit(
      userId: json['userId'] as String,
      preferredHours:
          (json['preferredHours'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      preferredDays:
          (json['preferredDays'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      mostActiveTime: json['mostActiveTime'] == null
          ? null
          : DateTime.parse(json['mostActiveTime'] as String),
      averageReadsPerDay: (json['averageReadsPerDay'] as num?)?.toInt() ?? 0,
      averageDurationMinutes:
          (json['averageDurationMinutes'] as num?)?.toInt() ?? 0,
      recentSessions:
          (json['recentSessions'] as List<dynamic>?)
              ?.map((e) => ReadingSession.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      lastReminderSent: json['lastReminderSent'] == null
          ? null
          : DateTime.parse(json['lastReminderSent'] as String),
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? false,
      reminderTime: json['reminderTime'] as String? ?? '09:00',
      remindOnOffWorkHours: json['remindOnOffWorkHours'] as bool? ?? true,
    );

Map<String, dynamic> _$ReadingHabitToJson(_ReadingHabit instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'preferredHours': instance.preferredHours,
      'preferredDays': instance.preferredDays,
      'mostActiveTime': instance.mostActiveTime?.toIso8601String(),
      'averageReadsPerDay': instance.averageReadsPerDay,
      'averageDurationMinutes': instance.averageDurationMinutes,
      'recentSessions': instance.recentSessions.map((e) => e.toJson()).toList(),
      'lastReminderSent': instance.lastReminderSent?.toIso8601String(),
      'notificationsEnabled': instance.notificationsEnabled,
      'reminderTime': instance.reminderTime,
      'remindOnOffWorkHours': instance.remindOnOffWorkHours,
    };

_ReadingSession _$ReadingSessionFromJson(Map<String, dynamic> json) =>
    _ReadingSession(
      id: json['id'] as String,
      userId: json['userId'] as String,
      startedAt: DateTime.parse(json['startedAt'] as String),
      endedAt: json['endedAt'] == null
          ? null
          : DateTime.parse(json['endedAt'] as String),
      durationMinutes: (json['durationMinutes'] as num?)?.toInt() ?? 0,
      versesRead: (json['versesRead'] as num?)?.toInt() ?? 0,
      chaptersRead: (json['chaptersRead'] as num?)?.toInt() ?? 0,
      book: json['book'] as String?,
      verses:
          (json['verses'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      notes: json['notes'] as String? ?? null,
      isCompleted: json['isCompleted'] as bool? ?? false,
    );

Map<String, dynamic> _$ReadingSessionToJson(_ReadingSession instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'startedAt': instance.startedAt.toIso8601String(),
      'endedAt': instance.endedAt?.toIso8601String(),
      'durationMinutes': instance.durationMinutes,
      'versesRead': instance.versesRead,
      'chaptersRead': instance.chaptersRead,
      'book': instance.book,
      'verses': instance.verses,
      'notes': instance.notes,
      'isCompleted': instance.isCompleted,
    };

_FaithJourneyStats _$FaithJourneyStatsFromJson(Map<String, dynamic> json) =>
    _FaithJourneyStats(
      userId: json['userId'] as String,
      currentRole: $enumDecode(_$UserRoleEnumMap, json['currentRole']),
      currentRoleDisplayName: json['currentRoleDisplayName'] as String,
      daysToNextRole: (json['daysToNextRole'] as num).toInt(),
      progressToNextRole: (json['progressToNextRole'] as num).toDouble(),
      nextRoleName: json['nextRoleName'] as String,
      recentMilestones: (json['recentMilestones'] as List<dynamic>)
          .map((e) => FaithMilestone.fromJson(e as Map<String, dynamic>))
          .toList(),
      roleProgress: (json['roleProgress'] as List<dynamic>)
          .map((e) => FaithProgress.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalReadingStreak: (json['totalReadingStreak'] as num).toInt(),
      totalVersesRead: (json['totalVersesRead'] as num).toInt(),
      totalFollowers: (json['totalFollowers'] as num).toInt(),
      canBecomeBishop: json['canBecomeBishop'] as bool? ?? false,
      canPostOnBlog: json['canPostOnBlog'] as bool? ?? false,
      chosenTitle: json['chosenTitle'] as String?,
      availableTitles:
          (json['availableTitles'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$FaithJourneyStatsToJson(
  _FaithJourneyStats instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'currentRole': _$UserRoleEnumMap[instance.currentRole]!,
  'currentRoleDisplayName': instance.currentRoleDisplayName,
  'daysToNextRole': instance.daysToNextRole,
  'progressToNextRole': instance.progressToNextRole,
  'nextRoleName': instance.nextRoleName,
  'recentMilestones': instance.recentMilestones.map((e) => e.toJson()).toList(),
  'roleProgress': instance.roleProgress.map((e) => e.toJson()).toList(),
  'totalReadingStreak': instance.totalReadingStreak,
  'totalVersesRead': instance.totalVersesRead,
  'totalFollowers': instance.totalFollowers,
  'canBecomeBishop': instance.canBecomeBishop,
  'canPostOnBlog': instance.canPostOnBlog,
  'chosenTitle': instance.chosenTitle,
  'availableTitles': instance.availableTitles,
};
