
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_model.freezed.dart';
part 'chat_model.g.dart';

/// Chat message type
enum MessageType {
  text,
  image,
  voice,
  verseReference,
  prayerRequest,
}

/// Chat message status
enum MessageStatus {
  sending,
  sent,
  delivered,
  read,
  failed,
  deleted,
}

/// Chat room type
enum ChatRoomType {
  general,
  prayerGroup,
  bibleStudy,
  testimonies,
  private,
}

/// Content moderation status
enum ModerationStatus {
  pending,
  approved,
  flagged,
  rejected,
}

@freezed
abstract class ChatMessageModel with _$ChatMessageModel {
  const factory ChatMessageModel({
    required String id,
    required String roomId,
    required String senderId,
    String? senderName,
    String? senderPhotoUrl,
    required MessageType type,
    required String content,
    @Default(MessageStatus.sent) MessageStatus status,
    @Default(ModerationStatus.approved) ModerationStatus moderationStatus,
    @Default([]) List<String> likedBy,
    @Default(0) int likes,
    @Default([]) List<String> flaggedBy,
    @Default(false) bool isEdited,
    @Default(false) bool isDeleted,
    String? replyToMessageId,
    String? imageUrl,
    String? voiceUrl,
    Duration? voiceDuration,
    String? verseReference,
    @Default(null) DateTime? createdAt,
    @Default(null) DateTime? updatedAt,
    // For ML moderation
    @Default(null) double? toxicityScore,
    @Default(null) double? offensiveScore,
    @Default(null) double? politicalScore,
    @Default(false) bool requiresReview,
  }) = _ChatMessageModel;

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageModelFromJson(json);

}

/// Chat room model
@freezed
abstract class ChatRoomModel with _$ChatRoomModel {
  const factory ChatRoomModel({
    required String id,
    required String name,
    required ChatRoomType type,
    String? description,
    String? coverImageUrl,
    @Default([]) List<String> memberIds,
    @Default([]) List<String> adminIds,
    @Default([]) List<String> moderatorIds,
    @Default(0) int messageCount,
    @Default(0) int unreadCount,
    @Default(null) DateTime? lastMessageAt,
    String? lastMessageId,
    String? lastMessageSenderId,
    String? lastMessageContent,
    @Default(false) bool isPrivate,
    @Default(false) bool isArchived,
    @Default([]) List<String> tags,
    @Default({}) Map<String, DateTime> memberJoinDates,
    @Default(null) DateTime? createdAt,
    @Default(null) DateTime? updatedAt,
    // Moderation settings
    @Default(true) bool allowImages,
    @Default(true) bool allowVoice,
    @Default(true) bool autoModerate,
    @Default(0.7) double toxicityThreshold,
    @Default(0.8) double offensiveThreshold,
    @Default(0.5) double politicalThreshold,
  }) = _ChatRoomModel;

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomModelFromJson(json);

}

/// User chat presence
enum UserPresence {
  online,
  offline,
  away,
  busy,
}

@freezed
abstract class ChatPresenceModel with _$ChatPresenceModel {
  const factory ChatPresenceModel({
    required String userId,
    required String roomId,
    @Default(UserPresence.online) UserPresence presence,
    @Default(null) DateTime? lastActiveAt,
    String? lastMessageId,
    @Default(null) DateTime? joinedAt,
  }) = _ChatPresenceModel;

  factory ChatPresenceModel.fromJson(Map<String, dynamic> json) =>
      _$ChatPresenceModelFromJson(json);

}

/// Moderation report model
@freezed
abstract class ModerationReportModel with _$ModerationReportModel {
  const factory ModerationReportModel({
    required String id,
    required String messageId,
    required String roomId,
    required String reportedBy,
    required String reason,
    String? additionalNotes,
    @Default(ModerationStatus.pending) ModerationStatus status,
    String? reviewedBy,
    @Default(null) DateTime? createdAt,
    @Default(null) DateTime? reviewedAt,
    @Default(false) bool actionTaken,
    String? actionDescription,
  }) = _ModerationReportModel;

  factory ModerationReportModel.fromJson(Map<String, dynamic> json) =>
      _$ModerationReportModelFromJson(json);

}

/// Chat notification model
@freezed
abstract class ChatNotificationModel with _$ChatNotificationModel {
  const factory ChatNotificationModel({
    required String id,
    required String userId,
    required String roomId,
    required String messageId,
    String? senderId,
    String? senderName,
    String? messagePreview,
    @Default(false) bool isRead,
    @Default(null) DateTime? createdAt,
    MessageType? messageType,
  }) = _ChatNotificationModel;

  factory ChatNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$ChatNotificationModelFromJson(json);

}
