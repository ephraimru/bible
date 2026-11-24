// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatMessageModel _$ChatMessageModelFromJson(
  Map<String, dynamic> json,
) => _ChatMessageModel(
  id: json['id'] as String,
  roomId: json['roomId'] as String,
  senderId: json['senderId'] as String,
  senderName: json['senderName'] as String?,
  senderPhotoUrl: json['senderPhotoUrl'] as String?,
  type: $enumDecode(_$MessageTypeEnumMap, json['type']),
  content: json['content'] as String,
  status:
      $enumDecodeNullable(_$MessageStatusEnumMap, json['status']) ??
      MessageStatus.sent,
  moderationStatus:
      $enumDecodeNullable(
        _$ModerationStatusEnumMap,
        json['moderationStatus'],
      ) ??
      ModerationStatus.approved,
  likedBy:
      (json['likedBy'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  likes: (json['likes'] as num?)?.toInt() ?? 0,
  flaggedBy:
      (json['flaggedBy'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  isEdited: json['isEdited'] as bool? ?? false,
  isDeleted: json['isDeleted'] as bool? ?? false,
  replyToMessageId: json['replyToMessageId'] as String?,
  imageUrl: json['imageUrl'] as String?,
  voiceUrl: json['voiceUrl'] as String?,
  voiceDuration: json['voiceDuration'] == null
      ? null
      : Duration(microseconds: (json['voiceDuration'] as num).toInt()),
  verseReference: json['verseReference'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  toxicityScore: (json['toxicityScore'] as num?)?.toDouble() ?? null,
  offensiveScore: (json['offensiveScore'] as num?)?.toDouble() ?? null,
  politicalScore: (json['politicalScore'] as num?)?.toDouble() ?? null,
  requiresReview: json['requiresReview'] as bool? ?? false,
);

Map<String, dynamic> _$ChatMessageModelToJson(_ChatMessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roomId': instance.roomId,
      'senderId': instance.senderId,
      'senderName': instance.senderName,
      'senderPhotoUrl': instance.senderPhotoUrl,
      'type': _$MessageTypeEnumMap[instance.type]!,
      'content': instance.content,
      'status': _$MessageStatusEnumMap[instance.status]!,
      'moderationStatus': _$ModerationStatusEnumMap[instance.moderationStatus]!,
      'likedBy': instance.likedBy,
      'likes': instance.likes,
      'flaggedBy': instance.flaggedBy,
      'isEdited': instance.isEdited,
      'isDeleted': instance.isDeleted,
      'replyToMessageId': instance.replyToMessageId,
      'imageUrl': instance.imageUrl,
      'voiceUrl': instance.voiceUrl,
      'voiceDuration': instance.voiceDuration?.inMicroseconds,
      'verseReference': instance.verseReference,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'toxicityScore': instance.toxicityScore,
      'offensiveScore': instance.offensiveScore,
      'politicalScore': instance.politicalScore,
      'requiresReview': instance.requiresReview,
    };

const _$MessageTypeEnumMap = {
  MessageType.text: 'text',
  MessageType.image: 'image',
  MessageType.voice: 'voice',
  MessageType.verseReference: 'verseReference',
  MessageType.prayerRequest: 'prayerRequest',
};

const _$MessageStatusEnumMap = {
  MessageStatus.sending: 'sending',
  MessageStatus.sent: 'sent',
  MessageStatus.delivered: 'delivered',
  MessageStatus.read: 'read',
  MessageStatus.failed: 'failed',
  MessageStatus.deleted: 'deleted',
};

const _$ModerationStatusEnumMap = {
  ModerationStatus.pending: 'pending',
  ModerationStatus.approved: 'approved',
  ModerationStatus.flagged: 'flagged',
  ModerationStatus.rejected: 'rejected',
};

_ChatRoomModel _$ChatRoomModelFromJson(
  Map<String, dynamic> json,
) => _ChatRoomModel(
  id: json['id'] as String,
  name: json['name'] as String,
  type: $enumDecode(_$ChatRoomTypeEnumMap, json['type']),
  description: json['description'] as String?,
  coverImageUrl: json['coverImageUrl'] as String?,
  memberIds:
      (json['memberIds'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  adminIds:
      (json['adminIds'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  moderatorIds:
      (json['moderatorIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  messageCount: (json['messageCount'] as num?)?.toInt() ?? 0,
  unreadCount: (json['unreadCount'] as num?)?.toInt() ?? 0,
  lastMessageAt: json['lastMessageAt'] == null
      ? null
      : DateTime.parse(json['lastMessageAt'] as String),
  lastMessageId: json['lastMessageId'] as String?,
  lastMessageSenderId: json['lastMessageSenderId'] as String?,
  lastMessageContent: json['lastMessageContent'] as String?,
  isPrivate: json['isPrivate'] as bool? ?? false,
  isArchived: json['isArchived'] as bool? ?? false,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  memberJoinDates:
      (json['memberJoinDates'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, DateTime.parse(e as String)),
      ) ??
      const {},
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  allowImages: json['allowImages'] as bool? ?? true,
  allowVoice: json['allowVoice'] as bool? ?? true,
  autoModerate: json['autoModerate'] as bool? ?? true,
  toxicityThreshold: (json['toxicityThreshold'] as num?)?.toDouble() ?? 0.7,
  offensiveThreshold: (json['offensiveThreshold'] as num?)?.toDouble() ?? 0.8,
  politicalThreshold: (json['politicalThreshold'] as num?)?.toDouble() ?? 0.5,
);

Map<String, dynamic> _$ChatRoomModelToJson(_ChatRoomModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$ChatRoomTypeEnumMap[instance.type]!,
      'description': instance.description,
      'coverImageUrl': instance.coverImageUrl,
      'memberIds': instance.memberIds,
      'adminIds': instance.adminIds,
      'moderatorIds': instance.moderatorIds,
      'messageCount': instance.messageCount,
      'unreadCount': instance.unreadCount,
      'lastMessageAt': instance.lastMessageAt?.toIso8601String(),
      'lastMessageId': instance.lastMessageId,
      'lastMessageSenderId': instance.lastMessageSenderId,
      'lastMessageContent': instance.lastMessageContent,
      'isPrivate': instance.isPrivate,
      'isArchived': instance.isArchived,
      'tags': instance.tags,
      'memberJoinDates': instance.memberJoinDates.map(
        (k, e) => MapEntry(k, e.toIso8601String()),
      ),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'allowImages': instance.allowImages,
      'allowVoice': instance.allowVoice,
      'autoModerate': instance.autoModerate,
      'toxicityThreshold': instance.toxicityThreshold,
      'offensiveThreshold': instance.offensiveThreshold,
      'politicalThreshold': instance.politicalThreshold,
    };

const _$ChatRoomTypeEnumMap = {
  ChatRoomType.general: 'general',
  ChatRoomType.prayerGroup: 'prayerGroup',
  ChatRoomType.bibleStudy: 'bibleStudy',
  ChatRoomType.testimonies: 'testimonies',
  ChatRoomType.private: 'private',
};

_ChatPresenceModel _$ChatPresenceModelFromJson(Map<String, dynamic> json) =>
    _ChatPresenceModel(
      userId: json['userId'] as String,
      roomId: json['roomId'] as String,
      presence:
          $enumDecodeNullable(_$UserPresenceEnumMap, json['presence']) ??
          UserPresence.online,
      lastActiveAt: json['lastActiveAt'] == null
          ? null
          : DateTime.parse(json['lastActiveAt'] as String),
      lastMessageId: json['lastMessageId'] as String?,
      joinedAt: json['joinedAt'] == null
          ? null
          : DateTime.parse(json['joinedAt'] as String),
    );

Map<String, dynamic> _$ChatPresenceModelToJson(_ChatPresenceModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'roomId': instance.roomId,
      'presence': _$UserPresenceEnumMap[instance.presence]!,
      'lastActiveAt': instance.lastActiveAt?.toIso8601String(),
      'lastMessageId': instance.lastMessageId,
      'joinedAt': instance.joinedAt?.toIso8601String(),
    };

const _$UserPresenceEnumMap = {
  UserPresence.online: 'online',
  UserPresence.offline: 'offline',
  UserPresence.away: 'away',
  UserPresence.busy: 'busy',
};

_ModerationReportModel _$ModerationReportModelFromJson(
  Map<String, dynamic> json,
) => _ModerationReportModel(
  id: json['id'] as String,
  messageId: json['messageId'] as String,
  roomId: json['roomId'] as String,
  reportedBy: json['reportedBy'] as String,
  reason: json['reason'] as String,
  additionalNotes: json['additionalNotes'] as String?,
  status:
      $enumDecodeNullable(_$ModerationStatusEnumMap, json['status']) ??
      ModerationStatus.pending,
  reviewedBy: json['reviewedBy'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  reviewedAt: json['reviewedAt'] == null
      ? null
      : DateTime.parse(json['reviewedAt'] as String),
  actionTaken: json['actionTaken'] as bool? ?? false,
  actionDescription: json['actionDescription'] as String?,
);

Map<String, dynamic> _$ModerationReportModelToJson(
  _ModerationReportModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'messageId': instance.messageId,
  'roomId': instance.roomId,
  'reportedBy': instance.reportedBy,
  'reason': instance.reason,
  'additionalNotes': instance.additionalNotes,
  'status': _$ModerationStatusEnumMap[instance.status]!,
  'reviewedBy': instance.reviewedBy,
  'createdAt': instance.createdAt?.toIso8601String(),
  'reviewedAt': instance.reviewedAt?.toIso8601String(),
  'actionTaken': instance.actionTaken,
  'actionDescription': instance.actionDescription,
};

_ChatNotificationModel _$ChatNotificationModelFromJson(
  Map<String, dynamic> json,
) => _ChatNotificationModel(
  id: json['id'] as String,
  userId: json['userId'] as String,
  roomId: json['roomId'] as String,
  messageId: json['messageId'] as String,
  senderId: json['senderId'] as String?,
  senderName: json['senderName'] as String?,
  messagePreview: json['messagePreview'] as String?,
  isRead: json['isRead'] as bool? ?? false,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  messageType: $enumDecodeNullable(_$MessageTypeEnumMap, json['messageType']),
);

Map<String, dynamic> _$ChatNotificationModelToJson(
  _ChatNotificationModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'roomId': instance.roomId,
  'messageId': instance.messageId,
  'senderId': instance.senderId,
  'senderName': instance.senderName,
  'messagePreview': instance.messagePreview,
  'isRead': instance.isRead,
  'createdAt': instance.createdAt?.toIso8601String(),
  'messageType': _$MessageTypeEnumMap[instance.messageType],
};
