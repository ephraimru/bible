// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'faith_journey_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FaithMilestone {

 String get id; String get userId; FaithMilestoneType get type; String get title; String get description; String? get icon; String? get imageUrl; DateTime? get achievedAt; bool get isAchieved; Map<String, dynamic> get metadata; DateTime? get createdAt;
/// Create a copy of FaithMilestone
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FaithMilestoneCopyWith<FaithMilestone> get copyWith => _$FaithMilestoneCopyWithImpl<FaithMilestone>(this as FaithMilestone, _$identity);

  /// Serializes this FaithMilestone to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FaithMilestone;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FaithMilestone&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.icon, _this.icon) || other.icon == _this.icon)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.achievedAt, _this.achievedAt) || other.achievedAt == _this.achievedAt)&&(identical(other.isAchieved, _this.isAchieved) || other.isAchieved == _this.isAchieved)&&const DeepCollectionEquality().equals(other.metadata, _this.metadata)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FaithMilestone;
  return Object.hash(runtimeType,_this.id,_this.userId,_this.type,_this.title,_this.description,_this.icon,_this.imageUrl,_this.achievedAt,_this.isAchieved,const DeepCollectionEquality().hash(_this.metadata),_this.createdAt);
}

@override
String toString() {
  final _this = this as FaithMilestone;
  return 'FaithMilestone(id: ${_this.id}, userId: ${_this.userId}, type: ${_this.type}, title: ${_this.title}, description: ${_this.description}, icon: ${_this.icon}, imageUrl: ${_this.imageUrl}, achievedAt: ${_this.achievedAt}, isAchieved: ${_this.isAchieved}, metadata: ${_this.metadata}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $FaithMilestoneCopyWith<$Res>  {
  factory $FaithMilestoneCopyWith(FaithMilestone value, $Res Function(FaithMilestone) _then) = _$FaithMilestoneCopyWithImpl;
@useResult
$Res call({
 String id, String userId, FaithMilestoneType type, String title, String description, String? icon, String? imageUrl, DateTime? achievedAt, bool isAchieved, Map<String, dynamic> metadata, DateTime? createdAt
});




}
/// @nodoc
class _$FaithMilestoneCopyWithImpl<$Res>
    implements $FaithMilestoneCopyWith<$Res> {
  _$FaithMilestoneCopyWithImpl(this._self, this._then);

  final FaithMilestone _self;
  final $Res Function(FaithMilestone) _then;

/// Create a copy of FaithMilestone
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? type = null,Object? title = null,Object? description = null,Object? icon = freezed,Object? imageUrl = freezed,Object? achievedAt = freezed,Object? isAchieved = null,Object? metadata = null,Object? createdAt = freezed,}) {
  return _then(FaithMilestone(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as FaithMilestoneType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,achievedAt: freezed == achievedAt ? _self.achievedAt : achievedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isAchieved: null == isAchieved ? _self.isAchieved : isAchieved // ignore: cast_nullable_to_non_nullable
as bool,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [FaithMilestone].
extension FaithMilestonePatterns on FaithMilestone {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FaithMilestone value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FaithMilestone() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FaithMilestone value)  $default,){
final _that = this;
switch (_that) {
case _FaithMilestone():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FaithMilestone value)?  $default,){
final _that = this;
switch (_that) {
case _FaithMilestone() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  FaithMilestoneType type,  String title,  String description,  String? icon,  String? imageUrl,  DateTime? achievedAt,  bool isAchieved,  Map<String, dynamic> metadata,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FaithMilestone() when $default != null:
return $default(_that.id,_that.userId,_that.type,_that.title,_that.description,_that.icon,_that.imageUrl,_that.achievedAt,_that.isAchieved,_that.metadata,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  FaithMilestoneType type,  String title,  String description,  String? icon,  String? imageUrl,  DateTime? achievedAt,  bool isAchieved,  Map<String, dynamic> metadata,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _FaithMilestone():
return $default(_that.id,_that.userId,_that.type,_that.title,_that.description,_that.icon,_that.imageUrl,_that.achievedAt,_that.isAchieved,_that.metadata,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  FaithMilestoneType type,  String title,  String description,  String? icon,  String? imageUrl,  DateTime? achievedAt,  bool isAchieved,  Map<String, dynamic> metadata,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _FaithMilestone() when $default != null:
return $default(_that.id,_that.userId,_that.type,_that.title,_that.description,_that.icon,_that.imageUrl,_that.achievedAt,_that.isAchieved,_that.metadata,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FaithMilestone implements FaithMilestone {
  const _FaithMilestone({required this.id, required this.userId, required this.type, required this.title, required this.description, this.icon, this.imageUrl, this.achievedAt = null, this.isAchieved = false,  Map<String, dynamic> metadata = const {}, this.createdAt = null}): _metadata = metadata;
  factory _FaithMilestone.fromJson(Map<String, dynamic> json) => _$FaithMilestoneFromJson(json);

@override final  String id;
@override final  String userId;
@override final  FaithMilestoneType type;
@override final  String title;
@override final  String description;
@override final  String? icon;
@override final  String? imageUrl;
@override@JsonKey() final  DateTime? achievedAt;
@override@JsonKey() final  bool isAchieved;
 final  Map<String, dynamic> _metadata;
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}

@override@JsonKey() final  DateTime? createdAt;

/// Create a copy of FaithMilestone
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FaithMilestoneCopyWith<_FaithMilestone> get copyWith => __$FaithMilestoneCopyWithImpl<_FaithMilestone>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FaithMilestoneToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FaithMilestone&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.achievedAt, achievedAt) || other.achievedAt == achievedAt)&&(identical(other.isAchieved, isAchieved) || other.isAchieved == isAchieved)&&const DeepCollectionEquality().equals(other.metadata, _metadata)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,userId,type,title,description,icon,imageUrl,achievedAt,isAchieved,const DeepCollectionEquality().hash(_metadata),createdAt);
}

@override
String toString() {
    return 'FaithMilestone(id: $id, userId: $userId, type: $type, title: $title, description: $description, icon: $icon, imageUrl: $imageUrl, achievedAt: $achievedAt, isAchieved: $isAchieved, metadata: $metadata, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$FaithMilestoneCopyWith<$Res> implements $FaithMilestoneCopyWith<$Res> {
  factory _$FaithMilestoneCopyWith(_FaithMilestone value, $Res Function(_FaithMilestone) _then) = __$FaithMilestoneCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, FaithMilestoneType type, String title, String description, String? icon, String? imageUrl, DateTime? achievedAt, bool isAchieved, Map<String, dynamic> metadata, DateTime? createdAt
});




}
/// @nodoc
class __$FaithMilestoneCopyWithImpl<$Res>
    implements _$FaithMilestoneCopyWith<$Res> {
  __$FaithMilestoneCopyWithImpl(this._self, this._then);

  final _FaithMilestone _self;
  final $Res Function(_FaithMilestone) _then;

/// Create a copy of FaithMilestone
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? type = null,Object? title = null,Object? description = null,Object? icon = freezed,Object? imageUrl = freezed,Object? achievedAt = freezed,Object? isAchieved = null,Object? metadata = null,Object? createdAt = freezed,}) {
  return _then(_FaithMilestone(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as FaithMilestoneType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,achievedAt: freezed == achievedAt ? _self.achievedAt : achievedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isAchieved: null == isAchieved ? _self.isAchieved : isAchieved // ignore: cast_nullable_to_non_nullable
as bool,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$FaithProgress {

 UserRole get targetRole; FaithProgressStatus get status; int get currentProgress; int get requiredProgress; String? get description; DateTime? get startedAt; DateTime? get completedAt; List<FaithMilestone> get milestones; Map<String, dynamic> get requirements;
/// Create a copy of FaithProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FaithProgressCopyWith<FaithProgress> get copyWith => _$FaithProgressCopyWithImpl<FaithProgress>(this as FaithProgress, _$identity);

  /// Serializes this FaithProgress to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FaithProgress;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FaithProgress&&(identical(other.targetRole, _this.targetRole) || other.targetRole == _this.targetRole)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.currentProgress, _this.currentProgress) || other.currentProgress == _this.currentProgress)&&(identical(other.requiredProgress, _this.requiredProgress) || other.requiredProgress == _this.requiredProgress)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.startedAt, _this.startedAt) || other.startedAt == _this.startedAt)&&(identical(other.completedAt, _this.completedAt) || other.completedAt == _this.completedAt)&&const DeepCollectionEquality().equals(other.milestones, _this.milestones)&&const DeepCollectionEquality().equals(other.requirements, _this.requirements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FaithProgress;
  return Object.hash(runtimeType,_this.targetRole,_this.status,_this.currentProgress,_this.requiredProgress,_this.description,_this.startedAt,_this.completedAt,const DeepCollectionEquality().hash(_this.milestones),const DeepCollectionEquality().hash(_this.requirements));
}

@override
String toString() {
  final _this = this as FaithProgress;
  return 'FaithProgress(targetRole: ${_this.targetRole}, status: ${_this.status}, currentProgress: ${_this.currentProgress}, requiredProgress: ${_this.requiredProgress}, description: ${_this.description}, startedAt: ${_this.startedAt}, completedAt: ${_this.completedAt}, milestones: ${_this.milestones}, requirements: ${_this.requirements})';
}


}

/// @nodoc
abstract mixin class $FaithProgressCopyWith<$Res>  {
  factory $FaithProgressCopyWith(FaithProgress value, $Res Function(FaithProgress) _then) = _$FaithProgressCopyWithImpl;
@useResult
$Res call({
 UserRole targetRole, FaithProgressStatus status, int currentProgress, int requiredProgress, String? description, DateTime? startedAt, DateTime? completedAt, List<FaithMilestone> milestones, Map<String, dynamic> requirements
});




}
/// @nodoc
class _$FaithProgressCopyWithImpl<$Res>
    implements $FaithProgressCopyWith<$Res> {
  _$FaithProgressCopyWithImpl(this._self, this._then);

  final FaithProgress _self;
  final $Res Function(FaithProgress) _then;

/// Create a copy of FaithProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? targetRole = null,Object? status = null,Object? currentProgress = null,Object? requiredProgress = null,Object? description = freezed,Object? startedAt = freezed,Object? completedAt = freezed,Object? milestones = null,Object? requirements = null,}) {
  return _then(FaithProgress(
targetRole: null == targetRole ? _self.targetRole : targetRole // ignore: cast_nullable_to_non_nullable
as UserRole,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FaithProgressStatus,currentProgress: null == currentProgress ? _self.currentProgress : currentProgress // ignore: cast_nullable_to_non_nullable
as int,requiredProgress: null == requiredProgress ? _self.requiredProgress : requiredProgress // ignore: cast_nullable_to_non_nullable
as int,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,milestones: null == milestones ? _self.milestones : milestones // ignore: cast_nullable_to_non_nullable
as List<FaithMilestone>,requirements: null == requirements ? _self.requirements : requirements // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [FaithProgress].
extension FaithProgressPatterns on FaithProgress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FaithProgress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FaithProgress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FaithProgress value)  $default,){
final _that = this;
switch (_that) {
case _FaithProgress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FaithProgress value)?  $default,){
final _that = this;
switch (_that) {
case _FaithProgress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UserRole targetRole,  FaithProgressStatus status,  int currentProgress,  int requiredProgress,  String? description,  DateTime? startedAt,  DateTime? completedAt,  List<FaithMilestone> milestones,  Map<String, dynamic> requirements)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FaithProgress() when $default != null:
return $default(_that.targetRole,_that.status,_that.currentProgress,_that.requiredProgress,_that.description,_that.startedAt,_that.completedAt,_that.milestones,_that.requirements);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UserRole targetRole,  FaithProgressStatus status,  int currentProgress,  int requiredProgress,  String? description,  DateTime? startedAt,  DateTime? completedAt,  List<FaithMilestone> milestones,  Map<String, dynamic> requirements)  $default,) {final _that = this;
switch (_that) {
case _FaithProgress():
return $default(_that.targetRole,_that.status,_that.currentProgress,_that.requiredProgress,_that.description,_that.startedAt,_that.completedAt,_that.milestones,_that.requirements);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UserRole targetRole,  FaithProgressStatus status,  int currentProgress,  int requiredProgress,  String? description,  DateTime? startedAt,  DateTime? completedAt,  List<FaithMilestone> milestones,  Map<String, dynamic> requirements)?  $default,) {final _that = this;
switch (_that) {
case _FaithProgress() when $default != null:
return $default(_that.targetRole,_that.status,_that.currentProgress,_that.requiredProgress,_that.description,_that.startedAt,_that.completedAt,_that.milestones,_that.requirements);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FaithProgress implements FaithProgress {
  const _FaithProgress({required this.targetRole, this.status = FaithProgressStatus.locked, this.currentProgress = 0, this.requiredProgress = 100, this.description, this.startedAt = null, this.completedAt = null,  List<FaithMilestone> milestones = const [],  Map<String, dynamic> requirements = const {}}): _milestones = milestones,_requirements = requirements;
  factory _FaithProgress.fromJson(Map<String, dynamic> json) => _$FaithProgressFromJson(json);

@override final  UserRole targetRole;
@override@JsonKey() final  FaithProgressStatus status;
@override@JsonKey() final  int currentProgress;
@override@JsonKey() final  int requiredProgress;
@override final  String? description;
@override@JsonKey() final  DateTime? startedAt;
@override@JsonKey() final  DateTime? completedAt;
 final  List<FaithMilestone> _milestones;
@override@JsonKey() List<FaithMilestone> get milestones {
  if (_milestones is EqualUnmodifiableListView) return _milestones;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_milestones);
}

 final  Map<String, dynamic> _requirements;
@override@JsonKey() Map<String, dynamic> get requirements {
  if (_requirements is EqualUnmodifiableMapView) return _requirements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_requirements);
}


/// Create a copy of FaithProgress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FaithProgressCopyWith<_FaithProgress> get copyWith => __$FaithProgressCopyWithImpl<_FaithProgress>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FaithProgressToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FaithProgress&&(identical(other.targetRole, targetRole) || other.targetRole == targetRole)&&(identical(other.status, status) || other.status == status)&&(identical(other.currentProgress, currentProgress) || other.currentProgress == currentProgress)&&(identical(other.requiredProgress, requiredProgress) || other.requiredProgress == requiredProgress)&&(identical(other.description, description) || other.description == description)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&const DeepCollectionEquality().equals(other.milestones, _milestones)&&const DeepCollectionEquality().equals(other.requirements, _requirements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,targetRole,status,currentProgress,requiredProgress,description,startedAt,completedAt,const DeepCollectionEquality().hash(_milestones),const DeepCollectionEquality().hash(_requirements));
}

@override
String toString() {
    return 'FaithProgress(targetRole: $targetRole, status: $status, currentProgress: $currentProgress, requiredProgress: $requiredProgress, description: $description, startedAt: $startedAt, completedAt: $completedAt, milestones: $milestones, requirements: $requirements)';
}


}

/// @nodoc
abstract mixin class _$FaithProgressCopyWith<$Res> implements $FaithProgressCopyWith<$Res> {
  factory _$FaithProgressCopyWith(_FaithProgress value, $Res Function(_FaithProgress) _then) = __$FaithProgressCopyWithImpl;
@override @useResult
$Res call({
 UserRole targetRole, FaithProgressStatus status, int currentProgress, int requiredProgress, String? description, DateTime? startedAt, DateTime? completedAt, List<FaithMilestone> milestones, Map<String, dynamic> requirements
});




}
/// @nodoc
class __$FaithProgressCopyWithImpl<$Res>
    implements _$FaithProgressCopyWith<$Res> {
  __$FaithProgressCopyWithImpl(this._self, this._then);

  final _FaithProgress _self;
  final $Res Function(_FaithProgress) _then;

/// Create a copy of FaithProgress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? targetRole = null,Object? status = null,Object? currentProgress = null,Object? requiredProgress = null,Object? description = freezed,Object? startedAt = freezed,Object? completedAt = freezed,Object? milestones = null,Object? requirements = null,}) {
  return _then(_FaithProgress(
targetRole: null == targetRole ? _self.targetRole : targetRole // ignore: cast_nullable_to_non_nullable
as UserRole,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FaithProgressStatus,currentProgress: null == currentProgress ? _self.currentProgress : currentProgress // ignore: cast_nullable_to_non_nullable
as int,requiredProgress: null == requiredProgress ? _self.requiredProgress : requiredProgress // ignore: cast_nullable_to_non_nullable
as int,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,milestones: null == milestones ? _self._milestones : milestones // ignore: cast_nullable_to_non_nullable
as List<FaithMilestone>,requirements: null == requirements ? _self._requirements : requirements // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}


/// @nodoc
mixin _$FaithJourney {

 String get userId; UserRole get currentRole; List<FaithProgress> get progressList; List<FaithMilestone> get milestones; int get totalDaysRead; int get consecutiveDays; int get longestStreak; int get versesRead; int get chaptersRead; List<DateTime> get readingHistory; Map<String, int> get bookProgress; List<String> get achievements; DateTime? get startedAt; DateTime? get lastUpdatedAt; DateTime? get lastReadingDate; DateTime? get streakStartDate; bool get hasReachedBeliever; bool get hasReachedPreacher; bool get hasReachedShepherd; bool get hasReachedBishop; bool get hasPaidToSkip; int get followerCount; bool get canPostOnBlog; String? get chosenTitle; bool get hasAccessToPremiumContent; List<String> get premiumFeaturesUnlocked;
/// Create a copy of FaithJourney
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FaithJourneyCopyWith<FaithJourney> get copyWith => _$FaithJourneyCopyWithImpl<FaithJourney>(this as FaithJourney, _$identity);

  /// Serializes this FaithJourney to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FaithJourney;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FaithJourney&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.currentRole, _this.currentRole) || other.currentRole == _this.currentRole)&&const DeepCollectionEquality().equals(other.progressList, _this.progressList)&&const DeepCollectionEquality().equals(other.milestones, _this.milestones)&&(identical(other.totalDaysRead, _this.totalDaysRead) || other.totalDaysRead == _this.totalDaysRead)&&(identical(other.consecutiveDays, _this.consecutiveDays) || other.consecutiveDays == _this.consecutiveDays)&&(identical(other.longestStreak, _this.longestStreak) || other.longestStreak == _this.longestStreak)&&(identical(other.versesRead, _this.versesRead) || other.versesRead == _this.versesRead)&&(identical(other.chaptersRead, _this.chaptersRead) || other.chaptersRead == _this.chaptersRead)&&const DeepCollectionEquality().equals(other.readingHistory, _this.readingHistory)&&const DeepCollectionEquality().equals(other.bookProgress, _this.bookProgress)&&const DeepCollectionEquality().equals(other.achievements, _this.achievements)&&(identical(other.startedAt, _this.startedAt) || other.startedAt == _this.startedAt)&&(identical(other.lastUpdatedAt, _this.lastUpdatedAt) || other.lastUpdatedAt == _this.lastUpdatedAt)&&(identical(other.lastReadingDate, _this.lastReadingDate) || other.lastReadingDate == _this.lastReadingDate)&&(identical(other.streakStartDate, _this.streakStartDate) || other.streakStartDate == _this.streakStartDate)&&(identical(other.hasReachedBeliever, _this.hasReachedBeliever) || other.hasReachedBeliever == _this.hasReachedBeliever)&&(identical(other.hasReachedPreacher, _this.hasReachedPreacher) || other.hasReachedPreacher == _this.hasReachedPreacher)&&(identical(other.hasReachedShepherd, _this.hasReachedShepherd) || other.hasReachedShepherd == _this.hasReachedShepherd)&&(identical(other.hasReachedBishop, _this.hasReachedBishop) || other.hasReachedBishop == _this.hasReachedBishop)&&(identical(other.hasPaidToSkip, _this.hasPaidToSkip) || other.hasPaidToSkip == _this.hasPaidToSkip)&&(identical(other.followerCount, _this.followerCount) || other.followerCount == _this.followerCount)&&(identical(other.canPostOnBlog, _this.canPostOnBlog) || other.canPostOnBlog == _this.canPostOnBlog)&&(identical(other.chosenTitle, _this.chosenTitle) || other.chosenTitle == _this.chosenTitle)&&(identical(other.hasAccessToPremiumContent, _this.hasAccessToPremiumContent) || other.hasAccessToPremiumContent == _this.hasAccessToPremiumContent)&&const DeepCollectionEquality().equals(other.premiumFeaturesUnlocked, _this.premiumFeaturesUnlocked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FaithJourney;
  return Object.hashAll([runtimeType,_this.userId,_this.currentRole,const DeepCollectionEquality().hash(_this.progressList),const DeepCollectionEquality().hash(_this.milestones),_this.totalDaysRead,_this.consecutiveDays,_this.longestStreak,_this.versesRead,_this.chaptersRead,const DeepCollectionEquality().hash(_this.readingHistory),const DeepCollectionEquality().hash(_this.bookProgress),const DeepCollectionEquality().hash(_this.achievements),_this.startedAt,_this.lastUpdatedAt,_this.lastReadingDate,_this.streakStartDate,_this.hasReachedBeliever,_this.hasReachedPreacher,_this.hasReachedShepherd,_this.hasReachedBishop,_this.hasPaidToSkip,_this.followerCount,_this.canPostOnBlog,_this.chosenTitle,_this.hasAccessToPremiumContent,const DeepCollectionEquality().hash(_this.premiumFeaturesUnlocked)]);
}

@override
String toString() {
  final _this = this as FaithJourney;
  return 'FaithJourney(userId: ${_this.userId}, currentRole: ${_this.currentRole}, progressList: ${_this.progressList}, milestones: ${_this.milestones}, totalDaysRead: ${_this.totalDaysRead}, consecutiveDays: ${_this.consecutiveDays}, longestStreak: ${_this.longestStreak}, versesRead: ${_this.versesRead}, chaptersRead: ${_this.chaptersRead}, readingHistory: ${_this.readingHistory}, bookProgress: ${_this.bookProgress}, achievements: ${_this.achievements}, startedAt: ${_this.startedAt}, lastUpdatedAt: ${_this.lastUpdatedAt}, lastReadingDate: ${_this.lastReadingDate}, streakStartDate: ${_this.streakStartDate}, hasReachedBeliever: ${_this.hasReachedBeliever}, hasReachedPreacher: ${_this.hasReachedPreacher}, hasReachedShepherd: ${_this.hasReachedShepherd}, hasReachedBishop: ${_this.hasReachedBishop}, hasPaidToSkip: ${_this.hasPaidToSkip}, followerCount: ${_this.followerCount}, canPostOnBlog: ${_this.canPostOnBlog}, chosenTitle: ${_this.chosenTitle}, hasAccessToPremiumContent: ${_this.hasAccessToPremiumContent}, premiumFeaturesUnlocked: ${_this.premiumFeaturesUnlocked})';
}


}

/// @nodoc
abstract mixin class $FaithJourneyCopyWith<$Res>  {
  factory $FaithJourneyCopyWith(FaithJourney value, $Res Function(FaithJourney) _then) = _$FaithJourneyCopyWithImpl;
@useResult
$Res call({
 String userId, UserRole currentRole, List<FaithProgress> progressList, List<FaithMilestone> milestones, int totalDaysRead, int consecutiveDays, int longestStreak, int versesRead, int chaptersRead, List<DateTime> readingHistory, Map<String, int> bookProgress, List<String> achievements, DateTime? startedAt, DateTime? lastUpdatedAt, DateTime? lastReadingDate, DateTime? streakStartDate, bool hasReachedBeliever, bool hasReachedPreacher, bool hasReachedShepherd, bool hasReachedBishop, bool hasPaidToSkip, int followerCount, bool canPostOnBlog, String? chosenTitle, bool hasAccessToPremiumContent, List<String> premiumFeaturesUnlocked
});




}
/// @nodoc
class _$FaithJourneyCopyWithImpl<$Res>
    implements $FaithJourneyCopyWith<$Res> {
  _$FaithJourneyCopyWithImpl(this._self, this._then);

  final FaithJourney _self;
  final $Res Function(FaithJourney) _then;

/// Create a copy of FaithJourney
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? currentRole = null,Object? progressList = null,Object? milestones = null,Object? totalDaysRead = null,Object? consecutiveDays = null,Object? longestStreak = null,Object? versesRead = null,Object? chaptersRead = null,Object? readingHistory = null,Object? bookProgress = null,Object? achievements = null,Object? startedAt = freezed,Object? lastUpdatedAt = freezed,Object? lastReadingDate = freezed,Object? streakStartDate = freezed,Object? hasReachedBeliever = null,Object? hasReachedPreacher = null,Object? hasReachedShepherd = null,Object? hasReachedBishop = null,Object? hasPaidToSkip = null,Object? followerCount = null,Object? canPostOnBlog = null,Object? chosenTitle = freezed,Object? hasAccessToPremiumContent = null,Object? premiumFeaturesUnlocked = null,}) {
  return _then(FaithJourney(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,currentRole: null == currentRole ? _self.currentRole : currentRole // ignore: cast_nullable_to_non_nullable
as UserRole,progressList: null == progressList ? _self.progressList : progressList // ignore: cast_nullable_to_non_nullable
as List<FaithProgress>,milestones: null == milestones ? _self.milestones : milestones // ignore: cast_nullable_to_non_nullable
as List<FaithMilestone>,totalDaysRead: null == totalDaysRead ? _self.totalDaysRead : totalDaysRead // ignore: cast_nullable_to_non_nullable
as int,consecutiveDays: null == consecutiveDays ? _self.consecutiveDays : consecutiveDays // ignore: cast_nullable_to_non_nullable
as int,longestStreak: null == longestStreak ? _self.longestStreak : longestStreak // ignore: cast_nullable_to_non_nullable
as int,versesRead: null == versesRead ? _self.versesRead : versesRead // ignore: cast_nullable_to_non_nullable
as int,chaptersRead: null == chaptersRead ? _self.chaptersRead : chaptersRead // ignore: cast_nullable_to_non_nullable
as int,readingHistory: null == readingHistory ? _self.readingHistory : readingHistory // ignore: cast_nullable_to_non_nullable
as List<DateTime>,bookProgress: null == bookProgress ? _self.bookProgress : bookProgress // ignore: cast_nullable_to_non_nullable
as Map<String, int>,achievements: null == achievements ? _self.achievements : achievements // ignore: cast_nullable_to_non_nullable
as List<String>,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastUpdatedAt: freezed == lastUpdatedAt ? _self.lastUpdatedAt : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastReadingDate: freezed == lastReadingDate ? _self.lastReadingDate : lastReadingDate // ignore: cast_nullable_to_non_nullable
as DateTime?,streakStartDate: freezed == streakStartDate ? _self.streakStartDate : streakStartDate // ignore: cast_nullable_to_non_nullable
as DateTime?,hasReachedBeliever: null == hasReachedBeliever ? _self.hasReachedBeliever : hasReachedBeliever // ignore: cast_nullable_to_non_nullable
as bool,hasReachedPreacher: null == hasReachedPreacher ? _self.hasReachedPreacher : hasReachedPreacher // ignore: cast_nullable_to_non_nullable
as bool,hasReachedShepherd: null == hasReachedShepherd ? _self.hasReachedShepherd : hasReachedShepherd // ignore: cast_nullable_to_non_nullable
as bool,hasReachedBishop: null == hasReachedBishop ? _self.hasReachedBishop : hasReachedBishop // ignore: cast_nullable_to_non_nullable
as bool,hasPaidToSkip: null == hasPaidToSkip ? _self.hasPaidToSkip : hasPaidToSkip // ignore: cast_nullable_to_non_nullable
as bool,followerCount: null == followerCount ? _self.followerCount : followerCount // ignore: cast_nullable_to_non_nullable
as int,canPostOnBlog: null == canPostOnBlog ? _self.canPostOnBlog : canPostOnBlog // ignore: cast_nullable_to_non_nullable
as bool,chosenTitle: freezed == chosenTitle ? _self.chosenTitle : chosenTitle // ignore: cast_nullable_to_non_nullable
as String?,hasAccessToPremiumContent: null == hasAccessToPremiumContent ? _self.hasAccessToPremiumContent : hasAccessToPremiumContent // ignore: cast_nullable_to_non_nullable
as bool,premiumFeaturesUnlocked: null == premiumFeaturesUnlocked ? _self.premiumFeaturesUnlocked : premiumFeaturesUnlocked // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [FaithJourney].
extension FaithJourneyPatterns on FaithJourney {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FaithJourney value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FaithJourney() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FaithJourney value)  $default,){
final _that = this;
switch (_that) {
case _FaithJourney():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FaithJourney value)?  $default,){
final _that = this;
switch (_that) {
case _FaithJourney() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  UserRole currentRole,  List<FaithProgress> progressList,  List<FaithMilestone> milestones,  int totalDaysRead,  int consecutiveDays,  int longestStreak,  int versesRead,  int chaptersRead,  List<DateTime> readingHistory,  Map<String, int> bookProgress,  List<String> achievements,  DateTime? startedAt,  DateTime? lastUpdatedAt,  DateTime? lastReadingDate,  DateTime? streakStartDate,  bool hasReachedBeliever,  bool hasReachedPreacher,  bool hasReachedShepherd,  bool hasReachedBishop,  bool hasPaidToSkip,  int followerCount,  bool canPostOnBlog,  String? chosenTitle,  bool hasAccessToPremiumContent,  List<String> premiumFeaturesUnlocked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FaithJourney() when $default != null:
return $default(_that.userId,_that.currentRole,_that.progressList,_that.milestones,_that.totalDaysRead,_that.consecutiveDays,_that.longestStreak,_that.versesRead,_that.chaptersRead,_that.readingHistory,_that.bookProgress,_that.achievements,_that.startedAt,_that.lastUpdatedAt,_that.lastReadingDate,_that.streakStartDate,_that.hasReachedBeliever,_that.hasReachedPreacher,_that.hasReachedShepherd,_that.hasReachedBishop,_that.hasPaidToSkip,_that.followerCount,_that.canPostOnBlog,_that.chosenTitle,_that.hasAccessToPremiumContent,_that.premiumFeaturesUnlocked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  UserRole currentRole,  List<FaithProgress> progressList,  List<FaithMilestone> milestones,  int totalDaysRead,  int consecutiveDays,  int longestStreak,  int versesRead,  int chaptersRead,  List<DateTime> readingHistory,  Map<String, int> bookProgress,  List<String> achievements,  DateTime? startedAt,  DateTime? lastUpdatedAt,  DateTime? lastReadingDate,  DateTime? streakStartDate,  bool hasReachedBeliever,  bool hasReachedPreacher,  bool hasReachedShepherd,  bool hasReachedBishop,  bool hasPaidToSkip,  int followerCount,  bool canPostOnBlog,  String? chosenTitle,  bool hasAccessToPremiumContent,  List<String> premiumFeaturesUnlocked)  $default,) {final _that = this;
switch (_that) {
case _FaithJourney():
return $default(_that.userId,_that.currentRole,_that.progressList,_that.milestones,_that.totalDaysRead,_that.consecutiveDays,_that.longestStreak,_that.versesRead,_that.chaptersRead,_that.readingHistory,_that.bookProgress,_that.achievements,_that.startedAt,_that.lastUpdatedAt,_that.lastReadingDate,_that.streakStartDate,_that.hasReachedBeliever,_that.hasReachedPreacher,_that.hasReachedShepherd,_that.hasReachedBishop,_that.hasPaidToSkip,_that.followerCount,_that.canPostOnBlog,_that.chosenTitle,_that.hasAccessToPremiumContent,_that.premiumFeaturesUnlocked);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  UserRole currentRole,  List<FaithProgress> progressList,  List<FaithMilestone> milestones,  int totalDaysRead,  int consecutiveDays,  int longestStreak,  int versesRead,  int chaptersRead,  List<DateTime> readingHistory,  Map<String, int> bookProgress,  List<String> achievements,  DateTime? startedAt,  DateTime? lastUpdatedAt,  DateTime? lastReadingDate,  DateTime? streakStartDate,  bool hasReachedBeliever,  bool hasReachedPreacher,  bool hasReachedShepherd,  bool hasReachedBishop,  bool hasPaidToSkip,  int followerCount,  bool canPostOnBlog,  String? chosenTitle,  bool hasAccessToPremiumContent,  List<String> premiumFeaturesUnlocked)?  $default,) {final _that = this;
switch (_that) {
case _FaithJourney() when $default != null:
return $default(_that.userId,_that.currentRole,_that.progressList,_that.milestones,_that.totalDaysRead,_that.consecutiveDays,_that.longestStreak,_that.versesRead,_that.chaptersRead,_that.readingHistory,_that.bookProgress,_that.achievements,_that.startedAt,_that.lastUpdatedAt,_that.lastReadingDate,_that.streakStartDate,_that.hasReachedBeliever,_that.hasReachedPreacher,_that.hasReachedShepherd,_that.hasReachedBishop,_that.hasPaidToSkip,_that.followerCount,_that.canPostOnBlog,_that.chosenTitle,_that.hasAccessToPremiumContent,_that.premiumFeaturesUnlocked);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FaithJourney implements FaithJourney {
  const _FaithJourney({required this.userId, required this.currentRole,  List<FaithProgress> progressList = const [],  List<FaithMilestone> milestones = const [], this.totalDaysRead = 0, this.consecutiveDays = 0, this.longestStreak = 0, this.versesRead = 0, this.chaptersRead = 0,  List<DateTime> readingHistory = const [],  Map<String, int> bookProgress = const {},  List<String> achievements = const [], this.startedAt = null, this.lastUpdatedAt = null, this.lastReadingDate = null, this.streakStartDate = null, this.hasReachedBeliever = false, this.hasReachedPreacher = false, this.hasReachedShepherd = false, this.hasReachedBishop = false, this.hasPaidToSkip = false, this.followerCount = 0, this.canPostOnBlog = false, this.chosenTitle = null, this.hasAccessToPremiumContent = false,  List<String> premiumFeaturesUnlocked = const []}): _progressList = progressList,_milestones = milestones,_readingHistory = readingHistory,_bookProgress = bookProgress,_achievements = achievements,_premiumFeaturesUnlocked = premiumFeaturesUnlocked;
  factory _FaithJourney.fromJson(Map<String, dynamic> json) => _$FaithJourneyFromJson(json);

@override final  String userId;
@override final  UserRole currentRole;
 final  List<FaithProgress> _progressList;
@override@JsonKey() List<FaithProgress> get progressList {
  if (_progressList is EqualUnmodifiableListView) return _progressList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_progressList);
}

 final  List<FaithMilestone> _milestones;
@override@JsonKey() List<FaithMilestone> get milestones {
  if (_milestones is EqualUnmodifiableListView) return _milestones;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_milestones);
}

@override@JsonKey() final  int totalDaysRead;
@override@JsonKey() final  int consecutiveDays;
@override@JsonKey() final  int longestStreak;
@override@JsonKey() final  int versesRead;
@override@JsonKey() final  int chaptersRead;
 final  List<DateTime> _readingHistory;
@override@JsonKey() List<DateTime> get readingHistory {
  if (_readingHistory is EqualUnmodifiableListView) return _readingHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_readingHistory);
}

 final  Map<String, int> _bookProgress;
@override@JsonKey() Map<String, int> get bookProgress {
  if (_bookProgress is EqualUnmodifiableMapView) return _bookProgress;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_bookProgress);
}

 final  List<String> _achievements;
@override@JsonKey() List<String> get achievements {
  if (_achievements is EqualUnmodifiableListView) return _achievements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_achievements);
}

@override@JsonKey() final  DateTime? startedAt;
@override@JsonKey() final  DateTime? lastUpdatedAt;
@override@JsonKey() final  DateTime? lastReadingDate;
@override@JsonKey() final  DateTime? streakStartDate;
@override@JsonKey() final  bool hasReachedBeliever;
@override@JsonKey() final  bool hasReachedPreacher;
@override@JsonKey() final  bool hasReachedShepherd;
@override@JsonKey() final  bool hasReachedBishop;
@override@JsonKey() final  bool hasPaidToSkip;
@override@JsonKey() final  int followerCount;
@override@JsonKey() final  bool canPostOnBlog;
@override@JsonKey() final  String? chosenTitle;
@override@JsonKey() final  bool hasAccessToPremiumContent;
 final  List<String> _premiumFeaturesUnlocked;
@override@JsonKey() List<String> get premiumFeaturesUnlocked {
  if (_premiumFeaturesUnlocked is EqualUnmodifiableListView) return _premiumFeaturesUnlocked;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_premiumFeaturesUnlocked);
}


/// Create a copy of FaithJourney
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FaithJourneyCopyWith<_FaithJourney> get copyWith => __$FaithJourneyCopyWithImpl<_FaithJourney>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FaithJourneyToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FaithJourney&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.currentRole, currentRole) || other.currentRole == currentRole)&&const DeepCollectionEquality().equals(other.progressList, _progressList)&&const DeepCollectionEquality().equals(other.milestones, _milestones)&&(identical(other.totalDaysRead, totalDaysRead) || other.totalDaysRead == totalDaysRead)&&(identical(other.consecutiveDays, consecutiveDays) || other.consecutiveDays == consecutiveDays)&&(identical(other.longestStreak, longestStreak) || other.longestStreak == longestStreak)&&(identical(other.versesRead, versesRead) || other.versesRead == versesRead)&&(identical(other.chaptersRead, chaptersRead) || other.chaptersRead == chaptersRead)&&const DeepCollectionEquality().equals(other.readingHistory, _readingHistory)&&const DeepCollectionEquality().equals(other.bookProgress, _bookProgress)&&const DeepCollectionEquality().equals(other.achievements, _achievements)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.lastUpdatedAt, lastUpdatedAt) || other.lastUpdatedAt == lastUpdatedAt)&&(identical(other.lastReadingDate, lastReadingDate) || other.lastReadingDate == lastReadingDate)&&(identical(other.streakStartDate, streakStartDate) || other.streakStartDate == streakStartDate)&&(identical(other.hasReachedBeliever, hasReachedBeliever) || other.hasReachedBeliever == hasReachedBeliever)&&(identical(other.hasReachedPreacher, hasReachedPreacher) || other.hasReachedPreacher == hasReachedPreacher)&&(identical(other.hasReachedShepherd, hasReachedShepherd) || other.hasReachedShepherd == hasReachedShepherd)&&(identical(other.hasReachedBishop, hasReachedBishop) || other.hasReachedBishop == hasReachedBishop)&&(identical(other.hasPaidToSkip, hasPaidToSkip) || other.hasPaidToSkip == hasPaidToSkip)&&(identical(other.followerCount, followerCount) || other.followerCount == followerCount)&&(identical(other.canPostOnBlog, canPostOnBlog) || other.canPostOnBlog == canPostOnBlog)&&(identical(other.chosenTitle, chosenTitle) || other.chosenTitle == chosenTitle)&&(identical(other.hasAccessToPremiumContent, hasAccessToPremiumContent) || other.hasAccessToPremiumContent == hasAccessToPremiumContent)&&const DeepCollectionEquality().equals(other.premiumFeaturesUnlocked, _premiumFeaturesUnlocked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,userId,currentRole,const DeepCollectionEquality().hash(_progressList),const DeepCollectionEquality().hash(_milestones),totalDaysRead,consecutiveDays,longestStreak,versesRead,chaptersRead,const DeepCollectionEquality().hash(_readingHistory),const DeepCollectionEquality().hash(_bookProgress),const DeepCollectionEquality().hash(_achievements),startedAt,lastUpdatedAt,lastReadingDate,streakStartDate,hasReachedBeliever,hasReachedPreacher,hasReachedShepherd,hasReachedBishop,hasPaidToSkip,followerCount,canPostOnBlog,chosenTitle,hasAccessToPremiumContent,const DeepCollectionEquality().hash(_premiumFeaturesUnlocked)]);
}

@override
String toString() {
    return 'FaithJourney(userId: $userId, currentRole: $currentRole, progressList: $progressList, milestones: $milestones, totalDaysRead: $totalDaysRead, consecutiveDays: $consecutiveDays, longestStreak: $longestStreak, versesRead: $versesRead, chaptersRead: $chaptersRead, readingHistory: $readingHistory, bookProgress: $bookProgress, achievements: $achievements, startedAt: $startedAt, lastUpdatedAt: $lastUpdatedAt, lastReadingDate: $lastReadingDate, streakStartDate: $streakStartDate, hasReachedBeliever: $hasReachedBeliever, hasReachedPreacher: $hasReachedPreacher, hasReachedShepherd: $hasReachedShepherd, hasReachedBishop: $hasReachedBishop, hasPaidToSkip: $hasPaidToSkip, followerCount: $followerCount, canPostOnBlog: $canPostOnBlog, chosenTitle: $chosenTitle, hasAccessToPremiumContent: $hasAccessToPremiumContent, premiumFeaturesUnlocked: $premiumFeaturesUnlocked)';
}


}

/// @nodoc
abstract mixin class _$FaithJourneyCopyWith<$Res> implements $FaithJourneyCopyWith<$Res> {
  factory _$FaithJourneyCopyWith(_FaithJourney value, $Res Function(_FaithJourney) _then) = __$FaithJourneyCopyWithImpl;
@override @useResult
$Res call({
 String userId, UserRole currentRole, List<FaithProgress> progressList, List<FaithMilestone> milestones, int totalDaysRead, int consecutiveDays, int longestStreak, int versesRead, int chaptersRead, List<DateTime> readingHistory, Map<String, int> bookProgress, List<String> achievements, DateTime? startedAt, DateTime? lastUpdatedAt, DateTime? lastReadingDate, DateTime? streakStartDate, bool hasReachedBeliever, bool hasReachedPreacher, bool hasReachedShepherd, bool hasReachedBishop, bool hasPaidToSkip, int followerCount, bool canPostOnBlog, String? chosenTitle, bool hasAccessToPremiumContent, List<String> premiumFeaturesUnlocked
});




}
/// @nodoc
class __$FaithJourneyCopyWithImpl<$Res>
    implements _$FaithJourneyCopyWith<$Res> {
  __$FaithJourneyCopyWithImpl(this._self, this._then);

  final _FaithJourney _self;
  final $Res Function(_FaithJourney) _then;

/// Create a copy of FaithJourney
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? currentRole = null,Object? progressList = null,Object? milestones = null,Object? totalDaysRead = null,Object? consecutiveDays = null,Object? longestStreak = null,Object? versesRead = null,Object? chaptersRead = null,Object? readingHistory = null,Object? bookProgress = null,Object? achievements = null,Object? startedAt = freezed,Object? lastUpdatedAt = freezed,Object? lastReadingDate = freezed,Object? streakStartDate = freezed,Object? hasReachedBeliever = null,Object? hasReachedPreacher = null,Object? hasReachedShepherd = null,Object? hasReachedBishop = null,Object? hasPaidToSkip = null,Object? followerCount = null,Object? canPostOnBlog = null,Object? chosenTitle = freezed,Object? hasAccessToPremiumContent = null,Object? premiumFeaturesUnlocked = null,}) {
  return _then(_FaithJourney(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,currentRole: null == currentRole ? _self.currentRole : currentRole // ignore: cast_nullable_to_non_nullable
as UserRole,progressList: null == progressList ? _self._progressList : progressList // ignore: cast_nullable_to_non_nullable
as List<FaithProgress>,milestones: null == milestones ? _self._milestones : milestones // ignore: cast_nullable_to_non_nullable
as List<FaithMilestone>,totalDaysRead: null == totalDaysRead ? _self.totalDaysRead : totalDaysRead // ignore: cast_nullable_to_non_nullable
as int,consecutiveDays: null == consecutiveDays ? _self.consecutiveDays : consecutiveDays // ignore: cast_nullable_to_non_nullable
as int,longestStreak: null == longestStreak ? _self.longestStreak : longestStreak // ignore: cast_nullable_to_non_nullable
as int,versesRead: null == versesRead ? _self.versesRead : versesRead // ignore: cast_nullable_to_non_nullable
as int,chaptersRead: null == chaptersRead ? _self.chaptersRead : chaptersRead // ignore: cast_nullable_to_non_nullable
as int,readingHistory: null == readingHistory ? _self._readingHistory : readingHistory // ignore: cast_nullable_to_non_nullable
as List<DateTime>,bookProgress: null == bookProgress ? _self._bookProgress : bookProgress // ignore: cast_nullable_to_non_nullable
as Map<String, int>,achievements: null == achievements ? _self._achievements : achievements // ignore: cast_nullable_to_non_nullable
as List<String>,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastUpdatedAt: freezed == lastUpdatedAt ? _self.lastUpdatedAt : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastReadingDate: freezed == lastReadingDate ? _self.lastReadingDate : lastReadingDate // ignore: cast_nullable_to_non_nullable
as DateTime?,streakStartDate: freezed == streakStartDate ? _self.streakStartDate : streakStartDate // ignore: cast_nullable_to_non_nullable
as DateTime?,hasReachedBeliever: null == hasReachedBeliever ? _self.hasReachedBeliever : hasReachedBeliever // ignore: cast_nullable_to_non_nullable
as bool,hasReachedPreacher: null == hasReachedPreacher ? _self.hasReachedPreacher : hasReachedPreacher // ignore: cast_nullable_to_non_nullable
as bool,hasReachedShepherd: null == hasReachedShepherd ? _self.hasReachedShepherd : hasReachedShepherd // ignore: cast_nullable_to_non_nullable
as bool,hasReachedBishop: null == hasReachedBishop ? _self.hasReachedBishop : hasReachedBishop // ignore: cast_nullable_to_non_nullable
as bool,hasPaidToSkip: null == hasPaidToSkip ? _self.hasPaidToSkip : hasPaidToSkip // ignore: cast_nullable_to_non_nullable
as bool,followerCount: null == followerCount ? _self.followerCount : followerCount // ignore: cast_nullable_to_non_nullable
as int,canPostOnBlog: null == canPostOnBlog ? _self.canPostOnBlog : canPostOnBlog // ignore: cast_nullable_to_non_nullable
as bool,chosenTitle: freezed == chosenTitle ? _self.chosenTitle : chosenTitle // ignore: cast_nullable_to_non_nullable
as String?,hasAccessToPremiumContent: null == hasAccessToPremiumContent ? _self.hasAccessToPremiumContent : hasAccessToPremiumContent // ignore: cast_nullable_to_non_nullable
as bool,premiumFeaturesUnlocked: null == premiumFeaturesUnlocked ? _self._premiumFeaturesUnlocked : premiumFeaturesUnlocked // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$ReadingHabit {

 String get userId; List<int> get preferredHours; List<int> get preferredDays; DateTime? get mostActiveTime; int get averageReadsPerDay; int get averageDurationMinutes; List<ReadingSession> get recentSessions; DateTime? get lastReminderSent; bool get notificationsEnabled; String get reminderTime; bool get remindOnOffWorkHours;
/// Create a copy of ReadingHabit
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingHabitCopyWith<ReadingHabit> get copyWith => _$ReadingHabitCopyWithImpl<ReadingHabit>(this as ReadingHabit, _$identity);

  /// Serializes this ReadingHabit to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReadingHabit;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingHabit&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&const DeepCollectionEquality().equals(other.preferredHours, _this.preferredHours)&&const DeepCollectionEquality().equals(other.preferredDays, _this.preferredDays)&&(identical(other.mostActiveTime, _this.mostActiveTime) || other.mostActiveTime == _this.mostActiveTime)&&(identical(other.averageReadsPerDay, _this.averageReadsPerDay) || other.averageReadsPerDay == _this.averageReadsPerDay)&&(identical(other.averageDurationMinutes, _this.averageDurationMinutes) || other.averageDurationMinutes == _this.averageDurationMinutes)&&const DeepCollectionEquality().equals(other.recentSessions, _this.recentSessions)&&(identical(other.lastReminderSent, _this.lastReminderSent) || other.lastReminderSent == _this.lastReminderSent)&&(identical(other.notificationsEnabled, _this.notificationsEnabled) || other.notificationsEnabled == _this.notificationsEnabled)&&(identical(other.reminderTime, _this.reminderTime) || other.reminderTime == _this.reminderTime)&&(identical(other.remindOnOffWorkHours, _this.remindOnOffWorkHours) || other.remindOnOffWorkHours == _this.remindOnOffWorkHours));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReadingHabit;
  return Object.hash(runtimeType,_this.userId,const DeepCollectionEquality().hash(_this.preferredHours),const DeepCollectionEquality().hash(_this.preferredDays),_this.mostActiveTime,_this.averageReadsPerDay,_this.averageDurationMinutes,const DeepCollectionEquality().hash(_this.recentSessions),_this.lastReminderSent,_this.notificationsEnabled,_this.reminderTime,_this.remindOnOffWorkHours);
}

@override
String toString() {
  final _this = this as ReadingHabit;
  return 'ReadingHabit(userId: ${_this.userId}, preferredHours: ${_this.preferredHours}, preferredDays: ${_this.preferredDays}, mostActiveTime: ${_this.mostActiveTime}, averageReadsPerDay: ${_this.averageReadsPerDay}, averageDurationMinutes: ${_this.averageDurationMinutes}, recentSessions: ${_this.recentSessions}, lastReminderSent: ${_this.lastReminderSent}, notificationsEnabled: ${_this.notificationsEnabled}, reminderTime: ${_this.reminderTime}, remindOnOffWorkHours: ${_this.remindOnOffWorkHours})';
}


}

/// @nodoc
abstract mixin class $ReadingHabitCopyWith<$Res>  {
  factory $ReadingHabitCopyWith(ReadingHabit value, $Res Function(ReadingHabit) _then) = _$ReadingHabitCopyWithImpl;
@useResult
$Res call({
 String userId, List<int> preferredHours, List<int> preferredDays, DateTime? mostActiveTime, int averageReadsPerDay, int averageDurationMinutes, List<ReadingSession> recentSessions, DateTime? lastReminderSent, bool notificationsEnabled, String reminderTime, bool remindOnOffWorkHours
});




}
/// @nodoc
class _$ReadingHabitCopyWithImpl<$Res>
    implements $ReadingHabitCopyWith<$Res> {
  _$ReadingHabitCopyWithImpl(this._self, this._then);

  final ReadingHabit _self;
  final $Res Function(ReadingHabit) _then;

/// Create a copy of ReadingHabit
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? preferredHours = null,Object? preferredDays = null,Object? mostActiveTime = freezed,Object? averageReadsPerDay = null,Object? averageDurationMinutes = null,Object? recentSessions = null,Object? lastReminderSent = freezed,Object? notificationsEnabled = null,Object? reminderTime = null,Object? remindOnOffWorkHours = null,}) {
  return _then(ReadingHabit(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,preferredHours: null == preferredHours ? _self.preferredHours : preferredHours // ignore: cast_nullable_to_non_nullable
as List<int>,preferredDays: null == preferredDays ? _self.preferredDays : preferredDays // ignore: cast_nullable_to_non_nullable
as List<int>,mostActiveTime: freezed == mostActiveTime ? _self.mostActiveTime : mostActiveTime // ignore: cast_nullable_to_non_nullable
as DateTime?,averageReadsPerDay: null == averageReadsPerDay ? _self.averageReadsPerDay : averageReadsPerDay // ignore: cast_nullable_to_non_nullable
as int,averageDurationMinutes: null == averageDurationMinutes ? _self.averageDurationMinutes : averageDurationMinutes // ignore: cast_nullable_to_non_nullable
as int,recentSessions: null == recentSessions ? _self.recentSessions : recentSessions // ignore: cast_nullable_to_non_nullable
as List<ReadingSession>,lastReminderSent: freezed == lastReminderSent ? _self.lastReminderSent : lastReminderSent // ignore: cast_nullable_to_non_nullable
as DateTime?,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,reminderTime: null == reminderTime ? _self.reminderTime : reminderTime // ignore: cast_nullable_to_non_nullable
as String,remindOnOffWorkHours: null == remindOnOffWorkHours ? _self.remindOnOffWorkHours : remindOnOffWorkHours // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ReadingHabit].
extension ReadingHabitPatterns on ReadingHabit {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadingHabit value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadingHabit() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadingHabit value)  $default,){
final _that = this;
switch (_that) {
case _ReadingHabit():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadingHabit value)?  $default,){
final _that = this;
switch (_that) {
case _ReadingHabit() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  List<int> preferredHours,  List<int> preferredDays,  DateTime? mostActiveTime,  int averageReadsPerDay,  int averageDurationMinutes,  List<ReadingSession> recentSessions,  DateTime? lastReminderSent,  bool notificationsEnabled,  String reminderTime,  bool remindOnOffWorkHours)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadingHabit() when $default != null:
return $default(_that.userId,_that.preferredHours,_that.preferredDays,_that.mostActiveTime,_that.averageReadsPerDay,_that.averageDurationMinutes,_that.recentSessions,_that.lastReminderSent,_that.notificationsEnabled,_that.reminderTime,_that.remindOnOffWorkHours);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  List<int> preferredHours,  List<int> preferredDays,  DateTime? mostActiveTime,  int averageReadsPerDay,  int averageDurationMinutes,  List<ReadingSession> recentSessions,  DateTime? lastReminderSent,  bool notificationsEnabled,  String reminderTime,  bool remindOnOffWorkHours)  $default,) {final _that = this;
switch (_that) {
case _ReadingHabit():
return $default(_that.userId,_that.preferredHours,_that.preferredDays,_that.mostActiveTime,_that.averageReadsPerDay,_that.averageDurationMinutes,_that.recentSessions,_that.lastReminderSent,_that.notificationsEnabled,_that.reminderTime,_that.remindOnOffWorkHours);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  List<int> preferredHours,  List<int> preferredDays,  DateTime? mostActiveTime,  int averageReadsPerDay,  int averageDurationMinutes,  List<ReadingSession> recentSessions,  DateTime? lastReminderSent,  bool notificationsEnabled,  String reminderTime,  bool remindOnOffWorkHours)?  $default,) {final _that = this;
switch (_that) {
case _ReadingHabit() when $default != null:
return $default(_that.userId,_that.preferredHours,_that.preferredDays,_that.mostActiveTime,_that.averageReadsPerDay,_that.averageDurationMinutes,_that.recentSessions,_that.lastReminderSent,_that.notificationsEnabled,_that.reminderTime,_that.remindOnOffWorkHours);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadingHabit implements ReadingHabit {
  const _ReadingHabit({required this.userId,  List<int> preferredHours = const [],  List<int> preferredDays = const [], this.mostActiveTime = null, this.averageReadsPerDay = 0, this.averageDurationMinutes = 0,  List<ReadingSession> recentSessions = const [], this.lastReminderSent = null, this.notificationsEnabled = false, this.reminderTime = '09:00', this.remindOnOffWorkHours = true}): _preferredHours = preferredHours,_preferredDays = preferredDays,_recentSessions = recentSessions;
  factory _ReadingHabit.fromJson(Map<String, dynamic> json) => _$ReadingHabitFromJson(json);

@override final  String userId;
 final  List<int> _preferredHours;
@override@JsonKey() List<int> get preferredHours {
  if (_preferredHours is EqualUnmodifiableListView) return _preferredHours;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_preferredHours);
}

 final  List<int> _preferredDays;
@override@JsonKey() List<int> get preferredDays {
  if (_preferredDays is EqualUnmodifiableListView) return _preferredDays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_preferredDays);
}

@override@JsonKey() final  DateTime? mostActiveTime;
@override@JsonKey() final  int averageReadsPerDay;
@override@JsonKey() final  int averageDurationMinutes;
 final  List<ReadingSession> _recentSessions;
@override@JsonKey() List<ReadingSession> get recentSessions {
  if (_recentSessions is EqualUnmodifiableListView) return _recentSessions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentSessions);
}

@override@JsonKey() final  DateTime? lastReminderSent;
@override@JsonKey() final  bool notificationsEnabled;
@override@JsonKey() final  String reminderTime;
@override@JsonKey() final  bool remindOnOffWorkHours;

/// Create a copy of ReadingHabit
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingHabitCopyWith<_ReadingHabit> get copyWith => __$ReadingHabitCopyWithImpl<_ReadingHabit>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadingHabitToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingHabit&&(identical(other.userId, userId) || other.userId == userId)&&const DeepCollectionEquality().equals(other.preferredHours, _preferredHours)&&const DeepCollectionEquality().equals(other.preferredDays, _preferredDays)&&(identical(other.mostActiveTime, mostActiveTime) || other.mostActiveTime == mostActiveTime)&&(identical(other.averageReadsPerDay, averageReadsPerDay) || other.averageReadsPerDay == averageReadsPerDay)&&(identical(other.averageDurationMinutes, averageDurationMinutes) || other.averageDurationMinutes == averageDurationMinutes)&&const DeepCollectionEquality().equals(other.recentSessions, _recentSessions)&&(identical(other.lastReminderSent, lastReminderSent) || other.lastReminderSent == lastReminderSent)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.reminderTime, reminderTime) || other.reminderTime == reminderTime)&&(identical(other.remindOnOffWorkHours, remindOnOffWorkHours) || other.remindOnOffWorkHours == remindOnOffWorkHours));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,userId,const DeepCollectionEquality().hash(_preferredHours),const DeepCollectionEquality().hash(_preferredDays),mostActiveTime,averageReadsPerDay,averageDurationMinutes,const DeepCollectionEquality().hash(_recentSessions),lastReminderSent,notificationsEnabled,reminderTime,remindOnOffWorkHours);
}

@override
String toString() {
    return 'ReadingHabit(userId: $userId, preferredHours: $preferredHours, preferredDays: $preferredDays, mostActiveTime: $mostActiveTime, averageReadsPerDay: $averageReadsPerDay, averageDurationMinutes: $averageDurationMinutes, recentSessions: $recentSessions, lastReminderSent: $lastReminderSent, notificationsEnabled: $notificationsEnabled, reminderTime: $reminderTime, remindOnOffWorkHours: $remindOnOffWorkHours)';
}


}

/// @nodoc
abstract mixin class _$ReadingHabitCopyWith<$Res> implements $ReadingHabitCopyWith<$Res> {
  factory _$ReadingHabitCopyWith(_ReadingHabit value, $Res Function(_ReadingHabit) _then) = __$ReadingHabitCopyWithImpl;
@override @useResult
$Res call({
 String userId, List<int> preferredHours, List<int> preferredDays, DateTime? mostActiveTime, int averageReadsPerDay, int averageDurationMinutes, List<ReadingSession> recentSessions, DateTime? lastReminderSent, bool notificationsEnabled, String reminderTime, bool remindOnOffWorkHours
});




}
/// @nodoc
class __$ReadingHabitCopyWithImpl<$Res>
    implements _$ReadingHabitCopyWith<$Res> {
  __$ReadingHabitCopyWithImpl(this._self, this._then);

  final _ReadingHabit _self;
  final $Res Function(_ReadingHabit) _then;

/// Create a copy of ReadingHabit
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? preferredHours = null,Object? preferredDays = null,Object? mostActiveTime = freezed,Object? averageReadsPerDay = null,Object? averageDurationMinutes = null,Object? recentSessions = null,Object? lastReminderSent = freezed,Object? notificationsEnabled = null,Object? reminderTime = null,Object? remindOnOffWorkHours = null,}) {
  return _then(_ReadingHabit(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,preferredHours: null == preferredHours ? _self._preferredHours : preferredHours // ignore: cast_nullable_to_non_nullable
as List<int>,preferredDays: null == preferredDays ? _self._preferredDays : preferredDays // ignore: cast_nullable_to_non_nullable
as List<int>,mostActiveTime: freezed == mostActiveTime ? _self.mostActiveTime : mostActiveTime // ignore: cast_nullable_to_non_nullable
as DateTime?,averageReadsPerDay: null == averageReadsPerDay ? _self.averageReadsPerDay : averageReadsPerDay // ignore: cast_nullable_to_non_nullable
as int,averageDurationMinutes: null == averageDurationMinutes ? _self.averageDurationMinutes : averageDurationMinutes // ignore: cast_nullable_to_non_nullable
as int,recentSessions: null == recentSessions ? _self._recentSessions : recentSessions // ignore: cast_nullable_to_non_nullable
as List<ReadingSession>,lastReminderSent: freezed == lastReminderSent ? _self.lastReminderSent : lastReminderSent // ignore: cast_nullable_to_non_nullable
as DateTime?,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,reminderTime: null == reminderTime ? _self.reminderTime : reminderTime // ignore: cast_nullable_to_non_nullable
as String,remindOnOffWorkHours: null == remindOnOffWorkHours ? _self.remindOnOffWorkHours : remindOnOffWorkHours // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ReadingSession {

 String get id; String get userId; DateTime get startedAt; DateTime? get endedAt; int get durationMinutes; int get versesRead; int get chaptersRead; String? get book; List<String> get verses; String? get notes; bool get isCompleted;
/// Create a copy of ReadingSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingSessionCopyWith<ReadingSession> get copyWith => _$ReadingSessionCopyWithImpl<ReadingSession>(this as ReadingSession, _$identity);

  /// Serializes this ReadingSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ReadingSession;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingSession&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.startedAt, _this.startedAt) || other.startedAt == _this.startedAt)&&(identical(other.endedAt, _this.endedAt) || other.endedAt == _this.endedAt)&&(identical(other.durationMinutes, _this.durationMinutes) || other.durationMinutes == _this.durationMinutes)&&(identical(other.versesRead, _this.versesRead) || other.versesRead == _this.versesRead)&&(identical(other.chaptersRead, _this.chaptersRead) || other.chaptersRead == _this.chaptersRead)&&(identical(other.book, _this.book) || other.book == _this.book)&&const DeepCollectionEquality().equals(other.verses, _this.verses)&&(identical(other.notes, _this.notes) || other.notes == _this.notes)&&(identical(other.isCompleted, _this.isCompleted) || other.isCompleted == _this.isCompleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ReadingSession;
  return Object.hash(runtimeType,_this.id,_this.userId,_this.startedAt,_this.endedAt,_this.durationMinutes,_this.versesRead,_this.chaptersRead,_this.book,const DeepCollectionEquality().hash(_this.verses),_this.notes,_this.isCompleted);
}

@override
String toString() {
  final _this = this as ReadingSession;
  return 'ReadingSession(id: ${_this.id}, userId: ${_this.userId}, startedAt: ${_this.startedAt}, endedAt: ${_this.endedAt}, durationMinutes: ${_this.durationMinutes}, versesRead: ${_this.versesRead}, chaptersRead: ${_this.chaptersRead}, book: ${_this.book}, verses: ${_this.verses}, notes: ${_this.notes}, isCompleted: ${_this.isCompleted})';
}


}

/// @nodoc
abstract mixin class $ReadingSessionCopyWith<$Res>  {
  factory $ReadingSessionCopyWith(ReadingSession value, $Res Function(ReadingSession) _then) = _$ReadingSessionCopyWithImpl;
@useResult
$Res call({
 String id, String userId, DateTime startedAt, DateTime? endedAt, int durationMinutes, int versesRead, int chaptersRead, String? book, List<String> verses, String? notes, bool isCompleted
});




}
/// @nodoc
class _$ReadingSessionCopyWithImpl<$Res>
    implements $ReadingSessionCopyWith<$Res> {
  _$ReadingSessionCopyWithImpl(this._self, this._then);

  final ReadingSession _self;
  final $Res Function(ReadingSession) _then;

/// Create a copy of ReadingSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? startedAt = null,Object? endedAt = freezed,Object? durationMinutes = null,Object? versesRead = null,Object? chaptersRead = null,Object? book = freezed,Object? verses = null,Object? notes = freezed,Object? isCompleted = null,}) {
  return _then(ReadingSession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,versesRead: null == versesRead ? _self.versesRead : versesRead // ignore: cast_nullable_to_non_nullable
as int,chaptersRead: null == chaptersRead ? _self.chaptersRead : chaptersRead // ignore: cast_nullable_to_non_nullable
as int,book: freezed == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as String?,verses: null == verses ? _self.verses : verses // ignore: cast_nullable_to_non_nullable
as List<String>,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ReadingSession].
extension ReadingSessionPatterns on ReadingSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadingSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadingSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadingSession value)  $default,){
final _that = this;
switch (_that) {
case _ReadingSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadingSession value)?  $default,){
final _that = this;
switch (_that) {
case _ReadingSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  DateTime startedAt,  DateTime? endedAt,  int durationMinutes,  int versesRead,  int chaptersRead,  String? book,  List<String> verses,  String? notes,  bool isCompleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadingSession() when $default != null:
return $default(_that.id,_that.userId,_that.startedAt,_that.endedAt,_that.durationMinutes,_that.versesRead,_that.chaptersRead,_that.book,_that.verses,_that.notes,_that.isCompleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  DateTime startedAt,  DateTime? endedAt,  int durationMinutes,  int versesRead,  int chaptersRead,  String? book,  List<String> verses,  String? notes,  bool isCompleted)  $default,) {final _that = this;
switch (_that) {
case _ReadingSession():
return $default(_that.id,_that.userId,_that.startedAt,_that.endedAt,_that.durationMinutes,_that.versesRead,_that.chaptersRead,_that.book,_that.verses,_that.notes,_that.isCompleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  DateTime startedAt,  DateTime? endedAt,  int durationMinutes,  int versesRead,  int chaptersRead,  String? book,  List<String> verses,  String? notes,  bool isCompleted)?  $default,) {final _that = this;
switch (_that) {
case _ReadingSession() when $default != null:
return $default(_that.id,_that.userId,_that.startedAt,_that.endedAt,_that.durationMinutes,_that.versesRead,_that.chaptersRead,_that.book,_that.verses,_that.notes,_that.isCompleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadingSession implements ReadingSession {
  const _ReadingSession({required this.id, required this.userId, required this.startedAt, this.endedAt = null, this.durationMinutes = 0, this.versesRead = 0, this.chaptersRead = 0, this.book,  List<String> verses = const [], this.notes = null, this.isCompleted = false}): _verses = verses;
  factory _ReadingSession.fromJson(Map<String, dynamic> json) => _$ReadingSessionFromJson(json);

@override final  String id;
@override final  String userId;
@override final  DateTime startedAt;
@override@JsonKey() final  DateTime? endedAt;
@override@JsonKey() final  int durationMinutes;
@override@JsonKey() final  int versesRead;
@override@JsonKey() final  int chaptersRead;
@override final  String? book;
 final  List<String> _verses;
@override@JsonKey() List<String> get verses {
  if (_verses is EqualUnmodifiableListView) return _verses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_verses);
}

@override@JsonKey() final  String? notes;
@override@JsonKey() final  bool isCompleted;

/// Create a copy of ReadingSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingSessionCopyWith<_ReadingSession> get copyWith => __$ReadingSessionCopyWithImpl<_ReadingSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadingSessionToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingSession&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.versesRead, versesRead) || other.versesRead == versesRead)&&(identical(other.chaptersRead, chaptersRead) || other.chaptersRead == chaptersRead)&&(identical(other.book, book) || other.book == book)&&const DeepCollectionEquality().equals(other.verses, _verses)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,userId,startedAt,endedAt,durationMinutes,versesRead,chaptersRead,book,const DeepCollectionEquality().hash(_verses),notes,isCompleted);
}

@override
String toString() {
    return 'ReadingSession(id: $id, userId: $userId, startedAt: $startedAt, endedAt: $endedAt, durationMinutes: $durationMinutes, versesRead: $versesRead, chaptersRead: $chaptersRead, book: $book, verses: $verses, notes: $notes, isCompleted: $isCompleted)';
}


}

/// @nodoc
abstract mixin class _$ReadingSessionCopyWith<$Res> implements $ReadingSessionCopyWith<$Res> {
  factory _$ReadingSessionCopyWith(_ReadingSession value, $Res Function(_ReadingSession) _then) = __$ReadingSessionCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, DateTime startedAt, DateTime? endedAt, int durationMinutes, int versesRead, int chaptersRead, String? book, List<String> verses, String? notes, bool isCompleted
});




}
/// @nodoc
class __$ReadingSessionCopyWithImpl<$Res>
    implements _$ReadingSessionCopyWith<$Res> {
  __$ReadingSessionCopyWithImpl(this._self, this._then);

  final _ReadingSession _self;
  final $Res Function(_ReadingSession) _then;

/// Create a copy of ReadingSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? startedAt = null,Object? endedAt = freezed,Object? durationMinutes = null,Object? versesRead = null,Object? chaptersRead = null,Object? book = freezed,Object? verses = null,Object? notes = freezed,Object? isCompleted = null,}) {
  return _then(_ReadingSession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,versesRead: null == versesRead ? _self.versesRead : versesRead // ignore: cast_nullable_to_non_nullable
as int,chaptersRead: null == chaptersRead ? _self.chaptersRead : chaptersRead // ignore: cast_nullable_to_non_nullable
as int,book: freezed == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as String?,verses: null == verses ? _self._verses : verses // ignore: cast_nullable_to_non_nullable
as List<String>,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$FaithJourneyStats {

 String get userId; UserRole get currentRole; String get currentRoleDisplayName; int get daysToNextRole; double get progressToNextRole; String get nextRoleName; List<FaithMilestone> get recentMilestones; List<FaithProgress> get roleProgress; int get totalReadingStreak; int get totalVersesRead; int get totalFollowers; bool get canBecomeBishop; bool get canPostOnBlog; String? get chosenTitle; List<String> get availableTitles;
/// Create a copy of FaithJourneyStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FaithJourneyStatsCopyWith<FaithJourneyStats> get copyWith => _$FaithJourneyStatsCopyWithImpl<FaithJourneyStats>(this as FaithJourneyStats, _$identity);

  /// Serializes this FaithJourneyStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as FaithJourneyStats;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FaithJourneyStats&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.currentRole, _this.currentRole) || other.currentRole == _this.currentRole)&&(identical(other.currentRoleDisplayName, _this.currentRoleDisplayName) || other.currentRoleDisplayName == _this.currentRoleDisplayName)&&(identical(other.daysToNextRole, _this.daysToNextRole) || other.daysToNextRole == _this.daysToNextRole)&&(identical(other.progressToNextRole, _this.progressToNextRole) || other.progressToNextRole == _this.progressToNextRole)&&(identical(other.nextRoleName, _this.nextRoleName) || other.nextRoleName == _this.nextRoleName)&&const DeepCollectionEquality().equals(other.recentMilestones, _this.recentMilestones)&&const DeepCollectionEquality().equals(other.roleProgress, _this.roleProgress)&&(identical(other.totalReadingStreak, _this.totalReadingStreak) || other.totalReadingStreak == _this.totalReadingStreak)&&(identical(other.totalVersesRead, _this.totalVersesRead) || other.totalVersesRead == _this.totalVersesRead)&&(identical(other.totalFollowers, _this.totalFollowers) || other.totalFollowers == _this.totalFollowers)&&(identical(other.canBecomeBishop, _this.canBecomeBishop) || other.canBecomeBishop == _this.canBecomeBishop)&&(identical(other.canPostOnBlog, _this.canPostOnBlog) || other.canPostOnBlog == _this.canPostOnBlog)&&(identical(other.chosenTitle, _this.chosenTitle) || other.chosenTitle == _this.chosenTitle)&&const DeepCollectionEquality().equals(other.availableTitles, _this.availableTitles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as FaithJourneyStats;
  return Object.hash(runtimeType,_this.userId,_this.currentRole,_this.currentRoleDisplayName,_this.daysToNextRole,_this.progressToNextRole,_this.nextRoleName,const DeepCollectionEquality().hash(_this.recentMilestones),const DeepCollectionEquality().hash(_this.roleProgress),_this.totalReadingStreak,_this.totalVersesRead,_this.totalFollowers,_this.canBecomeBishop,_this.canPostOnBlog,_this.chosenTitle,const DeepCollectionEquality().hash(_this.availableTitles));
}

@override
String toString() {
  final _this = this as FaithJourneyStats;
  return 'FaithJourneyStats(userId: ${_this.userId}, currentRole: ${_this.currentRole}, currentRoleDisplayName: ${_this.currentRoleDisplayName}, daysToNextRole: ${_this.daysToNextRole}, progressToNextRole: ${_this.progressToNextRole}, nextRoleName: ${_this.nextRoleName}, recentMilestones: ${_this.recentMilestones}, roleProgress: ${_this.roleProgress}, totalReadingStreak: ${_this.totalReadingStreak}, totalVersesRead: ${_this.totalVersesRead}, totalFollowers: ${_this.totalFollowers}, canBecomeBishop: ${_this.canBecomeBishop}, canPostOnBlog: ${_this.canPostOnBlog}, chosenTitle: ${_this.chosenTitle}, availableTitles: ${_this.availableTitles})';
}


}

/// @nodoc
abstract mixin class $FaithJourneyStatsCopyWith<$Res>  {
  factory $FaithJourneyStatsCopyWith(FaithJourneyStats value, $Res Function(FaithJourneyStats) _then) = _$FaithJourneyStatsCopyWithImpl;
@useResult
$Res call({
 String userId, UserRole currentRole, String currentRoleDisplayName, int daysToNextRole, double progressToNextRole, String nextRoleName, List<FaithMilestone> recentMilestones, List<FaithProgress> roleProgress, int totalReadingStreak, int totalVersesRead, int totalFollowers, bool canBecomeBishop, bool canPostOnBlog, String? chosenTitle, List<String> availableTitles
});




}
/// @nodoc
class _$FaithJourneyStatsCopyWithImpl<$Res>
    implements $FaithJourneyStatsCopyWith<$Res> {
  _$FaithJourneyStatsCopyWithImpl(this._self, this._then);

  final FaithJourneyStats _self;
  final $Res Function(FaithJourneyStats) _then;

/// Create a copy of FaithJourneyStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? currentRole = null,Object? currentRoleDisplayName = null,Object? daysToNextRole = null,Object? progressToNextRole = null,Object? nextRoleName = null,Object? recentMilestones = null,Object? roleProgress = null,Object? totalReadingStreak = null,Object? totalVersesRead = null,Object? totalFollowers = null,Object? canBecomeBishop = null,Object? canPostOnBlog = null,Object? chosenTitle = freezed,Object? availableTitles = null,}) {
  return _then(FaithJourneyStats(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,currentRole: null == currentRole ? _self.currentRole : currentRole // ignore: cast_nullable_to_non_nullable
as UserRole,currentRoleDisplayName: null == currentRoleDisplayName ? _self.currentRoleDisplayName : currentRoleDisplayName // ignore: cast_nullable_to_non_nullable
as String,daysToNextRole: null == daysToNextRole ? _self.daysToNextRole : daysToNextRole // ignore: cast_nullable_to_non_nullable
as int,progressToNextRole: null == progressToNextRole ? _self.progressToNextRole : progressToNextRole // ignore: cast_nullable_to_non_nullable
as double,nextRoleName: null == nextRoleName ? _self.nextRoleName : nextRoleName // ignore: cast_nullable_to_non_nullable
as String,recentMilestones: null == recentMilestones ? _self.recentMilestones : recentMilestones // ignore: cast_nullable_to_non_nullable
as List<FaithMilestone>,roleProgress: null == roleProgress ? _self.roleProgress : roleProgress // ignore: cast_nullable_to_non_nullable
as List<FaithProgress>,totalReadingStreak: null == totalReadingStreak ? _self.totalReadingStreak : totalReadingStreak // ignore: cast_nullable_to_non_nullable
as int,totalVersesRead: null == totalVersesRead ? _self.totalVersesRead : totalVersesRead // ignore: cast_nullable_to_non_nullable
as int,totalFollowers: null == totalFollowers ? _self.totalFollowers : totalFollowers // ignore: cast_nullable_to_non_nullable
as int,canBecomeBishop: null == canBecomeBishop ? _self.canBecomeBishop : canBecomeBishop // ignore: cast_nullable_to_non_nullable
as bool,canPostOnBlog: null == canPostOnBlog ? _self.canPostOnBlog : canPostOnBlog // ignore: cast_nullable_to_non_nullable
as bool,chosenTitle: freezed == chosenTitle ? _self.chosenTitle : chosenTitle // ignore: cast_nullable_to_non_nullable
as String?,availableTitles: null == availableTitles ? _self.availableTitles : availableTitles // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [FaithJourneyStats].
extension FaithJourneyStatsPatterns on FaithJourneyStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FaithJourneyStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FaithJourneyStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FaithJourneyStats value)  $default,){
final _that = this;
switch (_that) {
case _FaithJourneyStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FaithJourneyStats value)?  $default,){
final _that = this;
switch (_that) {
case _FaithJourneyStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  UserRole currentRole,  String currentRoleDisplayName,  int daysToNextRole,  double progressToNextRole,  String nextRoleName,  List<FaithMilestone> recentMilestones,  List<FaithProgress> roleProgress,  int totalReadingStreak,  int totalVersesRead,  int totalFollowers,  bool canBecomeBishop,  bool canPostOnBlog,  String? chosenTitle,  List<String> availableTitles)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FaithJourneyStats() when $default != null:
return $default(_that.userId,_that.currentRole,_that.currentRoleDisplayName,_that.daysToNextRole,_that.progressToNextRole,_that.nextRoleName,_that.recentMilestones,_that.roleProgress,_that.totalReadingStreak,_that.totalVersesRead,_that.totalFollowers,_that.canBecomeBishop,_that.canPostOnBlog,_that.chosenTitle,_that.availableTitles);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  UserRole currentRole,  String currentRoleDisplayName,  int daysToNextRole,  double progressToNextRole,  String nextRoleName,  List<FaithMilestone> recentMilestones,  List<FaithProgress> roleProgress,  int totalReadingStreak,  int totalVersesRead,  int totalFollowers,  bool canBecomeBishop,  bool canPostOnBlog,  String? chosenTitle,  List<String> availableTitles)  $default,) {final _that = this;
switch (_that) {
case _FaithJourneyStats():
return $default(_that.userId,_that.currentRole,_that.currentRoleDisplayName,_that.daysToNextRole,_that.progressToNextRole,_that.nextRoleName,_that.recentMilestones,_that.roleProgress,_that.totalReadingStreak,_that.totalVersesRead,_that.totalFollowers,_that.canBecomeBishop,_that.canPostOnBlog,_that.chosenTitle,_that.availableTitles);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  UserRole currentRole,  String currentRoleDisplayName,  int daysToNextRole,  double progressToNextRole,  String nextRoleName,  List<FaithMilestone> recentMilestones,  List<FaithProgress> roleProgress,  int totalReadingStreak,  int totalVersesRead,  int totalFollowers,  bool canBecomeBishop,  bool canPostOnBlog,  String? chosenTitle,  List<String> availableTitles)?  $default,) {final _that = this;
switch (_that) {
case _FaithJourneyStats() when $default != null:
return $default(_that.userId,_that.currentRole,_that.currentRoleDisplayName,_that.daysToNextRole,_that.progressToNextRole,_that.nextRoleName,_that.recentMilestones,_that.roleProgress,_that.totalReadingStreak,_that.totalVersesRead,_that.totalFollowers,_that.canBecomeBishop,_that.canPostOnBlog,_that.chosenTitle,_that.availableTitles);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FaithJourneyStats implements FaithJourneyStats {
  const _FaithJourneyStats({required this.userId, required this.currentRole, required this.currentRoleDisplayName, required this.daysToNextRole, required this.progressToNextRole, required this.nextRoleName, required  List<FaithMilestone> recentMilestones, required  List<FaithProgress> roleProgress, required this.totalReadingStreak, required this.totalVersesRead, required this.totalFollowers, this.canBecomeBishop = false, this.canPostOnBlog = false, this.chosenTitle,  List<String> availableTitles = const []}): _recentMilestones = recentMilestones,_roleProgress = roleProgress,_availableTitles = availableTitles;
  factory _FaithJourneyStats.fromJson(Map<String, dynamic> json) => _$FaithJourneyStatsFromJson(json);

@override final  String userId;
@override final  UserRole currentRole;
@override final  String currentRoleDisplayName;
@override final  int daysToNextRole;
@override final  double progressToNextRole;
@override final  String nextRoleName;
 final  List<FaithMilestone> _recentMilestones;
@override List<FaithMilestone> get recentMilestones {
  if (_recentMilestones is EqualUnmodifiableListView) return _recentMilestones;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentMilestones);
}

 final  List<FaithProgress> _roleProgress;
@override List<FaithProgress> get roleProgress {
  if (_roleProgress is EqualUnmodifiableListView) return _roleProgress;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_roleProgress);
}

@override final  int totalReadingStreak;
@override final  int totalVersesRead;
@override final  int totalFollowers;
@override@JsonKey() final  bool canBecomeBishop;
@override@JsonKey() final  bool canPostOnBlog;
@override final  String? chosenTitle;
 final  List<String> _availableTitles;
@override@JsonKey() List<String> get availableTitles {
  if (_availableTitles is EqualUnmodifiableListView) return _availableTitles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableTitles);
}


/// Create a copy of FaithJourneyStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FaithJourneyStatsCopyWith<_FaithJourneyStats> get copyWith => __$FaithJourneyStatsCopyWithImpl<_FaithJourneyStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FaithJourneyStatsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FaithJourneyStats&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.currentRole, currentRole) || other.currentRole == currentRole)&&(identical(other.currentRoleDisplayName, currentRoleDisplayName) || other.currentRoleDisplayName == currentRoleDisplayName)&&(identical(other.daysToNextRole, daysToNextRole) || other.daysToNextRole == daysToNextRole)&&(identical(other.progressToNextRole, progressToNextRole) || other.progressToNextRole == progressToNextRole)&&(identical(other.nextRoleName, nextRoleName) || other.nextRoleName == nextRoleName)&&const DeepCollectionEquality().equals(other.recentMilestones, _recentMilestones)&&const DeepCollectionEquality().equals(other.roleProgress, _roleProgress)&&(identical(other.totalReadingStreak, totalReadingStreak) || other.totalReadingStreak == totalReadingStreak)&&(identical(other.totalVersesRead, totalVersesRead) || other.totalVersesRead == totalVersesRead)&&(identical(other.totalFollowers, totalFollowers) || other.totalFollowers == totalFollowers)&&(identical(other.canBecomeBishop, canBecomeBishop) || other.canBecomeBishop == canBecomeBishop)&&(identical(other.canPostOnBlog, canPostOnBlog) || other.canPostOnBlog == canPostOnBlog)&&(identical(other.chosenTitle, chosenTitle) || other.chosenTitle == chosenTitle)&&const DeepCollectionEquality().equals(other.availableTitles, _availableTitles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,userId,currentRole,currentRoleDisplayName,daysToNextRole,progressToNextRole,nextRoleName,const DeepCollectionEquality().hash(_recentMilestones),const DeepCollectionEquality().hash(_roleProgress),totalReadingStreak,totalVersesRead,totalFollowers,canBecomeBishop,canPostOnBlog,chosenTitle,const DeepCollectionEquality().hash(_availableTitles));
}

@override
String toString() {
    return 'FaithJourneyStats(userId: $userId, currentRole: $currentRole, currentRoleDisplayName: $currentRoleDisplayName, daysToNextRole: $daysToNextRole, progressToNextRole: $progressToNextRole, nextRoleName: $nextRoleName, recentMilestones: $recentMilestones, roleProgress: $roleProgress, totalReadingStreak: $totalReadingStreak, totalVersesRead: $totalVersesRead, totalFollowers: $totalFollowers, canBecomeBishop: $canBecomeBishop, canPostOnBlog: $canPostOnBlog, chosenTitle: $chosenTitle, availableTitles: $availableTitles)';
}


}

/// @nodoc
abstract mixin class _$FaithJourneyStatsCopyWith<$Res> implements $FaithJourneyStatsCopyWith<$Res> {
  factory _$FaithJourneyStatsCopyWith(_FaithJourneyStats value, $Res Function(_FaithJourneyStats) _then) = __$FaithJourneyStatsCopyWithImpl;
@override @useResult
$Res call({
 String userId, UserRole currentRole, String currentRoleDisplayName, int daysToNextRole, double progressToNextRole, String nextRoleName, List<FaithMilestone> recentMilestones, List<FaithProgress> roleProgress, int totalReadingStreak, int totalVersesRead, int totalFollowers, bool canBecomeBishop, bool canPostOnBlog, String? chosenTitle, List<String> availableTitles
});




}
/// @nodoc
class __$FaithJourneyStatsCopyWithImpl<$Res>
    implements _$FaithJourneyStatsCopyWith<$Res> {
  __$FaithJourneyStatsCopyWithImpl(this._self, this._then);

  final _FaithJourneyStats _self;
  final $Res Function(_FaithJourneyStats) _then;

/// Create a copy of FaithJourneyStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? currentRole = null,Object? currentRoleDisplayName = null,Object? daysToNextRole = null,Object? progressToNextRole = null,Object? nextRoleName = null,Object? recentMilestones = null,Object? roleProgress = null,Object? totalReadingStreak = null,Object? totalVersesRead = null,Object? totalFollowers = null,Object? canBecomeBishop = null,Object? canPostOnBlog = null,Object? chosenTitle = freezed,Object? availableTitles = null,}) {
  return _then(_FaithJourneyStats(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,currentRole: null == currentRole ? _self.currentRole : currentRole // ignore: cast_nullable_to_non_nullable
as UserRole,currentRoleDisplayName: null == currentRoleDisplayName ? _self.currentRoleDisplayName : currentRoleDisplayName // ignore: cast_nullable_to_non_nullable
as String,daysToNextRole: null == daysToNextRole ? _self.daysToNextRole : daysToNextRole // ignore: cast_nullable_to_non_nullable
as int,progressToNextRole: null == progressToNextRole ? _self.progressToNextRole : progressToNextRole // ignore: cast_nullable_to_non_nullable
as double,nextRoleName: null == nextRoleName ? _self.nextRoleName : nextRoleName // ignore: cast_nullable_to_non_nullable
as String,recentMilestones: null == recentMilestones ? _self._recentMilestones : recentMilestones // ignore: cast_nullable_to_non_nullable
as List<FaithMilestone>,roleProgress: null == roleProgress ? _self._roleProgress : roleProgress // ignore: cast_nullable_to_non_nullable
as List<FaithProgress>,totalReadingStreak: null == totalReadingStreak ? _self.totalReadingStreak : totalReadingStreak // ignore: cast_nullable_to_non_nullable
as int,totalVersesRead: null == totalVersesRead ? _self.totalVersesRead : totalVersesRead // ignore: cast_nullable_to_non_nullable
as int,totalFollowers: null == totalFollowers ? _self.totalFollowers : totalFollowers // ignore: cast_nullable_to_non_nullable
as int,canBecomeBishop: null == canBecomeBishop ? _self.canBecomeBishop : canBecomeBishop // ignore: cast_nullable_to_non_nullable
as bool,canPostOnBlog: null == canPostOnBlog ? _self.canPostOnBlog : canPostOnBlog // ignore: cast_nullable_to_non_nullable
as bool,chosenTitle: freezed == chosenTitle ? _self.chosenTitle : chosenTitle // ignore: cast_nullable_to_non_nullable
as String?,availableTitles: null == availableTitles ? _self._availableTitles : availableTitles // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
