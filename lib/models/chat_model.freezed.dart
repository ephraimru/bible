// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatMessageModel {

 String get id; String get roomId; String get senderId; String? get senderName; String? get senderPhotoUrl; MessageType get type; String get content; MessageStatus get status; ModerationStatus get moderationStatus; List<String> get likedBy; int get likes; List<String> get flaggedBy; bool get isEdited; bool get isDeleted; String? get replyToMessageId; String? get imageUrl; String? get voiceUrl; Duration? get voiceDuration; String? get verseReference; DateTime? get createdAt; DateTime? get updatedAt;// For ML moderation
 double? get toxicityScore; double? get offensiveScore; double? get politicalScore; bool get requiresReview;
/// Create a copy of ChatMessageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMessageModelCopyWith<ChatMessageModel> get copyWith => _$ChatMessageModelCopyWithImpl<ChatMessageModel>(this as ChatMessageModel, _$identity);

  /// Serializes this ChatMessageModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMessageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.senderPhotoUrl, senderPhotoUrl) || other.senderPhotoUrl == senderPhotoUrl)&&(identical(other.type, type) || other.type == type)&&(identical(other.content, content) || other.content == content)&&(identical(other.status, status) || other.status == status)&&(identical(other.moderationStatus, moderationStatus) || other.moderationStatus == moderationStatus)&&const DeepCollectionEquality().equals(other.likedBy, likedBy)&&(identical(other.likes, likes) || other.likes == likes)&&const DeepCollectionEquality().equals(other.flaggedBy, flaggedBy)&&(identical(other.isEdited, isEdited) || other.isEdited == isEdited)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.replyToMessageId, replyToMessageId) || other.replyToMessageId == replyToMessageId)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.voiceUrl, voiceUrl) || other.voiceUrl == voiceUrl)&&(identical(other.voiceDuration, voiceDuration) || other.voiceDuration == voiceDuration)&&(identical(other.verseReference, verseReference) || other.verseReference == verseReference)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.toxicityScore, toxicityScore) || other.toxicityScore == toxicityScore)&&(identical(other.offensiveScore, offensiveScore) || other.offensiveScore == offensiveScore)&&(identical(other.politicalScore, politicalScore) || other.politicalScore == politicalScore)&&(identical(other.requiresReview, requiresReview) || other.requiresReview == requiresReview));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,roomId,senderId,senderName,senderPhotoUrl,type,content,status,moderationStatus,const DeepCollectionEquality().hash(likedBy),likes,const DeepCollectionEquality().hash(flaggedBy),isEdited,isDeleted,replyToMessageId,imageUrl,voiceUrl,voiceDuration,verseReference,createdAt,updatedAt,toxicityScore,offensiveScore,politicalScore,requiresReview]);

@override
String toString() {
  return 'ChatMessageModel(id: $id, roomId: $roomId, senderId: $senderId, senderName: $senderName, senderPhotoUrl: $senderPhotoUrl, type: $type, content: $content, status: $status, moderationStatus: $moderationStatus, likedBy: $likedBy, likes: $likes, flaggedBy: $flaggedBy, isEdited: $isEdited, isDeleted: $isDeleted, replyToMessageId: $replyToMessageId, imageUrl: $imageUrl, voiceUrl: $voiceUrl, voiceDuration: $voiceDuration, verseReference: $verseReference, createdAt: $createdAt, updatedAt: $updatedAt, toxicityScore: $toxicityScore, offensiveScore: $offensiveScore, politicalScore: $politicalScore, requiresReview: $requiresReview)';
}


}

/// @nodoc
abstract mixin class $ChatMessageModelCopyWith<$Res>  {
  factory $ChatMessageModelCopyWith(ChatMessageModel value, $Res Function(ChatMessageModel) _then) = _$ChatMessageModelCopyWithImpl;
@useResult
$Res call({
 String id, String roomId, String senderId, String? senderName, String? senderPhotoUrl, MessageType type, String content, MessageStatus status, ModerationStatus moderationStatus, List<String> likedBy, int likes, List<String> flaggedBy, bool isEdited, bool isDeleted, String? replyToMessageId, String? imageUrl, String? voiceUrl, Duration? voiceDuration, String? verseReference, DateTime? createdAt, DateTime? updatedAt, double? toxicityScore, double? offensiveScore, double? politicalScore, bool requiresReview
});




}
/// @nodoc
class _$ChatMessageModelCopyWithImpl<$Res>
    implements $ChatMessageModelCopyWith<$Res> {
  _$ChatMessageModelCopyWithImpl(this._self, this._then);

  final ChatMessageModel _self;
  final $Res Function(ChatMessageModel) _then;

/// Create a copy of ChatMessageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? roomId = null,Object? senderId = null,Object? senderName = freezed,Object? senderPhotoUrl = freezed,Object? type = null,Object? content = null,Object? status = null,Object? moderationStatus = null,Object? likedBy = null,Object? likes = null,Object? flaggedBy = null,Object? isEdited = null,Object? isDeleted = null,Object? replyToMessageId = freezed,Object? imageUrl = freezed,Object? voiceUrl = freezed,Object? voiceDuration = freezed,Object? verseReference = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? toxicityScore = freezed,Object? offensiveScore = freezed,Object? politicalScore = freezed,Object? requiresReview = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,senderName: freezed == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String?,senderPhotoUrl: freezed == senderPhotoUrl ? _self.senderPhotoUrl : senderPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MessageType,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MessageStatus,moderationStatus: null == moderationStatus ? _self.moderationStatus : moderationStatus // ignore: cast_nullable_to_non_nullable
as ModerationStatus,likedBy: null == likedBy ? _self.likedBy : likedBy // ignore: cast_nullable_to_non_nullable
as List<String>,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,flaggedBy: null == flaggedBy ? _self.flaggedBy : flaggedBy // ignore: cast_nullable_to_non_nullable
as List<String>,isEdited: null == isEdited ? _self.isEdited : isEdited // ignore: cast_nullable_to_non_nullable
as bool,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,replyToMessageId: freezed == replyToMessageId ? _self.replyToMessageId : replyToMessageId // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,voiceUrl: freezed == voiceUrl ? _self.voiceUrl : voiceUrl // ignore: cast_nullable_to_non_nullable
as String?,voiceDuration: freezed == voiceDuration ? _self.voiceDuration : voiceDuration // ignore: cast_nullable_to_non_nullable
as Duration?,verseReference: freezed == verseReference ? _self.verseReference : verseReference // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,toxicityScore: freezed == toxicityScore ? _self.toxicityScore : toxicityScore // ignore: cast_nullable_to_non_nullable
as double?,offensiveScore: freezed == offensiveScore ? _self.offensiveScore : offensiveScore // ignore: cast_nullable_to_non_nullable
as double?,politicalScore: freezed == politicalScore ? _self.politicalScore : politicalScore // ignore: cast_nullable_to_non_nullable
as double?,requiresReview: null == requiresReview ? _self.requiresReview : requiresReview // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatMessageModel].
extension ChatMessageModelPatterns on ChatMessageModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatMessageModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatMessageModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatMessageModel value)  $default,){
final _that = this;
switch (_that) {
case _ChatMessageModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatMessageModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChatMessageModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String roomId,  String senderId,  String? senderName,  String? senderPhotoUrl,  MessageType type,  String content,  MessageStatus status,  ModerationStatus moderationStatus,  List<String> likedBy,  int likes,  List<String> flaggedBy,  bool isEdited,  bool isDeleted,  String? replyToMessageId,  String? imageUrl,  String? voiceUrl,  Duration? voiceDuration,  String? verseReference,  DateTime? createdAt,  DateTime? updatedAt,  double? toxicityScore,  double? offensiveScore,  double? politicalScore,  bool requiresReview)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatMessageModel() when $default != null:
return $default(_that.id,_that.roomId,_that.senderId,_that.senderName,_that.senderPhotoUrl,_that.type,_that.content,_that.status,_that.moderationStatus,_that.likedBy,_that.likes,_that.flaggedBy,_that.isEdited,_that.isDeleted,_that.replyToMessageId,_that.imageUrl,_that.voiceUrl,_that.voiceDuration,_that.verseReference,_that.createdAt,_that.updatedAt,_that.toxicityScore,_that.offensiveScore,_that.politicalScore,_that.requiresReview);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String roomId,  String senderId,  String? senderName,  String? senderPhotoUrl,  MessageType type,  String content,  MessageStatus status,  ModerationStatus moderationStatus,  List<String> likedBy,  int likes,  List<String> flaggedBy,  bool isEdited,  bool isDeleted,  String? replyToMessageId,  String? imageUrl,  String? voiceUrl,  Duration? voiceDuration,  String? verseReference,  DateTime? createdAt,  DateTime? updatedAt,  double? toxicityScore,  double? offensiveScore,  double? politicalScore,  bool requiresReview)  $default,) {final _that = this;
switch (_that) {
case _ChatMessageModel():
return $default(_that.id,_that.roomId,_that.senderId,_that.senderName,_that.senderPhotoUrl,_that.type,_that.content,_that.status,_that.moderationStatus,_that.likedBy,_that.likes,_that.flaggedBy,_that.isEdited,_that.isDeleted,_that.replyToMessageId,_that.imageUrl,_that.voiceUrl,_that.voiceDuration,_that.verseReference,_that.createdAt,_that.updatedAt,_that.toxicityScore,_that.offensiveScore,_that.politicalScore,_that.requiresReview);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String roomId,  String senderId,  String? senderName,  String? senderPhotoUrl,  MessageType type,  String content,  MessageStatus status,  ModerationStatus moderationStatus,  List<String> likedBy,  int likes,  List<String> flaggedBy,  bool isEdited,  bool isDeleted,  String? replyToMessageId,  String? imageUrl,  String? voiceUrl,  Duration? voiceDuration,  String? verseReference,  DateTime? createdAt,  DateTime? updatedAt,  double? toxicityScore,  double? offensiveScore,  double? politicalScore,  bool requiresReview)?  $default,) {final _that = this;
switch (_that) {
case _ChatMessageModel() when $default != null:
return $default(_that.id,_that.roomId,_that.senderId,_that.senderName,_that.senderPhotoUrl,_that.type,_that.content,_that.status,_that.moderationStatus,_that.likedBy,_that.likes,_that.flaggedBy,_that.isEdited,_that.isDeleted,_that.replyToMessageId,_that.imageUrl,_that.voiceUrl,_that.voiceDuration,_that.verseReference,_that.createdAt,_that.updatedAt,_that.toxicityScore,_that.offensiveScore,_that.politicalScore,_that.requiresReview);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatMessageModel implements ChatMessageModel {
  const _ChatMessageModel({required this.id, required this.roomId, required this.senderId, this.senderName, this.senderPhotoUrl, required this.type, required this.content, this.status = MessageStatus.sent, this.moderationStatus = ModerationStatus.approved, final  List<String> likedBy = const [], this.likes = 0, final  List<String> flaggedBy = const [], this.isEdited = false, this.isDeleted = false, this.replyToMessageId, this.imageUrl, this.voiceUrl, this.voiceDuration, this.verseReference, this.createdAt = null, this.updatedAt = null, this.toxicityScore = null, this.offensiveScore = null, this.politicalScore = null, this.requiresReview = false}): _likedBy = likedBy,_flaggedBy = flaggedBy;
  factory _ChatMessageModel.fromJson(Map<String, dynamic> json) => _$ChatMessageModelFromJson(json);

@override final  String id;
@override final  String roomId;
@override final  String senderId;
@override final  String? senderName;
@override final  String? senderPhotoUrl;
@override final  MessageType type;
@override final  String content;
@override@JsonKey() final  MessageStatus status;
@override@JsonKey() final  ModerationStatus moderationStatus;
 final  List<String> _likedBy;
@override@JsonKey() List<String> get likedBy {
  if (_likedBy is EqualUnmodifiableListView) return _likedBy;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_likedBy);
}

@override@JsonKey() final  int likes;
 final  List<String> _flaggedBy;
@override@JsonKey() List<String> get flaggedBy {
  if (_flaggedBy is EqualUnmodifiableListView) return _flaggedBy;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_flaggedBy);
}

@override@JsonKey() final  bool isEdited;
@override@JsonKey() final  bool isDeleted;
@override final  String? replyToMessageId;
@override final  String? imageUrl;
@override final  String? voiceUrl;
@override final  Duration? voiceDuration;
@override final  String? verseReference;
@override@JsonKey() final  DateTime? createdAt;
@override@JsonKey() final  DateTime? updatedAt;
// For ML moderation
@override@JsonKey() final  double? toxicityScore;
@override@JsonKey() final  double? offensiveScore;
@override@JsonKey() final  double? politicalScore;
@override@JsonKey() final  bool requiresReview;

/// Create a copy of ChatMessageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMessageModelCopyWith<_ChatMessageModel> get copyWith => __$ChatMessageModelCopyWithImpl<_ChatMessageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatMessageModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMessageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.senderPhotoUrl, senderPhotoUrl) || other.senderPhotoUrl == senderPhotoUrl)&&(identical(other.type, type) || other.type == type)&&(identical(other.content, content) || other.content == content)&&(identical(other.status, status) || other.status == status)&&(identical(other.moderationStatus, moderationStatus) || other.moderationStatus == moderationStatus)&&const DeepCollectionEquality().equals(other._likedBy, _likedBy)&&(identical(other.likes, likes) || other.likes == likes)&&const DeepCollectionEquality().equals(other._flaggedBy, _flaggedBy)&&(identical(other.isEdited, isEdited) || other.isEdited == isEdited)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.replyToMessageId, replyToMessageId) || other.replyToMessageId == replyToMessageId)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.voiceUrl, voiceUrl) || other.voiceUrl == voiceUrl)&&(identical(other.voiceDuration, voiceDuration) || other.voiceDuration == voiceDuration)&&(identical(other.verseReference, verseReference) || other.verseReference == verseReference)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.toxicityScore, toxicityScore) || other.toxicityScore == toxicityScore)&&(identical(other.offensiveScore, offensiveScore) || other.offensiveScore == offensiveScore)&&(identical(other.politicalScore, politicalScore) || other.politicalScore == politicalScore)&&(identical(other.requiresReview, requiresReview) || other.requiresReview == requiresReview));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,roomId,senderId,senderName,senderPhotoUrl,type,content,status,moderationStatus,const DeepCollectionEquality().hash(_likedBy),likes,const DeepCollectionEquality().hash(_flaggedBy),isEdited,isDeleted,replyToMessageId,imageUrl,voiceUrl,voiceDuration,verseReference,createdAt,updatedAt,toxicityScore,offensiveScore,politicalScore,requiresReview]);

@override
String toString() {
  return 'ChatMessageModel(id: $id, roomId: $roomId, senderId: $senderId, senderName: $senderName, senderPhotoUrl: $senderPhotoUrl, type: $type, content: $content, status: $status, moderationStatus: $moderationStatus, likedBy: $likedBy, likes: $likes, flaggedBy: $flaggedBy, isEdited: $isEdited, isDeleted: $isDeleted, replyToMessageId: $replyToMessageId, imageUrl: $imageUrl, voiceUrl: $voiceUrl, voiceDuration: $voiceDuration, verseReference: $verseReference, createdAt: $createdAt, updatedAt: $updatedAt, toxicityScore: $toxicityScore, offensiveScore: $offensiveScore, politicalScore: $politicalScore, requiresReview: $requiresReview)';
}


}

/// @nodoc
abstract mixin class _$ChatMessageModelCopyWith<$Res> implements $ChatMessageModelCopyWith<$Res> {
  factory _$ChatMessageModelCopyWith(_ChatMessageModel value, $Res Function(_ChatMessageModel) _then) = __$ChatMessageModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String roomId, String senderId, String? senderName, String? senderPhotoUrl, MessageType type, String content, MessageStatus status, ModerationStatus moderationStatus, List<String> likedBy, int likes, List<String> flaggedBy, bool isEdited, bool isDeleted, String? replyToMessageId, String? imageUrl, String? voiceUrl, Duration? voiceDuration, String? verseReference, DateTime? createdAt, DateTime? updatedAt, double? toxicityScore, double? offensiveScore, double? politicalScore, bool requiresReview
});




}
/// @nodoc
class __$ChatMessageModelCopyWithImpl<$Res>
    implements _$ChatMessageModelCopyWith<$Res> {
  __$ChatMessageModelCopyWithImpl(this._self, this._then);

  final _ChatMessageModel _self;
  final $Res Function(_ChatMessageModel) _then;

/// Create a copy of ChatMessageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? roomId = null,Object? senderId = null,Object? senderName = freezed,Object? senderPhotoUrl = freezed,Object? type = null,Object? content = null,Object? status = null,Object? moderationStatus = null,Object? likedBy = null,Object? likes = null,Object? flaggedBy = null,Object? isEdited = null,Object? isDeleted = null,Object? replyToMessageId = freezed,Object? imageUrl = freezed,Object? voiceUrl = freezed,Object? voiceDuration = freezed,Object? verseReference = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? toxicityScore = freezed,Object? offensiveScore = freezed,Object? politicalScore = freezed,Object? requiresReview = null,}) {
  return _then(_ChatMessageModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,senderName: freezed == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String?,senderPhotoUrl: freezed == senderPhotoUrl ? _self.senderPhotoUrl : senderPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MessageType,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MessageStatus,moderationStatus: null == moderationStatus ? _self.moderationStatus : moderationStatus // ignore: cast_nullable_to_non_nullable
as ModerationStatus,likedBy: null == likedBy ? _self._likedBy : likedBy // ignore: cast_nullable_to_non_nullable
as List<String>,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,flaggedBy: null == flaggedBy ? _self._flaggedBy : flaggedBy // ignore: cast_nullable_to_non_nullable
as List<String>,isEdited: null == isEdited ? _self.isEdited : isEdited // ignore: cast_nullable_to_non_nullable
as bool,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,replyToMessageId: freezed == replyToMessageId ? _self.replyToMessageId : replyToMessageId // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,voiceUrl: freezed == voiceUrl ? _self.voiceUrl : voiceUrl // ignore: cast_nullable_to_non_nullable
as String?,voiceDuration: freezed == voiceDuration ? _self.voiceDuration : voiceDuration // ignore: cast_nullable_to_non_nullable
as Duration?,verseReference: freezed == verseReference ? _self.verseReference : verseReference // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,toxicityScore: freezed == toxicityScore ? _self.toxicityScore : toxicityScore // ignore: cast_nullable_to_non_nullable
as double?,offensiveScore: freezed == offensiveScore ? _self.offensiveScore : offensiveScore // ignore: cast_nullable_to_non_nullable
as double?,politicalScore: freezed == politicalScore ? _self.politicalScore : politicalScore // ignore: cast_nullable_to_non_nullable
as double?,requiresReview: null == requiresReview ? _self.requiresReview : requiresReview // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ChatRoomModel {

 String get id; String get name; ChatRoomType get type; String? get description; String? get coverImageUrl; List<String> get memberIds; List<String> get adminIds; List<String> get moderatorIds; int get messageCount; int get unreadCount; DateTime? get lastMessageAt; String? get lastMessageId; String? get lastMessageSenderId; String? get lastMessageContent; bool get isPrivate; bool get isArchived; List<String> get tags; Map<String, DateTime> get memberJoinDates; DateTime? get createdAt; DateTime? get updatedAt;// Moderation settings
 bool get allowImages; bool get allowVoice; bool get autoModerate; double get toxicityThreshold; double get offensiveThreshold; double get politicalThreshold;
/// Create a copy of ChatRoomModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatRoomModelCopyWith<ChatRoomModel> get copyWith => _$ChatRoomModelCopyWithImpl<ChatRoomModel>(this as ChatRoomModel, _$identity);

  /// Serializes this ChatRoomModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatRoomModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.description, description) || other.description == description)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&const DeepCollectionEquality().equals(other.memberIds, memberIds)&&const DeepCollectionEquality().equals(other.adminIds, adminIds)&&const DeepCollectionEquality().equals(other.moderatorIds, moderatorIds)&&(identical(other.messageCount, messageCount) || other.messageCount == messageCount)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount)&&(identical(other.lastMessageAt, lastMessageAt) || other.lastMessageAt == lastMessageAt)&&(identical(other.lastMessageId, lastMessageId) || other.lastMessageId == lastMessageId)&&(identical(other.lastMessageSenderId, lastMessageSenderId) || other.lastMessageSenderId == lastMessageSenderId)&&(identical(other.lastMessageContent, lastMessageContent) || other.lastMessageContent == lastMessageContent)&&(identical(other.isPrivate, isPrivate) || other.isPrivate == isPrivate)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived)&&const DeepCollectionEquality().equals(other.tags, tags)&&const DeepCollectionEquality().equals(other.memberJoinDates, memberJoinDates)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.allowImages, allowImages) || other.allowImages == allowImages)&&(identical(other.allowVoice, allowVoice) || other.allowVoice == allowVoice)&&(identical(other.autoModerate, autoModerate) || other.autoModerate == autoModerate)&&(identical(other.toxicityThreshold, toxicityThreshold) || other.toxicityThreshold == toxicityThreshold)&&(identical(other.offensiveThreshold, offensiveThreshold) || other.offensiveThreshold == offensiveThreshold)&&(identical(other.politicalThreshold, politicalThreshold) || other.politicalThreshold == politicalThreshold));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,type,description,coverImageUrl,const DeepCollectionEquality().hash(memberIds),const DeepCollectionEquality().hash(adminIds),const DeepCollectionEquality().hash(moderatorIds),messageCount,unreadCount,lastMessageAt,lastMessageId,lastMessageSenderId,lastMessageContent,isPrivate,isArchived,const DeepCollectionEquality().hash(tags),const DeepCollectionEquality().hash(memberJoinDates),createdAt,updatedAt,allowImages,allowVoice,autoModerate,toxicityThreshold,offensiveThreshold,politicalThreshold]);

@override
String toString() {
  return 'ChatRoomModel(id: $id, name: $name, type: $type, description: $description, coverImageUrl: $coverImageUrl, memberIds: $memberIds, adminIds: $adminIds, moderatorIds: $moderatorIds, messageCount: $messageCount, unreadCount: $unreadCount, lastMessageAt: $lastMessageAt, lastMessageId: $lastMessageId, lastMessageSenderId: $lastMessageSenderId, lastMessageContent: $lastMessageContent, isPrivate: $isPrivate, isArchived: $isArchived, tags: $tags, memberJoinDates: $memberJoinDates, createdAt: $createdAt, updatedAt: $updatedAt, allowImages: $allowImages, allowVoice: $allowVoice, autoModerate: $autoModerate, toxicityThreshold: $toxicityThreshold, offensiveThreshold: $offensiveThreshold, politicalThreshold: $politicalThreshold)';
}


}

/// @nodoc
abstract mixin class $ChatRoomModelCopyWith<$Res>  {
  factory $ChatRoomModelCopyWith(ChatRoomModel value, $Res Function(ChatRoomModel) _then) = _$ChatRoomModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, ChatRoomType type, String? description, String? coverImageUrl, List<String> memberIds, List<String> adminIds, List<String> moderatorIds, int messageCount, int unreadCount, DateTime? lastMessageAt, String? lastMessageId, String? lastMessageSenderId, String? lastMessageContent, bool isPrivate, bool isArchived, List<String> tags, Map<String, DateTime> memberJoinDates, DateTime? createdAt, DateTime? updatedAt, bool allowImages, bool allowVoice, bool autoModerate, double toxicityThreshold, double offensiveThreshold, double politicalThreshold
});




}
/// @nodoc
class _$ChatRoomModelCopyWithImpl<$Res>
    implements $ChatRoomModelCopyWith<$Res> {
  _$ChatRoomModelCopyWithImpl(this._self, this._then);

  final ChatRoomModel _self;
  final $Res Function(ChatRoomModel) _then;

/// Create a copy of ChatRoomModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? type = null,Object? description = freezed,Object? coverImageUrl = freezed,Object? memberIds = null,Object? adminIds = null,Object? moderatorIds = null,Object? messageCount = null,Object? unreadCount = null,Object? lastMessageAt = freezed,Object? lastMessageId = freezed,Object? lastMessageSenderId = freezed,Object? lastMessageContent = freezed,Object? isPrivate = null,Object? isArchived = null,Object? tags = null,Object? memberJoinDates = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? allowImages = null,Object? allowVoice = null,Object? autoModerate = null,Object? toxicityThreshold = null,Object? offensiveThreshold = null,Object? politicalThreshold = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ChatRoomType,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,memberIds: null == memberIds ? _self.memberIds : memberIds // ignore: cast_nullable_to_non_nullable
as List<String>,adminIds: null == adminIds ? _self.adminIds : adminIds // ignore: cast_nullable_to_non_nullable
as List<String>,moderatorIds: null == moderatorIds ? _self.moderatorIds : moderatorIds // ignore: cast_nullable_to_non_nullable
as List<String>,messageCount: null == messageCount ? _self.messageCount : messageCount // ignore: cast_nullable_to_non_nullable
as int,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,lastMessageAt: freezed == lastMessageAt ? _self.lastMessageAt : lastMessageAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastMessageId: freezed == lastMessageId ? _self.lastMessageId : lastMessageId // ignore: cast_nullable_to_non_nullable
as String?,lastMessageSenderId: freezed == lastMessageSenderId ? _self.lastMessageSenderId : lastMessageSenderId // ignore: cast_nullable_to_non_nullable
as String?,lastMessageContent: freezed == lastMessageContent ? _self.lastMessageContent : lastMessageContent // ignore: cast_nullable_to_non_nullable
as String?,isPrivate: null == isPrivate ? _self.isPrivate : isPrivate // ignore: cast_nullable_to_non_nullable
as bool,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,memberJoinDates: null == memberJoinDates ? _self.memberJoinDates : memberJoinDates // ignore: cast_nullable_to_non_nullable
as Map<String, DateTime>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,allowImages: null == allowImages ? _self.allowImages : allowImages // ignore: cast_nullable_to_non_nullable
as bool,allowVoice: null == allowVoice ? _self.allowVoice : allowVoice // ignore: cast_nullable_to_non_nullable
as bool,autoModerate: null == autoModerate ? _self.autoModerate : autoModerate // ignore: cast_nullable_to_non_nullable
as bool,toxicityThreshold: null == toxicityThreshold ? _self.toxicityThreshold : toxicityThreshold // ignore: cast_nullable_to_non_nullable
as double,offensiveThreshold: null == offensiveThreshold ? _self.offensiveThreshold : offensiveThreshold // ignore: cast_nullable_to_non_nullable
as double,politicalThreshold: null == politicalThreshold ? _self.politicalThreshold : politicalThreshold // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatRoomModel].
extension ChatRoomModelPatterns on ChatRoomModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatRoomModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatRoomModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatRoomModel value)  $default,){
final _that = this;
switch (_that) {
case _ChatRoomModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatRoomModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChatRoomModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  ChatRoomType type,  String? description,  String? coverImageUrl,  List<String> memberIds,  List<String> adminIds,  List<String> moderatorIds,  int messageCount,  int unreadCount,  DateTime? lastMessageAt,  String? lastMessageId,  String? lastMessageSenderId,  String? lastMessageContent,  bool isPrivate,  bool isArchived,  List<String> tags,  Map<String, DateTime> memberJoinDates,  DateTime? createdAt,  DateTime? updatedAt,  bool allowImages,  bool allowVoice,  bool autoModerate,  double toxicityThreshold,  double offensiveThreshold,  double politicalThreshold)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatRoomModel() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.description,_that.coverImageUrl,_that.memberIds,_that.adminIds,_that.moderatorIds,_that.messageCount,_that.unreadCount,_that.lastMessageAt,_that.lastMessageId,_that.lastMessageSenderId,_that.lastMessageContent,_that.isPrivate,_that.isArchived,_that.tags,_that.memberJoinDates,_that.createdAt,_that.updatedAt,_that.allowImages,_that.allowVoice,_that.autoModerate,_that.toxicityThreshold,_that.offensiveThreshold,_that.politicalThreshold);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  ChatRoomType type,  String? description,  String? coverImageUrl,  List<String> memberIds,  List<String> adminIds,  List<String> moderatorIds,  int messageCount,  int unreadCount,  DateTime? lastMessageAt,  String? lastMessageId,  String? lastMessageSenderId,  String? lastMessageContent,  bool isPrivate,  bool isArchived,  List<String> tags,  Map<String, DateTime> memberJoinDates,  DateTime? createdAt,  DateTime? updatedAt,  bool allowImages,  bool allowVoice,  bool autoModerate,  double toxicityThreshold,  double offensiveThreshold,  double politicalThreshold)  $default,) {final _that = this;
switch (_that) {
case _ChatRoomModel():
return $default(_that.id,_that.name,_that.type,_that.description,_that.coverImageUrl,_that.memberIds,_that.adminIds,_that.moderatorIds,_that.messageCount,_that.unreadCount,_that.lastMessageAt,_that.lastMessageId,_that.lastMessageSenderId,_that.lastMessageContent,_that.isPrivate,_that.isArchived,_that.tags,_that.memberJoinDates,_that.createdAt,_that.updatedAt,_that.allowImages,_that.allowVoice,_that.autoModerate,_that.toxicityThreshold,_that.offensiveThreshold,_that.politicalThreshold);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  ChatRoomType type,  String? description,  String? coverImageUrl,  List<String> memberIds,  List<String> adminIds,  List<String> moderatorIds,  int messageCount,  int unreadCount,  DateTime? lastMessageAt,  String? lastMessageId,  String? lastMessageSenderId,  String? lastMessageContent,  bool isPrivate,  bool isArchived,  List<String> tags,  Map<String, DateTime> memberJoinDates,  DateTime? createdAt,  DateTime? updatedAt,  bool allowImages,  bool allowVoice,  bool autoModerate,  double toxicityThreshold,  double offensiveThreshold,  double politicalThreshold)?  $default,) {final _that = this;
switch (_that) {
case _ChatRoomModel() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.description,_that.coverImageUrl,_that.memberIds,_that.adminIds,_that.moderatorIds,_that.messageCount,_that.unreadCount,_that.lastMessageAt,_that.lastMessageId,_that.lastMessageSenderId,_that.lastMessageContent,_that.isPrivate,_that.isArchived,_that.tags,_that.memberJoinDates,_that.createdAt,_that.updatedAt,_that.allowImages,_that.allowVoice,_that.autoModerate,_that.toxicityThreshold,_that.offensiveThreshold,_that.politicalThreshold);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatRoomModel implements ChatRoomModel {
  const _ChatRoomModel({required this.id, required this.name, required this.type, this.description, this.coverImageUrl, final  List<String> memberIds = const [], final  List<String> adminIds = const [], final  List<String> moderatorIds = const [], this.messageCount = 0, this.unreadCount = 0, this.lastMessageAt = null, this.lastMessageId, this.lastMessageSenderId, this.lastMessageContent, this.isPrivate = false, this.isArchived = false, final  List<String> tags = const [], final  Map<String, DateTime> memberJoinDates = const {}, this.createdAt = null, this.updatedAt = null, this.allowImages = true, this.allowVoice = true, this.autoModerate = true, this.toxicityThreshold = 0.7, this.offensiveThreshold = 0.8, this.politicalThreshold = 0.5}): _memberIds = memberIds,_adminIds = adminIds,_moderatorIds = moderatorIds,_tags = tags,_memberJoinDates = memberJoinDates;
  factory _ChatRoomModel.fromJson(Map<String, dynamic> json) => _$ChatRoomModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  ChatRoomType type;
@override final  String? description;
@override final  String? coverImageUrl;
 final  List<String> _memberIds;
@override@JsonKey() List<String> get memberIds {
  if (_memberIds is EqualUnmodifiableListView) return _memberIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_memberIds);
}

 final  List<String> _adminIds;
@override@JsonKey() List<String> get adminIds {
  if (_adminIds is EqualUnmodifiableListView) return _adminIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_adminIds);
}

 final  List<String> _moderatorIds;
@override@JsonKey() List<String> get moderatorIds {
  if (_moderatorIds is EqualUnmodifiableListView) return _moderatorIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_moderatorIds);
}

@override@JsonKey() final  int messageCount;
@override@JsonKey() final  int unreadCount;
@override@JsonKey() final  DateTime? lastMessageAt;
@override final  String? lastMessageId;
@override final  String? lastMessageSenderId;
@override final  String? lastMessageContent;
@override@JsonKey() final  bool isPrivate;
@override@JsonKey() final  bool isArchived;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

 final  Map<String, DateTime> _memberJoinDates;
@override@JsonKey() Map<String, DateTime> get memberJoinDates {
  if (_memberJoinDates is EqualUnmodifiableMapView) return _memberJoinDates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_memberJoinDates);
}

@override@JsonKey() final  DateTime? createdAt;
@override@JsonKey() final  DateTime? updatedAt;
// Moderation settings
@override@JsonKey() final  bool allowImages;
@override@JsonKey() final  bool allowVoice;
@override@JsonKey() final  bool autoModerate;
@override@JsonKey() final  double toxicityThreshold;
@override@JsonKey() final  double offensiveThreshold;
@override@JsonKey() final  double politicalThreshold;

/// Create a copy of ChatRoomModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatRoomModelCopyWith<_ChatRoomModel> get copyWith => __$ChatRoomModelCopyWithImpl<_ChatRoomModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatRoomModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatRoomModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.description, description) || other.description == description)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&const DeepCollectionEquality().equals(other._memberIds, _memberIds)&&const DeepCollectionEquality().equals(other._adminIds, _adminIds)&&const DeepCollectionEquality().equals(other._moderatorIds, _moderatorIds)&&(identical(other.messageCount, messageCount) || other.messageCount == messageCount)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount)&&(identical(other.lastMessageAt, lastMessageAt) || other.lastMessageAt == lastMessageAt)&&(identical(other.lastMessageId, lastMessageId) || other.lastMessageId == lastMessageId)&&(identical(other.lastMessageSenderId, lastMessageSenderId) || other.lastMessageSenderId == lastMessageSenderId)&&(identical(other.lastMessageContent, lastMessageContent) || other.lastMessageContent == lastMessageContent)&&(identical(other.isPrivate, isPrivate) || other.isPrivate == isPrivate)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived)&&const DeepCollectionEquality().equals(other._tags, _tags)&&const DeepCollectionEquality().equals(other._memberJoinDates, _memberJoinDates)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.allowImages, allowImages) || other.allowImages == allowImages)&&(identical(other.allowVoice, allowVoice) || other.allowVoice == allowVoice)&&(identical(other.autoModerate, autoModerate) || other.autoModerate == autoModerate)&&(identical(other.toxicityThreshold, toxicityThreshold) || other.toxicityThreshold == toxicityThreshold)&&(identical(other.offensiveThreshold, offensiveThreshold) || other.offensiveThreshold == offensiveThreshold)&&(identical(other.politicalThreshold, politicalThreshold) || other.politicalThreshold == politicalThreshold));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,type,description,coverImageUrl,const DeepCollectionEquality().hash(_memberIds),const DeepCollectionEquality().hash(_adminIds),const DeepCollectionEquality().hash(_moderatorIds),messageCount,unreadCount,lastMessageAt,lastMessageId,lastMessageSenderId,lastMessageContent,isPrivate,isArchived,const DeepCollectionEquality().hash(_tags),const DeepCollectionEquality().hash(_memberJoinDates),createdAt,updatedAt,allowImages,allowVoice,autoModerate,toxicityThreshold,offensiveThreshold,politicalThreshold]);

@override
String toString() {
  return 'ChatRoomModel(id: $id, name: $name, type: $type, description: $description, coverImageUrl: $coverImageUrl, memberIds: $memberIds, adminIds: $adminIds, moderatorIds: $moderatorIds, messageCount: $messageCount, unreadCount: $unreadCount, lastMessageAt: $lastMessageAt, lastMessageId: $lastMessageId, lastMessageSenderId: $lastMessageSenderId, lastMessageContent: $lastMessageContent, isPrivate: $isPrivate, isArchived: $isArchived, tags: $tags, memberJoinDates: $memberJoinDates, createdAt: $createdAt, updatedAt: $updatedAt, allowImages: $allowImages, allowVoice: $allowVoice, autoModerate: $autoModerate, toxicityThreshold: $toxicityThreshold, offensiveThreshold: $offensiveThreshold, politicalThreshold: $politicalThreshold)';
}


}

/// @nodoc
abstract mixin class _$ChatRoomModelCopyWith<$Res> implements $ChatRoomModelCopyWith<$Res> {
  factory _$ChatRoomModelCopyWith(_ChatRoomModel value, $Res Function(_ChatRoomModel) _then) = __$ChatRoomModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, ChatRoomType type, String? description, String? coverImageUrl, List<String> memberIds, List<String> adminIds, List<String> moderatorIds, int messageCount, int unreadCount, DateTime? lastMessageAt, String? lastMessageId, String? lastMessageSenderId, String? lastMessageContent, bool isPrivate, bool isArchived, List<String> tags, Map<String, DateTime> memberJoinDates, DateTime? createdAt, DateTime? updatedAt, bool allowImages, bool allowVoice, bool autoModerate, double toxicityThreshold, double offensiveThreshold, double politicalThreshold
});




}
/// @nodoc
class __$ChatRoomModelCopyWithImpl<$Res>
    implements _$ChatRoomModelCopyWith<$Res> {
  __$ChatRoomModelCopyWithImpl(this._self, this._then);

  final _ChatRoomModel _self;
  final $Res Function(_ChatRoomModel) _then;

/// Create a copy of ChatRoomModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? type = null,Object? description = freezed,Object? coverImageUrl = freezed,Object? memberIds = null,Object? adminIds = null,Object? moderatorIds = null,Object? messageCount = null,Object? unreadCount = null,Object? lastMessageAt = freezed,Object? lastMessageId = freezed,Object? lastMessageSenderId = freezed,Object? lastMessageContent = freezed,Object? isPrivate = null,Object? isArchived = null,Object? tags = null,Object? memberJoinDates = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? allowImages = null,Object? allowVoice = null,Object? autoModerate = null,Object? toxicityThreshold = null,Object? offensiveThreshold = null,Object? politicalThreshold = null,}) {
  return _then(_ChatRoomModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ChatRoomType,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,memberIds: null == memberIds ? _self._memberIds : memberIds // ignore: cast_nullable_to_non_nullable
as List<String>,adminIds: null == adminIds ? _self._adminIds : adminIds // ignore: cast_nullable_to_non_nullable
as List<String>,moderatorIds: null == moderatorIds ? _self._moderatorIds : moderatorIds // ignore: cast_nullable_to_non_nullable
as List<String>,messageCount: null == messageCount ? _self.messageCount : messageCount // ignore: cast_nullable_to_non_nullable
as int,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,lastMessageAt: freezed == lastMessageAt ? _self.lastMessageAt : lastMessageAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastMessageId: freezed == lastMessageId ? _self.lastMessageId : lastMessageId // ignore: cast_nullable_to_non_nullable
as String?,lastMessageSenderId: freezed == lastMessageSenderId ? _self.lastMessageSenderId : lastMessageSenderId // ignore: cast_nullable_to_non_nullable
as String?,lastMessageContent: freezed == lastMessageContent ? _self.lastMessageContent : lastMessageContent // ignore: cast_nullable_to_non_nullable
as String?,isPrivate: null == isPrivate ? _self.isPrivate : isPrivate // ignore: cast_nullable_to_non_nullable
as bool,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,memberJoinDates: null == memberJoinDates ? _self._memberJoinDates : memberJoinDates // ignore: cast_nullable_to_non_nullable
as Map<String, DateTime>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,allowImages: null == allowImages ? _self.allowImages : allowImages // ignore: cast_nullable_to_non_nullable
as bool,allowVoice: null == allowVoice ? _self.allowVoice : allowVoice // ignore: cast_nullable_to_non_nullable
as bool,autoModerate: null == autoModerate ? _self.autoModerate : autoModerate // ignore: cast_nullable_to_non_nullable
as bool,toxicityThreshold: null == toxicityThreshold ? _self.toxicityThreshold : toxicityThreshold // ignore: cast_nullable_to_non_nullable
as double,offensiveThreshold: null == offensiveThreshold ? _self.offensiveThreshold : offensiveThreshold // ignore: cast_nullable_to_non_nullable
as double,politicalThreshold: null == politicalThreshold ? _self.politicalThreshold : politicalThreshold // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$ChatPresenceModel {

 String get userId; String get roomId; UserPresence get presence; DateTime? get lastActiveAt; String? get lastMessageId; DateTime? get joinedAt;
/// Create a copy of ChatPresenceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatPresenceModelCopyWith<ChatPresenceModel> get copyWith => _$ChatPresenceModelCopyWithImpl<ChatPresenceModel>(this as ChatPresenceModel, _$identity);

  /// Serializes this ChatPresenceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatPresenceModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.presence, presence) || other.presence == presence)&&(identical(other.lastActiveAt, lastActiveAt) || other.lastActiveAt == lastActiveAt)&&(identical(other.lastMessageId, lastMessageId) || other.lastMessageId == lastMessageId)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,roomId,presence,lastActiveAt,lastMessageId,joinedAt);

@override
String toString() {
  return 'ChatPresenceModel(userId: $userId, roomId: $roomId, presence: $presence, lastActiveAt: $lastActiveAt, lastMessageId: $lastMessageId, joinedAt: $joinedAt)';
}


}

/// @nodoc
abstract mixin class $ChatPresenceModelCopyWith<$Res>  {
  factory $ChatPresenceModelCopyWith(ChatPresenceModel value, $Res Function(ChatPresenceModel) _then) = _$ChatPresenceModelCopyWithImpl;
@useResult
$Res call({
 String userId, String roomId, UserPresence presence, DateTime? lastActiveAt, String? lastMessageId, DateTime? joinedAt
});




}
/// @nodoc
class _$ChatPresenceModelCopyWithImpl<$Res>
    implements $ChatPresenceModelCopyWith<$Res> {
  _$ChatPresenceModelCopyWithImpl(this._self, this._then);

  final ChatPresenceModel _self;
  final $Res Function(ChatPresenceModel) _then;

/// Create a copy of ChatPresenceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? roomId = null,Object? presence = null,Object? lastActiveAt = freezed,Object? lastMessageId = freezed,Object? joinedAt = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,presence: null == presence ? _self.presence : presence // ignore: cast_nullable_to_non_nullable
as UserPresence,lastActiveAt: freezed == lastActiveAt ? _self.lastActiveAt : lastActiveAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastMessageId: freezed == lastMessageId ? _self.lastMessageId : lastMessageId // ignore: cast_nullable_to_non_nullable
as String?,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatPresenceModel].
extension ChatPresenceModelPatterns on ChatPresenceModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatPresenceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatPresenceModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatPresenceModel value)  $default,){
final _that = this;
switch (_that) {
case _ChatPresenceModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatPresenceModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChatPresenceModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String roomId,  UserPresence presence,  DateTime? lastActiveAt,  String? lastMessageId,  DateTime? joinedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatPresenceModel() when $default != null:
return $default(_that.userId,_that.roomId,_that.presence,_that.lastActiveAt,_that.lastMessageId,_that.joinedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String roomId,  UserPresence presence,  DateTime? lastActiveAt,  String? lastMessageId,  DateTime? joinedAt)  $default,) {final _that = this;
switch (_that) {
case _ChatPresenceModel():
return $default(_that.userId,_that.roomId,_that.presence,_that.lastActiveAt,_that.lastMessageId,_that.joinedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String roomId,  UserPresence presence,  DateTime? lastActiveAt,  String? lastMessageId,  DateTime? joinedAt)?  $default,) {final _that = this;
switch (_that) {
case _ChatPresenceModel() when $default != null:
return $default(_that.userId,_that.roomId,_that.presence,_that.lastActiveAt,_that.lastMessageId,_that.joinedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatPresenceModel implements ChatPresenceModel {
  const _ChatPresenceModel({required this.userId, required this.roomId, this.presence = UserPresence.online, this.lastActiveAt = null, this.lastMessageId, this.joinedAt = null});
  factory _ChatPresenceModel.fromJson(Map<String, dynamic> json) => _$ChatPresenceModelFromJson(json);

@override final  String userId;
@override final  String roomId;
@override@JsonKey() final  UserPresence presence;
@override@JsonKey() final  DateTime? lastActiveAt;
@override final  String? lastMessageId;
@override@JsonKey() final  DateTime? joinedAt;

/// Create a copy of ChatPresenceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatPresenceModelCopyWith<_ChatPresenceModel> get copyWith => __$ChatPresenceModelCopyWithImpl<_ChatPresenceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatPresenceModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatPresenceModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.presence, presence) || other.presence == presence)&&(identical(other.lastActiveAt, lastActiveAt) || other.lastActiveAt == lastActiveAt)&&(identical(other.lastMessageId, lastMessageId) || other.lastMessageId == lastMessageId)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,roomId,presence,lastActiveAt,lastMessageId,joinedAt);

@override
String toString() {
  return 'ChatPresenceModel(userId: $userId, roomId: $roomId, presence: $presence, lastActiveAt: $lastActiveAt, lastMessageId: $lastMessageId, joinedAt: $joinedAt)';
}


}

/// @nodoc
abstract mixin class _$ChatPresenceModelCopyWith<$Res> implements $ChatPresenceModelCopyWith<$Res> {
  factory _$ChatPresenceModelCopyWith(_ChatPresenceModel value, $Res Function(_ChatPresenceModel) _then) = __$ChatPresenceModelCopyWithImpl;
@override @useResult
$Res call({
 String userId, String roomId, UserPresence presence, DateTime? lastActiveAt, String? lastMessageId, DateTime? joinedAt
});




}
/// @nodoc
class __$ChatPresenceModelCopyWithImpl<$Res>
    implements _$ChatPresenceModelCopyWith<$Res> {
  __$ChatPresenceModelCopyWithImpl(this._self, this._then);

  final _ChatPresenceModel _self;
  final $Res Function(_ChatPresenceModel) _then;

/// Create a copy of ChatPresenceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? roomId = null,Object? presence = null,Object? lastActiveAt = freezed,Object? lastMessageId = freezed,Object? joinedAt = freezed,}) {
  return _then(_ChatPresenceModel(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,presence: null == presence ? _self.presence : presence // ignore: cast_nullable_to_non_nullable
as UserPresence,lastActiveAt: freezed == lastActiveAt ? _self.lastActiveAt : lastActiveAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastMessageId: freezed == lastMessageId ? _self.lastMessageId : lastMessageId // ignore: cast_nullable_to_non_nullable
as String?,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$ModerationReportModel {

 String get id; String get messageId; String get roomId; String get reportedBy; String get reason; String? get additionalNotes; ModerationStatus get status; String? get reviewedBy; DateTime? get createdAt; DateTime? get reviewedAt; bool get actionTaken; String? get actionDescription;
/// Create a copy of ModerationReportModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModerationReportModelCopyWith<ModerationReportModel> get copyWith => _$ModerationReportModelCopyWithImpl<ModerationReportModel>(this as ModerationReportModel, _$identity);

  /// Serializes this ModerationReportModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModerationReportModel&&(identical(other.id, id) || other.id == id)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.reportedBy, reportedBy) || other.reportedBy == reportedBy)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.additionalNotes, additionalNotes) || other.additionalNotes == additionalNotes)&&(identical(other.status, status) || other.status == status)&&(identical(other.reviewedBy, reviewedBy) || other.reviewedBy == reviewedBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt)&&(identical(other.actionTaken, actionTaken) || other.actionTaken == actionTaken)&&(identical(other.actionDescription, actionDescription) || other.actionDescription == actionDescription));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,messageId,roomId,reportedBy,reason,additionalNotes,status,reviewedBy,createdAt,reviewedAt,actionTaken,actionDescription);

@override
String toString() {
  return 'ModerationReportModel(id: $id, messageId: $messageId, roomId: $roomId, reportedBy: $reportedBy, reason: $reason, additionalNotes: $additionalNotes, status: $status, reviewedBy: $reviewedBy, createdAt: $createdAt, reviewedAt: $reviewedAt, actionTaken: $actionTaken, actionDescription: $actionDescription)';
}


}

/// @nodoc
abstract mixin class $ModerationReportModelCopyWith<$Res>  {
  factory $ModerationReportModelCopyWith(ModerationReportModel value, $Res Function(ModerationReportModel) _then) = _$ModerationReportModelCopyWithImpl;
@useResult
$Res call({
 String id, String messageId, String roomId, String reportedBy, String reason, String? additionalNotes, ModerationStatus status, String? reviewedBy, DateTime? createdAt, DateTime? reviewedAt, bool actionTaken, String? actionDescription
});




}
/// @nodoc
class _$ModerationReportModelCopyWithImpl<$Res>
    implements $ModerationReportModelCopyWith<$Res> {
  _$ModerationReportModelCopyWithImpl(this._self, this._then);

  final ModerationReportModel _self;
  final $Res Function(ModerationReportModel) _then;

/// Create a copy of ModerationReportModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? messageId = null,Object? roomId = null,Object? reportedBy = null,Object? reason = null,Object? additionalNotes = freezed,Object? status = null,Object? reviewedBy = freezed,Object? createdAt = freezed,Object? reviewedAt = freezed,Object? actionTaken = null,Object? actionDescription = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,reportedBy: null == reportedBy ? _self.reportedBy : reportedBy // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,additionalNotes: freezed == additionalNotes ? _self.additionalNotes : additionalNotes // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ModerationStatus,reviewedBy: freezed == reviewedBy ? _self.reviewedBy : reviewedBy // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,actionTaken: null == actionTaken ? _self.actionTaken : actionTaken // ignore: cast_nullable_to_non_nullable
as bool,actionDescription: freezed == actionDescription ? _self.actionDescription : actionDescription // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ModerationReportModel].
extension ModerationReportModelPatterns on ModerationReportModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ModerationReportModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ModerationReportModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ModerationReportModel value)  $default,){
final _that = this;
switch (_that) {
case _ModerationReportModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ModerationReportModel value)?  $default,){
final _that = this;
switch (_that) {
case _ModerationReportModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String messageId,  String roomId,  String reportedBy,  String reason,  String? additionalNotes,  ModerationStatus status,  String? reviewedBy,  DateTime? createdAt,  DateTime? reviewedAt,  bool actionTaken,  String? actionDescription)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ModerationReportModel() when $default != null:
return $default(_that.id,_that.messageId,_that.roomId,_that.reportedBy,_that.reason,_that.additionalNotes,_that.status,_that.reviewedBy,_that.createdAt,_that.reviewedAt,_that.actionTaken,_that.actionDescription);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String messageId,  String roomId,  String reportedBy,  String reason,  String? additionalNotes,  ModerationStatus status,  String? reviewedBy,  DateTime? createdAt,  DateTime? reviewedAt,  bool actionTaken,  String? actionDescription)  $default,) {final _that = this;
switch (_that) {
case _ModerationReportModel():
return $default(_that.id,_that.messageId,_that.roomId,_that.reportedBy,_that.reason,_that.additionalNotes,_that.status,_that.reviewedBy,_that.createdAt,_that.reviewedAt,_that.actionTaken,_that.actionDescription);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String messageId,  String roomId,  String reportedBy,  String reason,  String? additionalNotes,  ModerationStatus status,  String? reviewedBy,  DateTime? createdAt,  DateTime? reviewedAt,  bool actionTaken,  String? actionDescription)?  $default,) {final _that = this;
switch (_that) {
case _ModerationReportModel() when $default != null:
return $default(_that.id,_that.messageId,_that.roomId,_that.reportedBy,_that.reason,_that.additionalNotes,_that.status,_that.reviewedBy,_that.createdAt,_that.reviewedAt,_that.actionTaken,_that.actionDescription);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ModerationReportModel implements ModerationReportModel {
  const _ModerationReportModel({required this.id, required this.messageId, required this.roomId, required this.reportedBy, required this.reason, this.additionalNotes, this.status = ModerationStatus.pending, this.reviewedBy, this.createdAt = null, this.reviewedAt = null, this.actionTaken = false, this.actionDescription});
  factory _ModerationReportModel.fromJson(Map<String, dynamic> json) => _$ModerationReportModelFromJson(json);

@override final  String id;
@override final  String messageId;
@override final  String roomId;
@override final  String reportedBy;
@override final  String reason;
@override final  String? additionalNotes;
@override@JsonKey() final  ModerationStatus status;
@override final  String? reviewedBy;
@override@JsonKey() final  DateTime? createdAt;
@override@JsonKey() final  DateTime? reviewedAt;
@override@JsonKey() final  bool actionTaken;
@override final  String? actionDescription;

/// Create a copy of ModerationReportModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ModerationReportModelCopyWith<_ModerationReportModel> get copyWith => __$ModerationReportModelCopyWithImpl<_ModerationReportModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ModerationReportModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ModerationReportModel&&(identical(other.id, id) || other.id == id)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.reportedBy, reportedBy) || other.reportedBy == reportedBy)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.additionalNotes, additionalNotes) || other.additionalNotes == additionalNotes)&&(identical(other.status, status) || other.status == status)&&(identical(other.reviewedBy, reviewedBy) || other.reviewedBy == reviewedBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt)&&(identical(other.actionTaken, actionTaken) || other.actionTaken == actionTaken)&&(identical(other.actionDescription, actionDescription) || other.actionDescription == actionDescription));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,messageId,roomId,reportedBy,reason,additionalNotes,status,reviewedBy,createdAt,reviewedAt,actionTaken,actionDescription);

@override
String toString() {
  return 'ModerationReportModel(id: $id, messageId: $messageId, roomId: $roomId, reportedBy: $reportedBy, reason: $reason, additionalNotes: $additionalNotes, status: $status, reviewedBy: $reviewedBy, createdAt: $createdAt, reviewedAt: $reviewedAt, actionTaken: $actionTaken, actionDescription: $actionDescription)';
}


}

/// @nodoc
abstract mixin class _$ModerationReportModelCopyWith<$Res> implements $ModerationReportModelCopyWith<$Res> {
  factory _$ModerationReportModelCopyWith(_ModerationReportModel value, $Res Function(_ModerationReportModel) _then) = __$ModerationReportModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String messageId, String roomId, String reportedBy, String reason, String? additionalNotes, ModerationStatus status, String? reviewedBy, DateTime? createdAt, DateTime? reviewedAt, bool actionTaken, String? actionDescription
});




}
/// @nodoc
class __$ModerationReportModelCopyWithImpl<$Res>
    implements _$ModerationReportModelCopyWith<$Res> {
  __$ModerationReportModelCopyWithImpl(this._self, this._then);

  final _ModerationReportModel _self;
  final $Res Function(_ModerationReportModel) _then;

/// Create a copy of ModerationReportModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? messageId = null,Object? roomId = null,Object? reportedBy = null,Object? reason = null,Object? additionalNotes = freezed,Object? status = null,Object? reviewedBy = freezed,Object? createdAt = freezed,Object? reviewedAt = freezed,Object? actionTaken = null,Object? actionDescription = freezed,}) {
  return _then(_ModerationReportModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,reportedBy: null == reportedBy ? _self.reportedBy : reportedBy // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,additionalNotes: freezed == additionalNotes ? _self.additionalNotes : additionalNotes // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ModerationStatus,reviewedBy: freezed == reviewedBy ? _self.reviewedBy : reviewedBy // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,actionTaken: null == actionTaken ? _self.actionTaken : actionTaken // ignore: cast_nullable_to_non_nullable
as bool,actionDescription: freezed == actionDescription ? _self.actionDescription : actionDescription // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ChatNotificationModel {

 String get id; String get userId; String get roomId; String get messageId; String? get senderId; String? get senderName; String? get messagePreview; bool get isRead; DateTime? get createdAt; MessageType? get messageType;
/// Create a copy of ChatNotificationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatNotificationModelCopyWith<ChatNotificationModel> get copyWith => _$ChatNotificationModelCopyWithImpl<ChatNotificationModel>(this as ChatNotificationModel, _$identity);

  /// Serializes this ChatNotificationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatNotificationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.messagePreview, messagePreview) || other.messagePreview == messagePreview)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.messageType, messageType) || other.messageType == messageType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,roomId,messageId,senderId,senderName,messagePreview,isRead,createdAt,messageType);

@override
String toString() {
  return 'ChatNotificationModel(id: $id, userId: $userId, roomId: $roomId, messageId: $messageId, senderId: $senderId, senderName: $senderName, messagePreview: $messagePreview, isRead: $isRead, createdAt: $createdAt, messageType: $messageType)';
}


}

/// @nodoc
abstract mixin class $ChatNotificationModelCopyWith<$Res>  {
  factory $ChatNotificationModelCopyWith(ChatNotificationModel value, $Res Function(ChatNotificationModel) _then) = _$ChatNotificationModelCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String roomId, String messageId, String? senderId, String? senderName, String? messagePreview, bool isRead, DateTime? createdAt, MessageType? messageType
});




}
/// @nodoc
class _$ChatNotificationModelCopyWithImpl<$Res>
    implements $ChatNotificationModelCopyWith<$Res> {
  _$ChatNotificationModelCopyWithImpl(this._self, this._then);

  final ChatNotificationModel _self;
  final $Res Function(ChatNotificationModel) _then;

/// Create a copy of ChatNotificationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? roomId = null,Object? messageId = null,Object? senderId = freezed,Object? senderName = freezed,Object? messagePreview = freezed,Object? isRead = null,Object? createdAt = freezed,Object? messageType = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,senderId: freezed == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String?,senderName: freezed == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String?,messagePreview: freezed == messagePreview ? _self.messagePreview : messagePreview // ignore: cast_nullable_to_non_nullable
as String?,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,messageType: freezed == messageType ? _self.messageType : messageType // ignore: cast_nullable_to_non_nullable
as MessageType?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatNotificationModel].
extension ChatNotificationModelPatterns on ChatNotificationModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatNotificationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatNotificationModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatNotificationModel value)  $default,){
final _that = this;
switch (_that) {
case _ChatNotificationModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatNotificationModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChatNotificationModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String roomId,  String messageId,  String? senderId,  String? senderName,  String? messagePreview,  bool isRead,  DateTime? createdAt,  MessageType? messageType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatNotificationModel() when $default != null:
return $default(_that.id,_that.userId,_that.roomId,_that.messageId,_that.senderId,_that.senderName,_that.messagePreview,_that.isRead,_that.createdAt,_that.messageType);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String roomId,  String messageId,  String? senderId,  String? senderName,  String? messagePreview,  bool isRead,  DateTime? createdAt,  MessageType? messageType)  $default,) {final _that = this;
switch (_that) {
case _ChatNotificationModel():
return $default(_that.id,_that.userId,_that.roomId,_that.messageId,_that.senderId,_that.senderName,_that.messagePreview,_that.isRead,_that.createdAt,_that.messageType);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String roomId,  String messageId,  String? senderId,  String? senderName,  String? messagePreview,  bool isRead,  DateTime? createdAt,  MessageType? messageType)?  $default,) {final _that = this;
switch (_that) {
case _ChatNotificationModel() when $default != null:
return $default(_that.id,_that.userId,_that.roomId,_that.messageId,_that.senderId,_that.senderName,_that.messagePreview,_that.isRead,_that.createdAt,_that.messageType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatNotificationModel implements ChatNotificationModel {
  const _ChatNotificationModel({required this.id, required this.userId, required this.roomId, required this.messageId, this.senderId, this.senderName, this.messagePreview, this.isRead = false, this.createdAt = null, this.messageType});
  factory _ChatNotificationModel.fromJson(Map<String, dynamic> json) => _$ChatNotificationModelFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String roomId;
@override final  String messageId;
@override final  String? senderId;
@override final  String? senderName;
@override final  String? messagePreview;
@override@JsonKey() final  bool isRead;
@override@JsonKey() final  DateTime? createdAt;
@override final  MessageType? messageType;

/// Create a copy of ChatNotificationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatNotificationModelCopyWith<_ChatNotificationModel> get copyWith => __$ChatNotificationModelCopyWithImpl<_ChatNotificationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatNotificationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatNotificationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.messagePreview, messagePreview) || other.messagePreview == messagePreview)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.messageType, messageType) || other.messageType == messageType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,roomId,messageId,senderId,senderName,messagePreview,isRead,createdAt,messageType);

@override
String toString() {
  return 'ChatNotificationModel(id: $id, userId: $userId, roomId: $roomId, messageId: $messageId, senderId: $senderId, senderName: $senderName, messagePreview: $messagePreview, isRead: $isRead, createdAt: $createdAt, messageType: $messageType)';
}


}

/// @nodoc
abstract mixin class _$ChatNotificationModelCopyWith<$Res> implements $ChatNotificationModelCopyWith<$Res> {
  factory _$ChatNotificationModelCopyWith(_ChatNotificationModel value, $Res Function(_ChatNotificationModel) _then) = __$ChatNotificationModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String roomId, String messageId, String? senderId, String? senderName, String? messagePreview, bool isRead, DateTime? createdAt, MessageType? messageType
});




}
/// @nodoc
class __$ChatNotificationModelCopyWithImpl<$Res>
    implements _$ChatNotificationModelCopyWith<$Res> {
  __$ChatNotificationModelCopyWithImpl(this._self, this._then);

  final _ChatNotificationModel _self;
  final $Res Function(_ChatNotificationModel) _then;

/// Create a copy of ChatNotificationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? roomId = null,Object? messageId = null,Object? senderId = freezed,Object? senderName = freezed,Object? messagePreview = freezed,Object? isRead = null,Object? createdAt = freezed,Object? messageType = freezed,}) {
  return _then(_ChatNotificationModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,senderId: freezed == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String?,senderName: freezed == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String?,messagePreview: freezed == messagePreview ? _self.messagePreview : messagePreview // ignore: cast_nullable_to_non_nullable
as String?,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,messageType: freezed == messageType ? _self.messageType : messageType // ignore: cast_nullable_to_non_nullable
as MessageType?,
  ));
}


}

// dart format on
