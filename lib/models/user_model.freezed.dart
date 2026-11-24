// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserModel {

 String get id; String get email; String get displayName; String? get photoUrl; String? get bio; UserRole get role; PremiumTier get premiumTier; UserStatus get status; int get followingCount; int get followersCount; int get savedVersesCount; int get likedVersesCount; int get blogPostsCount; List<String> get savedVerseIds; List<String> get likedVerseIds; List<String> get bookmarkedBlogPostIds; List<String> get followingUserIds; Map<String, dynamic> get readingStats; int get consecutiveReadingDays; int get totalReadingDays; int get streakStartDate; List<String> get badges; bool get hasPaidToSkipLadder; bool get canPostOnBlog; DateTime? get suspensionEndDate; DateTime? get lastReadingDate; DateTime? get lastNotificationDate; String? get chosenTitle; List<String> get blockedUserIds; Map<String, dynamic> get preferences; DateTime? get createdAt; DateTime? get updatedAt;// Reading habit tracking
 List<int> get readingHours;// Hours of day user typically reads
 List<int> get readingDays;
/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserModelCopyWith<UserModel> get copyWith => _$UserModelCopyWithImpl<UserModel>(this as UserModel, _$identity);

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.role, role) || other.role == role)&&(identical(other.premiumTier, premiumTier) || other.premiumTier == premiumTier)&&(identical(other.status, status) || other.status == status)&&(identical(other.followingCount, followingCount) || other.followingCount == followingCount)&&(identical(other.followersCount, followersCount) || other.followersCount == followersCount)&&(identical(other.savedVersesCount, savedVersesCount) || other.savedVersesCount == savedVersesCount)&&(identical(other.likedVersesCount, likedVersesCount) || other.likedVersesCount == likedVersesCount)&&(identical(other.blogPostsCount, blogPostsCount) || other.blogPostsCount == blogPostsCount)&&const DeepCollectionEquality().equals(other.savedVerseIds, savedVerseIds)&&const DeepCollectionEquality().equals(other.likedVerseIds, likedVerseIds)&&const DeepCollectionEquality().equals(other.bookmarkedBlogPostIds, bookmarkedBlogPostIds)&&const DeepCollectionEquality().equals(other.followingUserIds, followingUserIds)&&const DeepCollectionEquality().equals(other.readingStats, readingStats)&&(identical(other.consecutiveReadingDays, consecutiveReadingDays) || other.consecutiveReadingDays == consecutiveReadingDays)&&(identical(other.totalReadingDays, totalReadingDays) || other.totalReadingDays == totalReadingDays)&&(identical(other.streakStartDate, streakStartDate) || other.streakStartDate == streakStartDate)&&const DeepCollectionEquality().equals(other.badges, badges)&&(identical(other.hasPaidToSkipLadder, hasPaidToSkipLadder) || other.hasPaidToSkipLadder == hasPaidToSkipLadder)&&(identical(other.canPostOnBlog, canPostOnBlog) || other.canPostOnBlog == canPostOnBlog)&&(identical(other.suspensionEndDate, suspensionEndDate) || other.suspensionEndDate == suspensionEndDate)&&(identical(other.lastReadingDate, lastReadingDate) || other.lastReadingDate == lastReadingDate)&&(identical(other.lastNotificationDate, lastNotificationDate) || other.lastNotificationDate == lastNotificationDate)&&(identical(other.chosenTitle, chosenTitle) || other.chosenTitle == chosenTitle)&&const DeepCollectionEquality().equals(other.blockedUserIds, blockedUserIds)&&const DeepCollectionEquality().equals(other.preferences, preferences)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.readingHours, readingHours)&&const DeepCollectionEquality().equals(other.readingDays, readingDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,email,displayName,photoUrl,bio,role,premiumTier,status,followingCount,followersCount,savedVersesCount,likedVersesCount,blogPostsCount,const DeepCollectionEquality().hash(savedVerseIds),const DeepCollectionEquality().hash(likedVerseIds),const DeepCollectionEquality().hash(bookmarkedBlogPostIds),const DeepCollectionEquality().hash(followingUserIds),const DeepCollectionEquality().hash(readingStats),consecutiveReadingDays,totalReadingDays,streakStartDate,const DeepCollectionEquality().hash(badges),hasPaidToSkipLadder,canPostOnBlog,suspensionEndDate,lastReadingDate,lastNotificationDate,chosenTitle,const DeepCollectionEquality().hash(blockedUserIds),const DeepCollectionEquality().hash(preferences),createdAt,updatedAt,const DeepCollectionEquality().hash(readingHours),const DeepCollectionEquality().hash(readingDays)]);

@override
String toString() {
  return 'UserModel(id: $id, email: $email, displayName: $displayName, photoUrl: $photoUrl, bio: $bio, role: $role, premiumTier: $premiumTier, status: $status, followingCount: $followingCount, followersCount: $followersCount, savedVersesCount: $savedVersesCount, likedVersesCount: $likedVersesCount, blogPostsCount: $blogPostsCount, savedVerseIds: $savedVerseIds, likedVerseIds: $likedVerseIds, bookmarkedBlogPostIds: $bookmarkedBlogPostIds, followingUserIds: $followingUserIds, readingStats: $readingStats, consecutiveReadingDays: $consecutiveReadingDays, totalReadingDays: $totalReadingDays, streakStartDate: $streakStartDate, badges: $badges, hasPaidToSkipLadder: $hasPaidToSkipLadder, canPostOnBlog: $canPostOnBlog, suspensionEndDate: $suspensionEndDate, lastReadingDate: $lastReadingDate, lastNotificationDate: $lastNotificationDate, chosenTitle: $chosenTitle, blockedUserIds: $blockedUserIds, preferences: $preferences, createdAt: $createdAt, updatedAt: $updatedAt, readingHours: $readingHours, readingDays: $readingDays)';
}


}

/// @nodoc
abstract mixin class $UserModelCopyWith<$Res>  {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) _then) = _$UserModelCopyWithImpl;
@useResult
$Res call({
 String id, String email, String displayName, String? photoUrl, String? bio, UserRole role, PremiumTier premiumTier, UserStatus status, int followingCount, int followersCount, int savedVersesCount, int likedVersesCount, int blogPostsCount, List<String> savedVerseIds, List<String> likedVerseIds, List<String> bookmarkedBlogPostIds, List<String> followingUserIds, Map<String, dynamic> readingStats, int consecutiveReadingDays, int totalReadingDays, int streakStartDate, List<String> badges, bool hasPaidToSkipLadder, bool canPostOnBlog, DateTime? suspensionEndDate, DateTime? lastReadingDate, DateTime? lastNotificationDate, String? chosenTitle, List<String> blockedUserIds, Map<String, dynamic> preferences, DateTime? createdAt, DateTime? updatedAt, List<int> readingHours, List<int> readingDays
});




}
/// @nodoc
class _$UserModelCopyWithImpl<$Res>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._self, this._then);

  final UserModel _self;
  final $Res Function(UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? displayName = null,Object? photoUrl = freezed,Object? bio = freezed,Object? role = null,Object? premiumTier = null,Object? status = null,Object? followingCount = null,Object? followersCount = null,Object? savedVersesCount = null,Object? likedVersesCount = null,Object? blogPostsCount = null,Object? savedVerseIds = null,Object? likedVerseIds = null,Object? bookmarkedBlogPostIds = null,Object? followingUserIds = null,Object? readingStats = null,Object? consecutiveReadingDays = null,Object? totalReadingDays = null,Object? streakStartDate = null,Object? badges = null,Object? hasPaidToSkipLadder = null,Object? canPostOnBlog = null,Object? suspensionEndDate = freezed,Object? lastReadingDate = freezed,Object? lastNotificationDate = freezed,Object? chosenTitle = freezed,Object? blockedUserIds = null,Object? preferences = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? readingHours = null,Object? readingDays = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole,premiumTier: null == premiumTier ? _self.premiumTier : premiumTier // ignore: cast_nullable_to_non_nullable
as PremiumTier,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UserStatus,followingCount: null == followingCount ? _self.followingCount : followingCount // ignore: cast_nullable_to_non_nullable
as int,followersCount: null == followersCount ? _self.followersCount : followersCount // ignore: cast_nullable_to_non_nullable
as int,savedVersesCount: null == savedVersesCount ? _self.savedVersesCount : savedVersesCount // ignore: cast_nullable_to_non_nullable
as int,likedVersesCount: null == likedVersesCount ? _self.likedVersesCount : likedVersesCount // ignore: cast_nullable_to_non_nullable
as int,blogPostsCount: null == blogPostsCount ? _self.blogPostsCount : blogPostsCount // ignore: cast_nullable_to_non_nullable
as int,savedVerseIds: null == savedVerseIds ? _self.savedVerseIds : savedVerseIds // ignore: cast_nullable_to_non_nullable
as List<String>,likedVerseIds: null == likedVerseIds ? _self.likedVerseIds : likedVerseIds // ignore: cast_nullable_to_non_nullable
as List<String>,bookmarkedBlogPostIds: null == bookmarkedBlogPostIds ? _self.bookmarkedBlogPostIds : bookmarkedBlogPostIds // ignore: cast_nullable_to_non_nullable
as List<String>,followingUserIds: null == followingUserIds ? _self.followingUserIds : followingUserIds // ignore: cast_nullable_to_non_nullable
as List<String>,readingStats: null == readingStats ? _self.readingStats : readingStats // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,consecutiveReadingDays: null == consecutiveReadingDays ? _self.consecutiveReadingDays : consecutiveReadingDays // ignore: cast_nullable_to_non_nullable
as int,totalReadingDays: null == totalReadingDays ? _self.totalReadingDays : totalReadingDays // ignore: cast_nullable_to_non_nullable
as int,streakStartDate: null == streakStartDate ? _self.streakStartDate : streakStartDate // ignore: cast_nullable_to_non_nullable
as int,badges: null == badges ? _self.badges : badges // ignore: cast_nullable_to_non_nullable
as List<String>,hasPaidToSkipLadder: null == hasPaidToSkipLadder ? _self.hasPaidToSkipLadder : hasPaidToSkipLadder // ignore: cast_nullable_to_non_nullable
as bool,canPostOnBlog: null == canPostOnBlog ? _self.canPostOnBlog : canPostOnBlog // ignore: cast_nullable_to_non_nullable
as bool,suspensionEndDate: freezed == suspensionEndDate ? _self.suspensionEndDate : suspensionEndDate // ignore: cast_nullable_to_non_nullable
as DateTime?,lastReadingDate: freezed == lastReadingDate ? _self.lastReadingDate : lastReadingDate // ignore: cast_nullable_to_non_nullable
as DateTime?,lastNotificationDate: freezed == lastNotificationDate ? _self.lastNotificationDate : lastNotificationDate // ignore: cast_nullable_to_non_nullable
as DateTime?,chosenTitle: freezed == chosenTitle ? _self.chosenTitle : chosenTitle // ignore: cast_nullable_to_non_nullable
as String?,blockedUserIds: null == blockedUserIds ? _self.blockedUserIds : blockedUserIds // ignore: cast_nullable_to_non_nullable
as List<String>,preferences: null == preferences ? _self.preferences : preferences // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,readingHours: null == readingHours ? _self.readingHours : readingHours // ignore: cast_nullable_to_non_nullable
as List<int>,readingDays: null == readingDays ? _self.readingDays : readingDays // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [UserModel].
extension UserModelPatterns on UserModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserModel value)  $default,){
final _that = this;
switch (_that) {
case _UserModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String email,  String displayName,  String? photoUrl,  String? bio,  UserRole role,  PremiumTier premiumTier,  UserStatus status,  int followingCount,  int followersCount,  int savedVersesCount,  int likedVersesCount,  int blogPostsCount,  List<String> savedVerseIds,  List<String> likedVerseIds,  List<String> bookmarkedBlogPostIds,  List<String> followingUserIds,  Map<String, dynamic> readingStats,  int consecutiveReadingDays,  int totalReadingDays,  int streakStartDate,  List<String> badges,  bool hasPaidToSkipLadder,  bool canPostOnBlog,  DateTime? suspensionEndDate,  DateTime? lastReadingDate,  DateTime? lastNotificationDate,  String? chosenTitle,  List<String> blockedUserIds,  Map<String, dynamic> preferences,  DateTime? createdAt,  DateTime? updatedAt,  List<int> readingHours,  List<int> readingDays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.id,_that.email,_that.displayName,_that.photoUrl,_that.bio,_that.role,_that.premiumTier,_that.status,_that.followingCount,_that.followersCount,_that.savedVersesCount,_that.likedVersesCount,_that.blogPostsCount,_that.savedVerseIds,_that.likedVerseIds,_that.bookmarkedBlogPostIds,_that.followingUserIds,_that.readingStats,_that.consecutiveReadingDays,_that.totalReadingDays,_that.streakStartDate,_that.badges,_that.hasPaidToSkipLadder,_that.canPostOnBlog,_that.suspensionEndDate,_that.lastReadingDate,_that.lastNotificationDate,_that.chosenTitle,_that.blockedUserIds,_that.preferences,_that.createdAt,_that.updatedAt,_that.readingHours,_that.readingDays);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String email,  String displayName,  String? photoUrl,  String? bio,  UserRole role,  PremiumTier premiumTier,  UserStatus status,  int followingCount,  int followersCount,  int savedVersesCount,  int likedVersesCount,  int blogPostsCount,  List<String> savedVerseIds,  List<String> likedVerseIds,  List<String> bookmarkedBlogPostIds,  List<String> followingUserIds,  Map<String, dynamic> readingStats,  int consecutiveReadingDays,  int totalReadingDays,  int streakStartDate,  List<String> badges,  bool hasPaidToSkipLadder,  bool canPostOnBlog,  DateTime? suspensionEndDate,  DateTime? lastReadingDate,  DateTime? lastNotificationDate,  String? chosenTitle,  List<String> blockedUserIds,  Map<String, dynamic> preferences,  DateTime? createdAt,  DateTime? updatedAt,  List<int> readingHours,  List<int> readingDays)  $default,) {final _that = this;
switch (_that) {
case _UserModel():
return $default(_that.id,_that.email,_that.displayName,_that.photoUrl,_that.bio,_that.role,_that.premiumTier,_that.status,_that.followingCount,_that.followersCount,_that.savedVersesCount,_that.likedVersesCount,_that.blogPostsCount,_that.savedVerseIds,_that.likedVerseIds,_that.bookmarkedBlogPostIds,_that.followingUserIds,_that.readingStats,_that.consecutiveReadingDays,_that.totalReadingDays,_that.streakStartDate,_that.badges,_that.hasPaidToSkipLadder,_that.canPostOnBlog,_that.suspensionEndDate,_that.lastReadingDate,_that.lastNotificationDate,_that.chosenTitle,_that.blockedUserIds,_that.preferences,_that.createdAt,_that.updatedAt,_that.readingHours,_that.readingDays);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String email,  String displayName,  String? photoUrl,  String? bio,  UserRole role,  PremiumTier premiumTier,  UserStatus status,  int followingCount,  int followersCount,  int savedVersesCount,  int likedVersesCount,  int blogPostsCount,  List<String> savedVerseIds,  List<String> likedVerseIds,  List<String> bookmarkedBlogPostIds,  List<String> followingUserIds,  Map<String, dynamic> readingStats,  int consecutiveReadingDays,  int totalReadingDays,  int streakStartDate,  List<String> badges,  bool hasPaidToSkipLadder,  bool canPostOnBlog,  DateTime? suspensionEndDate,  DateTime? lastReadingDate,  DateTime? lastNotificationDate,  String? chosenTitle,  List<String> blockedUserIds,  Map<String, dynamic> preferences,  DateTime? createdAt,  DateTime? updatedAt,  List<int> readingHours,  List<int> readingDays)?  $default,) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.id,_that.email,_that.displayName,_that.photoUrl,_that.bio,_that.role,_that.premiumTier,_that.status,_that.followingCount,_that.followersCount,_that.savedVersesCount,_that.likedVersesCount,_that.blogPostsCount,_that.savedVerseIds,_that.likedVerseIds,_that.bookmarkedBlogPostIds,_that.followingUserIds,_that.readingStats,_that.consecutiveReadingDays,_that.totalReadingDays,_that.streakStartDate,_that.badges,_that.hasPaidToSkipLadder,_that.canPostOnBlog,_that.suspensionEndDate,_that.lastReadingDate,_that.lastNotificationDate,_that.chosenTitle,_that.blockedUserIds,_that.preferences,_that.createdAt,_that.updatedAt,_that.readingHours,_that.readingDays);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserModel implements UserModel {
  const _UserModel({required this.id, required this.email, required this.displayName, this.photoUrl, this.bio, this.role = UserRole.believer, this.premiumTier = PremiumTier.free, this.status = UserStatus.active, this.followingCount = 0, this.followersCount = 0, this.savedVersesCount = 0, this.likedVersesCount = 0, this.blogPostsCount = 0, final  List<String> savedVerseIds = const [], final  List<String> likedVerseIds = const [], final  List<String> bookmarkedBlogPostIds = const [], final  List<String> followingUserIds = const [], final  Map<String, dynamic> readingStats = const {}, this.consecutiveReadingDays = 0, this.totalReadingDays = 0, this.streakStartDate = 0, final  List<String> badges = const [], this.hasPaidToSkipLadder = false, this.canPostOnBlog = false, this.suspensionEndDate = null, this.lastReadingDate = null, this.lastNotificationDate = null, this.chosenTitle = null, final  List<String> blockedUserIds = const [], final  Map<String, dynamic> preferences = const {}, this.createdAt = null, this.updatedAt = null, final  List<int> readingHours = const [], final  List<int> readingDays = const []}): _savedVerseIds = savedVerseIds,_likedVerseIds = likedVerseIds,_bookmarkedBlogPostIds = bookmarkedBlogPostIds,_followingUserIds = followingUserIds,_readingStats = readingStats,_badges = badges,_blockedUserIds = blockedUserIds,_preferences = preferences,_readingHours = readingHours,_readingDays = readingDays;
  factory _UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

@override final  String id;
@override final  String email;
@override final  String displayName;
@override final  String? photoUrl;
@override final  String? bio;
@override@JsonKey() final  UserRole role;
@override@JsonKey() final  PremiumTier premiumTier;
@override@JsonKey() final  UserStatus status;
@override@JsonKey() final  int followingCount;
@override@JsonKey() final  int followersCount;
@override@JsonKey() final  int savedVersesCount;
@override@JsonKey() final  int likedVersesCount;
@override@JsonKey() final  int blogPostsCount;
 final  List<String> _savedVerseIds;
@override@JsonKey() List<String> get savedVerseIds {
  if (_savedVerseIds is EqualUnmodifiableListView) return _savedVerseIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_savedVerseIds);
}

 final  List<String> _likedVerseIds;
@override@JsonKey() List<String> get likedVerseIds {
  if (_likedVerseIds is EqualUnmodifiableListView) return _likedVerseIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_likedVerseIds);
}

 final  List<String> _bookmarkedBlogPostIds;
@override@JsonKey() List<String> get bookmarkedBlogPostIds {
  if (_bookmarkedBlogPostIds is EqualUnmodifiableListView) return _bookmarkedBlogPostIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bookmarkedBlogPostIds);
}

 final  List<String> _followingUserIds;
@override@JsonKey() List<String> get followingUserIds {
  if (_followingUserIds is EqualUnmodifiableListView) return _followingUserIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_followingUserIds);
}

 final  Map<String, dynamic> _readingStats;
@override@JsonKey() Map<String, dynamic> get readingStats {
  if (_readingStats is EqualUnmodifiableMapView) return _readingStats;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_readingStats);
}

@override@JsonKey() final  int consecutiveReadingDays;
@override@JsonKey() final  int totalReadingDays;
@override@JsonKey() final  int streakStartDate;
 final  List<String> _badges;
@override@JsonKey() List<String> get badges {
  if (_badges is EqualUnmodifiableListView) return _badges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_badges);
}

@override@JsonKey() final  bool hasPaidToSkipLadder;
@override@JsonKey() final  bool canPostOnBlog;
@override@JsonKey() final  DateTime? suspensionEndDate;
@override@JsonKey() final  DateTime? lastReadingDate;
@override@JsonKey() final  DateTime? lastNotificationDate;
@override@JsonKey() final  String? chosenTitle;
 final  List<String> _blockedUserIds;
@override@JsonKey() List<String> get blockedUserIds {
  if (_blockedUserIds is EqualUnmodifiableListView) return _blockedUserIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_blockedUserIds);
}

 final  Map<String, dynamic> _preferences;
@override@JsonKey() Map<String, dynamic> get preferences {
  if (_preferences is EqualUnmodifiableMapView) return _preferences;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_preferences);
}

@override@JsonKey() final  DateTime? createdAt;
@override@JsonKey() final  DateTime? updatedAt;
// Reading habit tracking
 final  List<int> _readingHours;
// Reading habit tracking
@override@JsonKey() List<int> get readingHours {
  if (_readingHours is EqualUnmodifiableListView) return _readingHours;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_readingHours);
}

// Hours of day user typically reads
 final  List<int> _readingDays;
// Hours of day user typically reads
@override@JsonKey() List<int> get readingDays {
  if (_readingDays is EqualUnmodifiableListView) return _readingDays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_readingDays);
}


/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserModelCopyWith<_UserModel> get copyWith => __$UserModelCopyWithImpl<_UserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.role, role) || other.role == role)&&(identical(other.premiumTier, premiumTier) || other.premiumTier == premiumTier)&&(identical(other.status, status) || other.status == status)&&(identical(other.followingCount, followingCount) || other.followingCount == followingCount)&&(identical(other.followersCount, followersCount) || other.followersCount == followersCount)&&(identical(other.savedVersesCount, savedVersesCount) || other.savedVersesCount == savedVersesCount)&&(identical(other.likedVersesCount, likedVersesCount) || other.likedVersesCount == likedVersesCount)&&(identical(other.blogPostsCount, blogPostsCount) || other.blogPostsCount == blogPostsCount)&&const DeepCollectionEquality().equals(other._savedVerseIds, _savedVerseIds)&&const DeepCollectionEquality().equals(other._likedVerseIds, _likedVerseIds)&&const DeepCollectionEquality().equals(other._bookmarkedBlogPostIds, _bookmarkedBlogPostIds)&&const DeepCollectionEquality().equals(other._followingUserIds, _followingUserIds)&&const DeepCollectionEquality().equals(other._readingStats, _readingStats)&&(identical(other.consecutiveReadingDays, consecutiveReadingDays) || other.consecutiveReadingDays == consecutiveReadingDays)&&(identical(other.totalReadingDays, totalReadingDays) || other.totalReadingDays == totalReadingDays)&&(identical(other.streakStartDate, streakStartDate) || other.streakStartDate == streakStartDate)&&const DeepCollectionEquality().equals(other._badges, _badges)&&(identical(other.hasPaidToSkipLadder, hasPaidToSkipLadder) || other.hasPaidToSkipLadder == hasPaidToSkipLadder)&&(identical(other.canPostOnBlog, canPostOnBlog) || other.canPostOnBlog == canPostOnBlog)&&(identical(other.suspensionEndDate, suspensionEndDate) || other.suspensionEndDate == suspensionEndDate)&&(identical(other.lastReadingDate, lastReadingDate) || other.lastReadingDate == lastReadingDate)&&(identical(other.lastNotificationDate, lastNotificationDate) || other.lastNotificationDate == lastNotificationDate)&&(identical(other.chosenTitle, chosenTitle) || other.chosenTitle == chosenTitle)&&const DeepCollectionEquality().equals(other._blockedUserIds, _blockedUserIds)&&const DeepCollectionEquality().equals(other._preferences, _preferences)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._readingHours, _readingHours)&&const DeepCollectionEquality().equals(other._readingDays, _readingDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,email,displayName,photoUrl,bio,role,premiumTier,status,followingCount,followersCount,savedVersesCount,likedVersesCount,blogPostsCount,const DeepCollectionEquality().hash(_savedVerseIds),const DeepCollectionEquality().hash(_likedVerseIds),const DeepCollectionEquality().hash(_bookmarkedBlogPostIds),const DeepCollectionEquality().hash(_followingUserIds),const DeepCollectionEquality().hash(_readingStats),consecutiveReadingDays,totalReadingDays,streakStartDate,const DeepCollectionEquality().hash(_badges),hasPaidToSkipLadder,canPostOnBlog,suspensionEndDate,lastReadingDate,lastNotificationDate,chosenTitle,const DeepCollectionEquality().hash(_blockedUserIds),const DeepCollectionEquality().hash(_preferences),createdAt,updatedAt,const DeepCollectionEquality().hash(_readingHours),const DeepCollectionEquality().hash(_readingDays)]);

@override
String toString() {
  return 'UserModel(id: $id, email: $email, displayName: $displayName, photoUrl: $photoUrl, bio: $bio, role: $role, premiumTier: $premiumTier, status: $status, followingCount: $followingCount, followersCount: $followersCount, savedVersesCount: $savedVersesCount, likedVersesCount: $likedVersesCount, blogPostsCount: $blogPostsCount, savedVerseIds: $savedVerseIds, likedVerseIds: $likedVerseIds, bookmarkedBlogPostIds: $bookmarkedBlogPostIds, followingUserIds: $followingUserIds, readingStats: $readingStats, consecutiveReadingDays: $consecutiveReadingDays, totalReadingDays: $totalReadingDays, streakStartDate: $streakStartDate, badges: $badges, hasPaidToSkipLadder: $hasPaidToSkipLadder, canPostOnBlog: $canPostOnBlog, suspensionEndDate: $suspensionEndDate, lastReadingDate: $lastReadingDate, lastNotificationDate: $lastNotificationDate, chosenTitle: $chosenTitle, blockedUserIds: $blockedUserIds, preferences: $preferences, createdAt: $createdAt, updatedAt: $updatedAt, readingHours: $readingHours, readingDays: $readingDays)';
}


}

/// @nodoc
abstract mixin class _$UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$UserModelCopyWith(_UserModel value, $Res Function(_UserModel) _then) = __$UserModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String email, String displayName, String? photoUrl, String? bio, UserRole role, PremiumTier premiumTier, UserStatus status, int followingCount, int followersCount, int savedVersesCount, int likedVersesCount, int blogPostsCount, List<String> savedVerseIds, List<String> likedVerseIds, List<String> bookmarkedBlogPostIds, List<String> followingUserIds, Map<String, dynamic> readingStats, int consecutiveReadingDays, int totalReadingDays, int streakStartDate, List<String> badges, bool hasPaidToSkipLadder, bool canPostOnBlog, DateTime? suspensionEndDate, DateTime? lastReadingDate, DateTime? lastNotificationDate, String? chosenTitle, List<String> blockedUserIds, Map<String, dynamic> preferences, DateTime? createdAt, DateTime? updatedAt, List<int> readingHours, List<int> readingDays
});




}
/// @nodoc
class __$UserModelCopyWithImpl<$Res>
    implements _$UserModelCopyWith<$Res> {
  __$UserModelCopyWithImpl(this._self, this._then);

  final _UserModel _self;
  final $Res Function(_UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? displayName = null,Object? photoUrl = freezed,Object? bio = freezed,Object? role = null,Object? premiumTier = null,Object? status = null,Object? followingCount = null,Object? followersCount = null,Object? savedVersesCount = null,Object? likedVersesCount = null,Object? blogPostsCount = null,Object? savedVerseIds = null,Object? likedVerseIds = null,Object? bookmarkedBlogPostIds = null,Object? followingUserIds = null,Object? readingStats = null,Object? consecutiveReadingDays = null,Object? totalReadingDays = null,Object? streakStartDate = null,Object? badges = null,Object? hasPaidToSkipLadder = null,Object? canPostOnBlog = null,Object? suspensionEndDate = freezed,Object? lastReadingDate = freezed,Object? lastNotificationDate = freezed,Object? chosenTitle = freezed,Object? blockedUserIds = null,Object? preferences = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? readingHours = null,Object? readingDays = null,}) {
  return _then(_UserModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole,premiumTier: null == premiumTier ? _self.premiumTier : premiumTier // ignore: cast_nullable_to_non_nullable
as PremiumTier,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UserStatus,followingCount: null == followingCount ? _self.followingCount : followingCount // ignore: cast_nullable_to_non_nullable
as int,followersCount: null == followersCount ? _self.followersCount : followersCount // ignore: cast_nullable_to_non_nullable
as int,savedVersesCount: null == savedVersesCount ? _self.savedVersesCount : savedVersesCount // ignore: cast_nullable_to_non_nullable
as int,likedVersesCount: null == likedVersesCount ? _self.likedVersesCount : likedVersesCount // ignore: cast_nullable_to_non_nullable
as int,blogPostsCount: null == blogPostsCount ? _self.blogPostsCount : blogPostsCount // ignore: cast_nullable_to_non_nullable
as int,savedVerseIds: null == savedVerseIds ? _self._savedVerseIds : savedVerseIds // ignore: cast_nullable_to_non_nullable
as List<String>,likedVerseIds: null == likedVerseIds ? _self._likedVerseIds : likedVerseIds // ignore: cast_nullable_to_non_nullable
as List<String>,bookmarkedBlogPostIds: null == bookmarkedBlogPostIds ? _self._bookmarkedBlogPostIds : bookmarkedBlogPostIds // ignore: cast_nullable_to_non_nullable
as List<String>,followingUserIds: null == followingUserIds ? _self._followingUserIds : followingUserIds // ignore: cast_nullable_to_non_nullable
as List<String>,readingStats: null == readingStats ? _self._readingStats : readingStats // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,consecutiveReadingDays: null == consecutiveReadingDays ? _self.consecutiveReadingDays : consecutiveReadingDays // ignore: cast_nullable_to_non_nullable
as int,totalReadingDays: null == totalReadingDays ? _self.totalReadingDays : totalReadingDays // ignore: cast_nullable_to_non_nullable
as int,streakStartDate: null == streakStartDate ? _self.streakStartDate : streakStartDate // ignore: cast_nullable_to_non_nullable
as int,badges: null == badges ? _self._badges : badges // ignore: cast_nullable_to_non_nullable
as List<String>,hasPaidToSkipLadder: null == hasPaidToSkipLadder ? _self.hasPaidToSkipLadder : hasPaidToSkipLadder // ignore: cast_nullable_to_non_nullable
as bool,canPostOnBlog: null == canPostOnBlog ? _self.canPostOnBlog : canPostOnBlog // ignore: cast_nullable_to_non_nullable
as bool,suspensionEndDate: freezed == suspensionEndDate ? _self.suspensionEndDate : suspensionEndDate // ignore: cast_nullable_to_non_nullable
as DateTime?,lastReadingDate: freezed == lastReadingDate ? _self.lastReadingDate : lastReadingDate // ignore: cast_nullable_to_non_nullable
as DateTime?,lastNotificationDate: freezed == lastNotificationDate ? _self.lastNotificationDate : lastNotificationDate // ignore: cast_nullable_to_non_nullable
as DateTime?,chosenTitle: freezed == chosenTitle ? _self.chosenTitle : chosenTitle // ignore: cast_nullable_to_non_nullable
as String?,blockedUserIds: null == blockedUserIds ? _self._blockedUserIds : blockedUserIds // ignore: cast_nullable_to_non_nullable
as List<String>,preferences: null == preferences ? _self._preferences : preferences // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,readingHours: null == readingHours ? _self._readingHours : readingHours // ignore: cast_nullable_to_non_nullable
as List<int>,readingDays: null == readingDays ? _self._readingDays : readingDays // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}


/// @nodoc
mixin _$ReadingStats {

 int get totalVersesRead; int get totalChaptersRead; int get totalBooksRead; Map<String, int> get bookProgress; Map<String, DateTime> get lastRead; int get longestStreak; List<DateTime> get readingHistory;
/// Create a copy of ReadingStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReadingStatsCopyWith<ReadingStats> get copyWith => _$ReadingStatsCopyWithImpl<ReadingStats>(this as ReadingStats, _$identity);

  /// Serializes this ReadingStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReadingStats&&(identical(other.totalVersesRead, totalVersesRead) || other.totalVersesRead == totalVersesRead)&&(identical(other.totalChaptersRead, totalChaptersRead) || other.totalChaptersRead == totalChaptersRead)&&(identical(other.totalBooksRead, totalBooksRead) || other.totalBooksRead == totalBooksRead)&&const DeepCollectionEquality().equals(other.bookProgress, bookProgress)&&const DeepCollectionEquality().equals(other.lastRead, lastRead)&&(identical(other.longestStreak, longestStreak) || other.longestStreak == longestStreak)&&const DeepCollectionEquality().equals(other.readingHistory, readingHistory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalVersesRead,totalChaptersRead,totalBooksRead,const DeepCollectionEquality().hash(bookProgress),const DeepCollectionEquality().hash(lastRead),longestStreak,const DeepCollectionEquality().hash(readingHistory));

@override
String toString() {
  return 'ReadingStats(totalVersesRead: $totalVersesRead, totalChaptersRead: $totalChaptersRead, totalBooksRead: $totalBooksRead, bookProgress: $bookProgress, lastRead: $lastRead, longestStreak: $longestStreak, readingHistory: $readingHistory)';
}


}

/// @nodoc
abstract mixin class $ReadingStatsCopyWith<$Res>  {
  factory $ReadingStatsCopyWith(ReadingStats value, $Res Function(ReadingStats) _then) = _$ReadingStatsCopyWithImpl;
@useResult
$Res call({
 int totalVersesRead, int totalChaptersRead, int totalBooksRead, Map<String, int> bookProgress, Map<String, DateTime> lastRead, int longestStreak, List<DateTime> readingHistory
});




}
/// @nodoc
class _$ReadingStatsCopyWithImpl<$Res>
    implements $ReadingStatsCopyWith<$Res> {
  _$ReadingStatsCopyWithImpl(this._self, this._then);

  final ReadingStats _self;
  final $Res Function(ReadingStats) _then;

/// Create a copy of ReadingStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalVersesRead = null,Object? totalChaptersRead = null,Object? totalBooksRead = null,Object? bookProgress = null,Object? lastRead = null,Object? longestStreak = null,Object? readingHistory = null,}) {
  return _then(_self.copyWith(
totalVersesRead: null == totalVersesRead ? _self.totalVersesRead : totalVersesRead // ignore: cast_nullable_to_non_nullable
as int,totalChaptersRead: null == totalChaptersRead ? _self.totalChaptersRead : totalChaptersRead // ignore: cast_nullable_to_non_nullable
as int,totalBooksRead: null == totalBooksRead ? _self.totalBooksRead : totalBooksRead // ignore: cast_nullable_to_non_nullable
as int,bookProgress: null == bookProgress ? _self.bookProgress : bookProgress // ignore: cast_nullable_to_non_nullable
as Map<String, int>,lastRead: null == lastRead ? _self.lastRead : lastRead // ignore: cast_nullable_to_non_nullable
as Map<String, DateTime>,longestStreak: null == longestStreak ? _self.longestStreak : longestStreak // ignore: cast_nullable_to_non_nullable
as int,readingHistory: null == readingHistory ? _self.readingHistory : readingHistory // ignore: cast_nullable_to_non_nullable
as List<DateTime>,
  ));
}

}


/// Adds pattern-matching-related methods to [ReadingStats].
extension ReadingStatsPatterns on ReadingStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReadingStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReadingStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReadingStats value)  $default,){
final _that = this;
switch (_that) {
case _ReadingStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReadingStats value)?  $default,){
final _that = this;
switch (_that) {
case _ReadingStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalVersesRead,  int totalChaptersRead,  int totalBooksRead,  Map<String, int> bookProgress,  Map<String, DateTime> lastRead,  int longestStreak,  List<DateTime> readingHistory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReadingStats() when $default != null:
return $default(_that.totalVersesRead,_that.totalChaptersRead,_that.totalBooksRead,_that.bookProgress,_that.lastRead,_that.longestStreak,_that.readingHistory);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalVersesRead,  int totalChaptersRead,  int totalBooksRead,  Map<String, int> bookProgress,  Map<String, DateTime> lastRead,  int longestStreak,  List<DateTime> readingHistory)  $default,) {final _that = this;
switch (_that) {
case _ReadingStats():
return $default(_that.totalVersesRead,_that.totalChaptersRead,_that.totalBooksRead,_that.bookProgress,_that.lastRead,_that.longestStreak,_that.readingHistory);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalVersesRead,  int totalChaptersRead,  int totalBooksRead,  Map<String, int> bookProgress,  Map<String, DateTime> lastRead,  int longestStreak,  List<DateTime> readingHistory)?  $default,) {final _that = this;
switch (_that) {
case _ReadingStats() when $default != null:
return $default(_that.totalVersesRead,_that.totalChaptersRead,_that.totalBooksRead,_that.bookProgress,_that.lastRead,_that.longestStreak,_that.readingHistory);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReadingStats implements ReadingStats {
  const _ReadingStats({this.totalVersesRead = 0, this.totalChaptersRead = 0, this.totalBooksRead = 0, final  Map<String, int> bookProgress = const {}, final  Map<String, DateTime> lastRead = const {}, this.longestStreak = 0, final  List<DateTime> readingHistory = const []}): _bookProgress = bookProgress,_lastRead = lastRead,_readingHistory = readingHistory;
  factory _ReadingStats.fromJson(Map<String, dynamic> json) => _$ReadingStatsFromJson(json);

@override@JsonKey() final  int totalVersesRead;
@override@JsonKey() final  int totalChaptersRead;
@override@JsonKey() final  int totalBooksRead;
 final  Map<String, int> _bookProgress;
@override@JsonKey() Map<String, int> get bookProgress {
  if (_bookProgress is EqualUnmodifiableMapView) return _bookProgress;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_bookProgress);
}

 final  Map<String, DateTime> _lastRead;
@override@JsonKey() Map<String, DateTime> get lastRead {
  if (_lastRead is EqualUnmodifiableMapView) return _lastRead;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_lastRead);
}

@override@JsonKey() final  int longestStreak;
 final  List<DateTime> _readingHistory;
@override@JsonKey() List<DateTime> get readingHistory {
  if (_readingHistory is EqualUnmodifiableListView) return _readingHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_readingHistory);
}


/// Create a copy of ReadingStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadingStatsCopyWith<_ReadingStats> get copyWith => __$ReadingStatsCopyWithImpl<_ReadingStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReadingStatsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadingStats&&(identical(other.totalVersesRead, totalVersesRead) || other.totalVersesRead == totalVersesRead)&&(identical(other.totalChaptersRead, totalChaptersRead) || other.totalChaptersRead == totalChaptersRead)&&(identical(other.totalBooksRead, totalBooksRead) || other.totalBooksRead == totalBooksRead)&&const DeepCollectionEquality().equals(other._bookProgress, _bookProgress)&&const DeepCollectionEquality().equals(other._lastRead, _lastRead)&&(identical(other.longestStreak, longestStreak) || other.longestStreak == longestStreak)&&const DeepCollectionEquality().equals(other._readingHistory, _readingHistory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalVersesRead,totalChaptersRead,totalBooksRead,const DeepCollectionEquality().hash(_bookProgress),const DeepCollectionEquality().hash(_lastRead),longestStreak,const DeepCollectionEquality().hash(_readingHistory));

@override
String toString() {
  return 'ReadingStats(totalVersesRead: $totalVersesRead, totalChaptersRead: $totalChaptersRead, totalBooksRead: $totalBooksRead, bookProgress: $bookProgress, lastRead: $lastRead, longestStreak: $longestStreak, readingHistory: $readingHistory)';
}


}

/// @nodoc
abstract mixin class _$ReadingStatsCopyWith<$Res> implements $ReadingStatsCopyWith<$Res> {
  factory _$ReadingStatsCopyWith(_ReadingStats value, $Res Function(_ReadingStats) _then) = __$ReadingStatsCopyWithImpl;
@override @useResult
$Res call({
 int totalVersesRead, int totalChaptersRead, int totalBooksRead, Map<String, int> bookProgress, Map<String, DateTime> lastRead, int longestStreak, List<DateTime> readingHistory
});




}
/// @nodoc
class __$ReadingStatsCopyWithImpl<$Res>
    implements _$ReadingStatsCopyWith<$Res> {
  __$ReadingStatsCopyWithImpl(this._self, this._then);

  final _ReadingStats _self;
  final $Res Function(_ReadingStats) _then;

/// Create a copy of ReadingStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalVersesRead = null,Object? totalChaptersRead = null,Object? totalBooksRead = null,Object? bookProgress = null,Object? lastRead = null,Object? longestStreak = null,Object? readingHistory = null,}) {
  return _then(_ReadingStats(
totalVersesRead: null == totalVersesRead ? _self.totalVersesRead : totalVersesRead // ignore: cast_nullable_to_non_nullable
as int,totalChaptersRead: null == totalChaptersRead ? _self.totalChaptersRead : totalChaptersRead // ignore: cast_nullable_to_non_nullable
as int,totalBooksRead: null == totalBooksRead ? _self.totalBooksRead : totalBooksRead // ignore: cast_nullable_to_non_nullable
as int,bookProgress: null == bookProgress ? _self._bookProgress : bookProgress // ignore: cast_nullable_to_non_nullable
as Map<String, int>,lastRead: null == lastRead ? _self._lastRead : lastRead // ignore: cast_nullable_to_non_nullable
as Map<String, DateTime>,longestStreak: null == longestStreak ? _self.longestStreak : longestStreak // ignore: cast_nullable_to_non_nullable
as int,readingHistory: null == readingHistory ? _self._readingHistory : readingHistory // ignore: cast_nullable_to_non_nullable
as List<DateTime>,
  ));
}


}

// dart format on
