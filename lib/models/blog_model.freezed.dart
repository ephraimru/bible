// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'blog_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BlogPostModel {

 String get id; String get title; String get content; String get authorId; String? get authorName; String? get authorPhotoUrl; BlogCategory get category; BlogPostStatus get status; List<String> get tags; String? get coverImageUrl; int get views; int get likes; int get comments; List<String> get likedBy; List<String> get bookmarkedBy; DateTime? get publishedAt; DateTime? get createdAt; DateTime? get updatedAt; bool get isFeatured; bool get isPremium; String? get excerpt; int get readingTime;
/// Create a copy of BlogPostModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BlogPostModelCopyWith<BlogPostModel> get copyWith => _$BlogPostModelCopyWithImpl<BlogPostModel>(this as BlogPostModel, _$identity);

  /// Serializes this BlogPostModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BlogPostModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.authorPhotoUrl, authorPhotoUrl) || other.authorPhotoUrl == authorPhotoUrl)&&(identical(other.category, category) || other.category == category)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.views, views) || other.views == views)&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.comments, comments) || other.comments == comments)&&const DeepCollectionEquality().equals(other.likedBy, likedBy)&&const DeepCollectionEquality().equals(other.bookmarkedBy, bookmarkedBy)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&(identical(other.isPremium, isPremium) || other.isPremium == isPremium)&&(identical(other.excerpt, excerpt) || other.excerpt == excerpt)&&(identical(other.readingTime, readingTime) || other.readingTime == readingTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,content,authorId,authorName,authorPhotoUrl,category,status,const DeepCollectionEquality().hash(tags),coverImageUrl,views,likes,comments,const DeepCollectionEquality().hash(likedBy),const DeepCollectionEquality().hash(bookmarkedBy),publishedAt,createdAt,updatedAt,isFeatured,isPremium,excerpt,readingTime]);

@override
String toString() {
  return 'BlogPostModel(id: $id, title: $title, content: $content, authorId: $authorId, authorName: $authorName, authorPhotoUrl: $authorPhotoUrl, category: $category, status: $status, tags: $tags, coverImageUrl: $coverImageUrl, views: $views, likes: $likes, comments: $comments, likedBy: $likedBy, bookmarkedBy: $bookmarkedBy, publishedAt: $publishedAt, createdAt: $createdAt, updatedAt: $updatedAt, isFeatured: $isFeatured, isPremium: $isPremium, excerpt: $excerpt, readingTime: $readingTime)';
}


}

/// @nodoc
abstract mixin class $BlogPostModelCopyWith<$Res>  {
  factory $BlogPostModelCopyWith(BlogPostModel value, $Res Function(BlogPostModel) _then) = _$BlogPostModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, String content, String authorId, String? authorName, String? authorPhotoUrl, BlogCategory category, BlogPostStatus status, List<String> tags, String? coverImageUrl, int views, int likes, int comments, List<String> likedBy, List<String> bookmarkedBy, DateTime? publishedAt, DateTime? createdAt, DateTime? updatedAt, bool isFeatured, bool isPremium, String? excerpt, int readingTime
});




}
/// @nodoc
class _$BlogPostModelCopyWithImpl<$Res>
    implements $BlogPostModelCopyWith<$Res> {
  _$BlogPostModelCopyWithImpl(this._self, this._then);

  final BlogPostModel _self;
  final $Res Function(BlogPostModel) _then;

/// Create a copy of BlogPostModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? content = null,Object? authorId = null,Object? authorName = freezed,Object? authorPhotoUrl = freezed,Object? category = null,Object? status = null,Object? tags = null,Object? coverImageUrl = freezed,Object? views = null,Object? likes = null,Object? comments = null,Object? likedBy = null,Object? bookmarkedBy = null,Object? publishedAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? isFeatured = null,Object? isPremium = null,Object? excerpt = freezed,Object? readingTime = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String,authorName: freezed == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String?,authorPhotoUrl: freezed == authorPhotoUrl ? _self.authorPhotoUrl : authorPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as BlogCategory,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BlogPostStatus,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,views: null == views ? _self.views : views // ignore: cast_nullable_to_non_nullable
as int,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,comments: null == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as int,likedBy: null == likedBy ? _self.likedBy : likedBy // ignore: cast_nullable_to_non_nullable
as List<String>,bookmarkedBy: null == bookmarkedBy ? _self.bookmarkedBy : bookmarkedBy // ignore: cast_nullable_to_non_nullable
as List<String>,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,isPremium: null == isPremium ? _self.isPremium : isPremium // ignore: cast_nullable_to_non_nullable
as bool,excerpt: freezed == excerpt ? _self.excerpt : excerpt // ignore: cast_nullable_to_non_nullable
as String?,readingTime: null == readingTime ? _self.readingTime : readingTime // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BlogPostModel].
extension BlogPostModelPatterns on BlogPostModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BlogPostModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BlogPostModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BlogPostModel value)  $default,){
final _that = this;
switch (_that) {
case _BlogPostModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BlogPostModel value)?  $default,){
final _that = this;
switch (_that) {
case _BlogPostModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String content,  String authorId,  String? authorName,  String? authorPhotoUrl,  BlogCategory category,  BlogPostStatus status,  List<String> tags,  String? coverImageUrl,  int views,  int likes,  int comments,  List<String> likedBy,  List<String> bookmarkedBy,  DateTime? publishedAt,  DateTime? createdAt,  DateTime? updatedAt,  bool isFeatured,  bool isPremium,  String? excerpt,  int readingTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BlogPostModel() when $default != null:
return $default(_that.id,_that.title,_that.content,_that.authorId,_that.authorName,_that.authorPhotoUrl,_that.category,_that.status,_that.tags,_that.coverImageUrl,_that.views,_that.likes,_that.comments,_that.likedBy,_that.bookmarkedBy,_that.publishedAt,_that.createdAt,_that.updatedAt,_that.isFeatured,_that.isPremium,_that.excerpt,_that.readingTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String content,  String authorId,  String? authorName,  String? authorPhotoUrl,  BlogCategory category,  BlogPostStatus status,  List<String> tags,  String? coverImageUrl,  int views,  int likes,  int comments,  List<String> likedBy,  List<String> bookmarkedBy,  DateTime? publishedAt,  DateTime? createdAt,  DateTime? updatedAt,  bool isFeatured,  bool isPremium,  String? excerpt,  int readingTime)  $default,) {final _that = this;
switch (_that) {
case _BlogPostModel():
return $default(_that.id,_that.title,_that.content,_that.authorId,_that.authorName,_that.authorPhotoUrl,_that.category,_that.status,_that.tags,_that.coverImageUrl,_that.views,_that.likes,_that.comments,_that.likedBy,_that.bookmarkedBy,_that.publishedAt,_that.createdAt,_that.updatedAt,_that.isFeatured,_that.isPremium,_that.excerpt,_that.readingTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String content,  String authorId,  String? authorName,  String? authorPhotoUrl,  BlogCategory category,  BlogPostStatus status,  List<String> tags,  String? coverImageUrl,  int views,  int likes,  int comments,  List<String> likedBy,  List<String> bookmarkedBy,  DateTime? publishedAt,  DateTime? createdAt,  DateTime? updatedAt,  bool isFeatured,  bool isPremium,  String? excerpt,  int readingTime)?  $default,) {final _that = this;
switch (_that) {
case _BlogPostModel() when $default != null:
return $default(_that.id,_that.title,_that.content,_that.authorId,_that.authorName,_that.authorPhotoUrl,_that.category,_that.status,_that.tags,_that.coverImageUrl,_that.views,_that.likes,_that.comments,_that.likedBy,_that.bookmarkedBy,_that.publishedAt,_that.createdAt,_that.updatedAt,_that.isFeatured,_that.isPremium,_that.excerpt,_that.readingTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BlogPostModel implements BlogPostModel {
  const _BlogPostModel({required this.id, required this.title, required this.content, required this.authorId, this.authorName, this.authorPhotoUrl, required this.category, this.status = BlogPostStatus.published, final  List<String> tags = const [], this.coverImageUrl, this.views = 0, this.likes = 0, this.comments = 0, final  List<String> likedBy = const [], final  List<String> bookmarkedBy = const [], this.publishedAt = null, this.createdAt = null, this.updatedAt = null, this.isFeatured = false, this.isPremium = false, this.excerpt, this.readingTime = 0}): _tags = tags,_likedBy = likedBy,_bookmarkedBy = bookmarkedBy;
  factory _BlogPostModel.fromJson(Map<String, dynamic> json) => _$BlogPostModelFromJson(json);

@override final  String id;
@override final  String title;
@override final  String content;
@override final  String authorId;
@override final  String? authorName;
@override final  String? authorPhotoUrl;
@override final  BlogCategory category;
@override@JsonKey() final  BlogPostStatus status;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  String? coverImageUrl;
@override@JsonKey() final  int views;
@override@JsonKey() final  int likes;
@override@JsonKey() final  int comments;
 final  List<String> _likedBy;
@override@JsonKey() List<String> get likedBy {
  if (_likedBy is EqualUnmodifiableListView) return _likedBy;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_likedBy);
}

 final  List<String> _bookmarkedBy;
@override@JsonKey() List<String> get bookmarkedBy {
  if (_bookmarkedBy is EqualUnmodifiableListView) return _bookmarkedBy;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bookmarkedBy);
}

@override@JsonKey() final  DateTime? publishedAt;
@override@JsonKey() final  DateTime? createdAt;
@override@JsonKey() final  DateTime? updatedAt;
@override@JsonKey() final  bool isFeatured;
@override@JsonKey() final  bool isPremium;
@override final  String? excerpt;
@override@JsonKey() final  int readingTime;

/// Create a copy of BlogPostModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BlogPostModelCopyWith<_BlogPostModel> get copyWith => __$BlogPostModelCopyWithImpl<_BlogPostModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BlogPostModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BlogPostModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.authorPhotoUrl, authorPhotoUrl) || other.authorPhotoUrl == authorPhotoUrl)&&(identical(other.category, category) || other.category == category)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.views, views) || other.views == views)&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.comments, comments) || other.comments == comments)&&const DeepCollectionEquality().equals(other._likedBy, _likedBy)&&const DeepCollectionEquality().equals(other._bookmarkedBy, _bookmarkedBy)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured)&&(identical(other.isPremium, isPremium) || other.isPremium == isPremium)&&(identical(other.excerpt, excerpt) || other.excerpt == excerpt)&&(identical(other.readingTime, readingTime) || other.readingTime == readingTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,content,authorId,authorName,authorPhotoUrl,category,status,const DeepCollectionEquality().hash(_tags),coverImageUrl,views,likes,comments,const DeepCollectionEquality().hash(_likedBy),const DeepCollectionEquality().hash(_bookmarkedBy),publishedAt,createdAt,updatedAt,isFeatured,isPremium,excerpt,readingTime]);

@override
String toString() {
  return 'BlogPostModel(id: $id, title: $title, content: $content, authorId: $authorId, authorName: $authorName, authorPhotoUrl: $authorPhotoUrl, category: $category, status: $status, tags: $tags, coverImageUrl: $coverImageUrl, views: $views, likes: $likes, comments: $comments, likedBy: $likedBy, bookmarkedBy: $bookmarkedBy, publishedAt: $publishedAt, createdAt: $createdAt, updatedAt: $updatedAt, isFeatured: $isFeatured, isPremium: $isPremium, excerpt: $excerpt, readingTime: $readingTime)';
}


}

/// @nodoc
abstract mixin class _$BlogPostModelCopyWith<$Res> implements $BlogPostModelCopyWith<$Res> {
  factory _$BlogPostModelCopyWith(_BlogPostModel value, $Res Function(_BlogPostModel) _then) = __$BlogPostModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String content, String authorId, String? authorName, String? authorPhotoUrl, BlogCategory category, BlogPostStatus status, List<String> tags, String? coverImageUrl, int views, int likes, int comments, List<String> likedBy, List<String> bookmarkedBy, DateTime? publishedAt, DateTime? createdAt, DateTime? updatedAt, bool isFeatured, bool isPremium, String? excerpt, int readingTime
});




}
/// @nodoc
class __$BlogPostModelCopyWithImpl<$Res>
    implements _$BlogPostModelCopyWith<$Res> {
  __$BlogPostModelCopyWithImpl(this._self, this._then);

  final _BlogPostModel _self;
  final $Res Function(_BlogPostModel) _then;

/// Create a copy of BlogPostModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? content = null,Object? authorId = null,Object? authorName = freezed,Object? authorPhotoUrl = freezed,Object? category = null,Object? status = null,Object? tags = null,Object? coverImageUrl = freezed,Object? views = null,Object? likes = null,Object? comments = null,Object? likedBy = null,Object? bookmarkedBy = null,Object? publishedAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? isFeatured = null,Object? isPremium = null,Object? excerpt = freezed,Object? readingTime = null,}) {
  return _then(_BlogPostModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String,authorName: freezed == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String?,authorPhotoUrl: freezed == authorPhotoUrl ? _self.authorPhotoUrl : authorPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as BlogCategory,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BlogPostStatus,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,views: null == views ? _self.views : views // ignore: cast_nullable_to_non_nullable
as int,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,comments: null == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as int,likedBy: null == likedBy ? _self._likedBy : likedBy // ignore: cast_nullable_to_non_nullable
as List<String>,bookmarkedBy: null == bookmarkedBy ? _self._bookmarkedBy : bookmarkedBy // ignore: cast_nullable_to_non_nullable
as List<String>,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,isPremium: null == isPremium ? _self.isPremium : isPremium // ignore: cast_nullable_to_non_nullable
as bool,excerpt: freezed == excerpt ? _self.excerpt : excerpt // ignore: cast_nullable_to_non_nullable
as String?,readingTime: null == readingTime ? _self.readingTime : readingTime // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$BlogCommentModel {

 String get id; String get postId; String get authorId; String? get authorName; String? get authorPhotoUrl; String get content; List<String> get likes; List<BlogCommentModel> get replies; DateTime? get createdAt; DateTime? get updatedAt; bool get isEdited; bool get isDeleted; String? get parentCommentId;
/// Create a copy of BlogCommentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BlogCommentModelCopyWith<BlogCommentModel> get copyWith => _$BlogCommentModelCopyWithImpl<BlogCommentModel>(this as BlogCommentModel, _$identity);

  /// Serializes this BlogCommentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BlogCommentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.postId, postId) || other.postId == postId)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.authorPhotoUrl, authorPhotoUrl) || other.authorPhotoUrl == authorPhotoUrl)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other.likes, likes)&&const DeepCollectionEquality().equals(other.replies, replies)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isEdited, isEdited) || other.isEdited == isEdited)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.parentCommentId, parentCommentId) || other.parentCommentId == parentCommentId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,postId,authorId,authorName,authorPhotoUrl,content,const DeepCollectionEquality().hash(likes),const DeepCollectionEquality().hash(replies),createdAt,updatedAt,isEdited,isDeleted,parentCommentId);

@override
String toString() {
  return 'BlogCommentModel(id: $id, postId: $postId, authorId: $authorId, authorName: $authorName, authorPhotoUrl: $authorPhotoUrl, content: $content, likes: $likes, replies: $replies, createdAt: $createdAt, updatedAt: $updatedAt, isEdited: $isEdited, isDeleted: $isDeleted, parentCommentId: $parentCommentId)';
}


}

/// @nodoc
abstract mixin class $BlogCommentModelCopyWith<$Res>  {
  factory $BlogCommentModelCopyWith(BlogCommentModel value, $Res Function(BlogCommentModel) _then) = _$BlogCommentModelCopyWithImpl;
@useResult
$Res call({
 String id, String postId, String authorId, String? authorName, String? authorPhotoUrl, String content, List<String> likes, List<BlogCommentModel> replies, DateTime? createdAt, DateTime? updatedAt, bool isEdited, bool isDeleted, String? parentCommentId
});




}
/// @nodoc
class _$BlogCommentModelCopyWithImpl<$Res>
    implements $BlogCommentModelCopyWith<$Res> {
  _$BlogCommentModelCopyWithImpl(this._self, this._then);

  final BlogCommentModel _self;
  final $Res Function(BlogCommentModel) _then;

/// Create a copy of BlogCommentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? postId = null,Object? authorId = null,Object? authorName = freezed,Object? authorPhotoUrl = freezed,Object? content = null,Object? likes = null,Object? replies = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? isEdited = null,Object? isDeleted = null,Object? parentCommentId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as String,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String,authorName: freezed == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String?,authorPhotoUrl: freezed == authorPhotoUrl ? _self.authorPhotoUrl : authorPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as List<String>,replies: null == replies ? _self.replies : replies // ignore: cast_nullable_to_non_nullable
as List<BlogCommentModel>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isEdited: null == isEdited ? _self.isEdited : isEdited // ignore: cast_nullable_to_non_nullable
as bool,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,parentCommentId: freezed == parentCommentId ? _self.parentCommentId : parentCommentId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BlogCommentModel].
extension BlogCommentModelPatterns on BlogCommentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BlogCommentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BlogCommentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BlogCommentModel value)  $default,){
final _that = this;
switch (_that) {
case _BlogCommentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BlogCommentModel value)?  $default,){
final _that = this;
switch (_that) {
case _BlogCommentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String postId,  String authorId,  String? authorName,  String? authorPhotoUrl,  String content,  List<String> likes,  List<BlogCommentModel> replies,  DateTime? createdAt,  DateTime? updatedAt,  bool isEdited,  bool isDeleted,  String? parentCommentId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BlogCommentModel() when $default != null:
return $default(_that.id,_that.postId,_that.authorId,_that.authorName,_that.authorPhotoUrl,_that.content,_that.likes,_that.replies,_that.createdAt,_that.updatedAt,_that.isEdited,_that.isDeleted,_that.parentCommentId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String postId,  String authorId,  String? authorName,  String? authorPhotoUrl,  String content,  List<String> likes,  List<BlogCommentModel> replies,  DateTime? createdAt,  DateTime? updatedAt,  bool isEdited,  bool isDeleted,  String? parentCommentId)  $default,) {final _that = this;
switch (_that) {
case _BlogCommentModel():
return $default(_that.id,_that.postId,_that.authorId,_that.authorName,_that.authorPhotoUrl,_that.content,_that.likes,_that.replies,_that.createdAt,_that.updatedAt,_that.isEdited,_that.isDeleted,_that.parentCommentId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String postId,  String authorId,  String? authorName,  String? authorPhotoUrl,  String content,  List<String> likes,  List<BlogCommentModel> replies,  DateTime? createdAt,  DateTime? updatedAt,  bool isEdited,  bool isDeleted,  String? parentCommentId)?  $default,) {final _that = this;
switch (_that) {
case _BlogCommentModel() when $default != null:
return $default(_that.id,_that.postId,_that.authorId,_that.authorName,_that.authorPhotoUrl,_that.content,_that.likes,_that.replies,_that.createdAt,_that.updatedAt,_that.isEdited,_that.isDeleted,_that.parentCommentId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BlogCommentModel implements BlogCommentModel {
  const _BlogCommentModel({required this.id, required this.postId, required this.authorId, this.authorName, this.authorPhotoUrl, required this.content, final  List<String> likes = const [], final  List<BlogCommentModel> replies = const [], this.createdAt = null, this.updatedAt = null, this.isEdited = false, this.isDeleted = false, this.parentCommentId}): _likes = likes,_replies = replies;
  factory _BlogCommentModel.fromJson(Map<String, dynamic> json) => _$BlogCommentModelFromJson(json);

@override final  String id;
@override final  String postId;
@override final  String authorId;
@override final  String? authorName;
@override final  String? authorPhotoUrl;
@override final  String content;
 final  List<String> _likes;
@override@JsonKey() List<String> get likes {
  if (_likes is EqualUnmodifiableListView) return _likes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_likes);
}

 final  List<BlogCommentModel> _replies;
@override@JsonKey() List<BlogCommentModel> get replies {
  if (_replies is EqualUnmodifiableListView) return _replies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_replies);
}

@override@JsonKey() final  DateTime? createdAt;
@override@JsonKey() final  DateTime? updatedAt;
@override@JsonKey() final  bool isEdited;
@override@JsonKey() final  bool isDeleted;
@override final  String? parentCommentId;

/// Create a copy of BlogCommentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BlogCommentModelCopyWith<_BlogCommentModel> get copyWith => __$BlogCommentModelCopyWithImpl<_BlogCommentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BlogCommentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BlogCommentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.postId, postId) || other.postId == postId)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.authorPhotoUrl, authorPhotoUrl) || other.authorPhotoUrl == authorPhotoUrl)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other._likes, _likes)&&const DeepCollectionEquality().equals(other._replies, _replies)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isEdited, isEdited) || other.isEdited == isEdited)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted)&&(identical(other.parentCommentId, parentCommentId) || other.parentCommentId == parentCommentId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,postId,authorId,authorName,authorPhotoUrl,content,const DeepCollectionEquality().hash(_likes),const DeepCollectionEquality().hash(_replies),createdAt,updatedAt,isEdited,isDeleted,parentCommentId);

@override
String toString() {
  return 'BlogCommentModel(id: $id, postId: $postId, authorId: $authorId, authorName: $authorName, authorPhotoUrl: $authorPhotoUrl, content: $content, likes: $likes, replies: $replies, createdAt: $createdAt, updatedAt: $updatedAt, isEdited: $isEdited, isDeleted: $isDeleted, parentCommentId: $parentCommentId)';
}


}

/// @nodoc
abstract mixin class _$BlogCommentModelCopyWith<$Res> implements $BlogCommentModelCopyWith<$Res> {
  factory _$BlogCommentModelCopyWith(_BlogCommentModel value, $Res Function(_BlogCommentModel) _then) = __$BlogCommentModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String postId, String authorId, String? authorName, String? authorPhotoUrl, String content, List<String> likes, List<BlogCommentModel> replies, DateTime? createdAt, DateTime? updatedAt, bool isEdited, bool isDeleted, String? parentCommentId
});




}
/// @nodoc
class __$BlogCommentModelCopyWithImpl<$Res>
    implements _$BlogCommentModelCopyWith<$Res> {
  __$BlogCommentModelCopyWithImpl(this._self, this._then);

  final _BlogCommentModel _self;
  final $Res Function(_BlogCommentModel) _then;

/// Create a copy of BlogCommentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? postId = null,Object? authorId = null,Object? authorName = freezed,Object? authorPhotoUrl = freezed,Object? content = null,Object? likes = null,Object? replies = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? isEdited = null,Object? isDeleted = null,Object? parentCommentId = freezed,}) {
  return _then(_BlogCommentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as String,authorId: null == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String,authorName: freezed == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String?,authorPhotoUrl: freezed == authorPhotoUrl ? _self.authorPhotoUrl : authorPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,likes: null == likes ? _self._likes : likes // ignore: cast_nullable_to_non_nullable
as List<String>,replies: null == replies ? _self._replies : replies // ignore: cast_nullable_to_non_nullable
as List<BlogCommentModel>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isEdited: null == isEdited ? _self.isEdited : isEdited // ignore: cast_nullable_to_non_nullable
as bool,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,parentCommentId: freezed == parentCommentId ? _self.parentCommentId : parentCommentId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$BlogCategoryModel {

 BlogCategory get category; String get displayName; String get icon; String get description; String get color; int get postCount;
/// Create a copy of BlogCategoryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BlogCategoryModelCopyWith<BlogCategoryModel> get copyWith => _$BlogCategoryModelCopyWithImpl<BlogCategoryModel>(this as BlogCategoryModel, _$identity);

  /// Serializes this BlogCategoryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BlogCategoryModel&&(identical(other.category, category) || other.category == category)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.description, description) || other.description == description)&&(identical(other.color, color) || other.color == color)&&(identical(other.postCount, postCount) || other.postCount == postCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,category,displayName,icon,description,color,postCount);

@override
String toString() {
  return 'BlogCategoryModel(category: $category, displayName: $displayName, icon: $icon, description: $description, color: $color, postCount: $postCount)';
}


}

/// @nodoc
abstract mixin class $BlogCategoryModelCopyWith<$Res>  {
  factory $BlogCategoryModelCopyWith(BlogCategoryModel value, $Res Function(BlogCategoryModel) _then) = _$BlogCategoryModelCopyWithImpl;
@useResult
$Res call({
 BlogCategory category, String displayName, String icon, String description, String color, int postCount
});




}
/// @nodoc
class _$BlogCategoryModelCopyWithImpl<$Res>
    implements $BlogCategoryModelCopyWith<$Res> {
  _$BlogCategoryModelCopyWithImpl(this._self, this._then);

  final BlogCategoryModel _self;
  final $Res Function(BlogCategoryModel) _then;

/// Create a copy of BlogCategoryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? category = null,Object? displayName = null,Object? icon = null,Object? description = null,Object? color = null,Object? postCount = null,}) {
  return _then(_self.copyWith(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as BlogCategory,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,postCount: null == postCount ? _self.postCount : postCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BlogCategoryModel].
extension BlogCategoryModelPatterns on BlogCategoryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BlogCategoryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BlogCategoryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BlogCategoryModel value)  $default,){
final _that = this;
switch (_that) {
case _BlogCategoryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BlogCategoryModel value)?  $default,){
final _that = this;
switch (_that) {
case _BlogCategoryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BlogCategory category,  String displayName,  String icon,  String description,  String color,  int postCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BlogCategoryModel() when $default != null:
return $default(_that.category,_that.displayName,_that.icon,_that.description,_that.color,_that.postCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BlogCategory category,  String displayName,  String icon,  String description,  String color,  int postCount)  $default,) {final _that = this;
switch (_that) {
case _BlogCategoryModel():
return $default(_that.category,_that.displayName,_that.icon,_that.description,_that.color,_that.postCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BlogCategory category,  String displayName,  String icon,  String description,  String color,  int postCount)?  $default,) {final _that = this;
switch (_that) {
case _BlogCategoryModel() when $default != null:
return $default(_that.category,_that.displayName,_that.icon,_that.description,_that.color,_that.postCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BlogCategoryModel implements BlogCategoryModel {
  const _BlogCategoryModel({required this.category, required this.displayName, required this.icon, required this.description, required this.color, this.postCount = 0});
  factory _BlogCategoryModel.fromJson(Map<String, dynamic> json) => _$BlogCategoryModelFromJson(json);

@override final  BlogCategory category;
@override final  String displayName;
@override final  String icon;
@override final  String description;
@override final  String color;
@override@JsonKey() final  int postCount;

/// Create a copy of BlogCategoryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BlogCategoryModelCopyWith<_BlogCategoryModel> get copyWith => __$BlogCategoryModelCopyWithImpl<_BlogCategoryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BlogCategoryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BlogCategoryModel&&(identical(other.category, category) || other.category == category)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.description, description) || other.description == description)&&(identical(other.color, color) || other.color == color)&&(identical(other.postCount, postCount) || other.postCount == postCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,category,displayName,icon,description,color,postCount);

@override
String toString() {
  return 'BlogCategoryModel(category: $category, displayName: $displayName, icon: $icon, description: $description, color: $color, postCount: $postCount)';
}


}

/// @nodoc
abstract mixin class _$BlogCategoryModelCopyWith<$Res> implements $BlogCategoryModelCopyWith<$Res> {
  factory _$BlogCategoryModelCopyWith(_BlogCategoryModel value, $Res Function(_BlogCategoryModel) _then) = __$BlogCategoryModelCopyWithImpl;
@override @useResult
$Res call({
 BlogCategory category, String displayName, String icon, String description, String color, int postCount
});




}
/// @nodoc
class __$BlogCategoryModelCopyWithImpl<$Res>
    implements _$BlogCategoryModelCopyWith<$Res> {
  __$BlogCategoryModelCopyWithImpl(this._self, this._then);

  final _BlogCategoryModel _self;
  final $Res Function(_BlogCategoryModel) _then;

/// Create a copy of BlogCategoryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? category = null,Object? displayName = null,Object? icon = null,Object? description = null,Object? color = null,Object? postCount = null,}) {
  return _then(_BlogCategoryModel(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as BlogCategory,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,postCount: null == postCount ? _self.postCount : postCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$BlogSearchResult {

 List<BlogPostModel> get posts; int get totalCount; String get query; bool get hasMore; BlogCategory? get categoryFilter; String? get authorFilter;
/// Create a copy of BlogSearchResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BlogSearchResultCopyWith<BlogSearchResult> get copyWith => _$BlogSearchResultCopyWithImpl<BlogSearchResult>(this as BlogSearchResult, _$identity);

  /// Serializes this BlogSearchResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BlogSearchResult&&const DeepCollectionEquality().equals(other.posts, posts)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.query, query) || other.query == query)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.categoryFilter, categoryFilter) || other.categoryFilter == categoryFilter)&&(identical(other.authorFilter, authorFilter) || other.authorFilter == authorFilter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(posts),totalCount,query,hasMore,categoryFilter,authorFilter);

@override
String toString() {
  return 'BlogSearchResult(posts: $posts, totalCount: $totalCount, query: $query, hasMore: $hasMore, categoryFilter: $categoryFilter, authorFilter: $authorFilter)';
}


}

/// @nodoc
abstract mixin class $BlogSearchResultCopyWith<$Res>  {
  factory $BlogSearchResultCopyWith(BlogSearchResult value, $Res Function(BlogSearchResult) _then) = _$BlogSearchResultCopyWithImpl;
@useResult
$Res call({
 List<BlogPostModel> posts, int totalCount, String query, bool hasMore, BlogCategory? categoryFilter, String? authorFilter
});




}
/// @nodoc
class _$BlogSearchResultCopyWithImpl<$Res>
    implements $BlogSearchResultCopyWith<$Res> {
  _$BlogSearchResultCopyWithImpl(this._self, this._then);

  final BlogSearchResult _self;
  final $Res Function(BlogSearchResult) _then;

/// Create a copy of BlogSearchResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? posts = null,Object? totalCount = null,Object? query = null,Object? hasMore = null,Object? categoryFilter = freezed,Object? authorFilter = freezed,}) {
  return _then(_self.copyWith(
posts: null == posts ? _self.posts : posts // ignore: cast_nullable_to_non_nullable
as List<BlogPostModel>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,categoryFilter: freezed == categoryFilter ? _self.categoryFilter : categoryFilter // ignore: cast_nullable_to_non_nullable
as BlogCategory?,authorFilter: freezed == authorFilter ? _self.authorFilter : authorFilter // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BlogSearchResult].
extension BlogSearchResultPatterns on BlogSearchResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BlogSearchResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BlogSearchResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BlogSearchResult value)  $default,){
final _that = this;
switch (_that) {
case _BlogSearchResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BlogSearchResult value)?  $default,){
final _that = this;
switch (_that) {
case _BlogSearchResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<BlogPostModel> posts,  int totalCount,  String query,  bool hasMore,  BlogCategory? categoryFilter,  String? authorFilter)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BlogSearchResult() when $default != null:
return $default(_that.posts,_that.totalCount,_that.query,_that.hasMore,_that.categoryFilter,_that.authorFilter);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<BlogPostModel> posts,  int totalCount,  String query,  bool hasMore,  BlogCategory? categoryFilter,  String? authorFilter)  $default,) {final _that = this;
switch (_that) {
case _BlogSearchResult():
return $default(_that.posts,_that.totalCount,_that.query,_that.hasMore,_that.categoryFilter,_that.authorFilter);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<BlogPostModel> posts,  int totalCount,  String query,  bool hasMore,  BlogCategory? categoryFilter,  String? authorFilter)?  $default,) {final _that = this;
switch (_that) {
case _BlogSearchResult() when $default != null:
return $default(_that.posts,_that.totalCount,_that.query,_that.hasMore,_that.categoryFilter,_that.authorFilter);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BlogSearchResult implements BlogSearchResult {
  const _BlogSearchResult({required final  List<BlogPostModel> posts, required this.totalCount, required this.query, this.hasMore = false, this.categoryFilter, this.authorFilter}): _posts = posts;
  factory _BlogSearchResult.fromJson(Map<String, dynamic> json) => _$BlogSearchResultFromJson(json);

 final  List<BlogPostModel> _posts;
@override List<BlogPostModel> get posts {
  if (_posts is EqualUnmodifiableListView) return _posts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_posts);
}

@override final  int totalCount;
@override final  String query;
@override@JsonKey() final  bool hasMore;
@override final  BlogCategory? categoryFilter;
@override final  String? authorFilter;

/// Create a copy of BlogSearchResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BlogSearchResultCopyWith<_BlogSearchResult> get copyWith => __$BlogSearchResultCopyWithImpl<_BlogSearchResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BlogSearchResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BlogSearchResult&&const DeepCollectionEquality().equals(other._posts, _posts)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.query, query) || other.query == query)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.categoryFilter, categoryFilter) || other.categoryFilter == categoryFilter)&&(identical(other.authorFilter, authorFilter) || other.authorFilter == authorFilter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_posts),totalCount,query,hasMore,categoryFilter,authorFilter);

@override
String toString() {
  return 'BlogSearchResult(posts: $posts, totalCount: $totalCount, query: $query, hasMore: $hasMore, categoryFilter: $categoryFilter, authorFilter: $authorFilter)';
}


}

/// @nodoc
abstract mixin class _$BlogSearchResultCopyWith<$Res> implements $BlogSearchResultCopyWith<$Res> {
  factory _$BlogSearchResultCopyWith(_BlogSearchResult value, $Res Function(_BlogSearchResult) _then) = __$BlogSearchResultCopyWithImpl;
@override @useResult
$Res call({
 List<BlogPostModel> posts, int totalCount, String query, bool hasMore, BlogCategory? categoryFilter, String? authorFilter
});




}
/// @nodoc
class __$BlogSearchResultCopyWithImpl<$Res>
    implements _$BlogSearchResultCopyWith<$Res> {
  __$BlogSearchResultCopyWithImpl(this._self, this._then);

  final _BlogSearchResult _self;
  final $Res Function(_BlogSearchResult) _then;

/// Create a copy of BlogSearchResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? posts = null,Object? totalCount = null,Object? query = null,Object? hasMore = null,Object? categoryFilter = freezed,Object? authorFilter = freezed,}) {
  return _then(_BlogSearchResult(
posts: null == posts ? _self._posts : posts // ignore: cast_nullable_to_non_nullable
as List<BlogPostModel>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,categoryFilter: freezed == categoryFilter ? _self.categoryFilter : categoryFilter // ignore: cast_nullable_to_non_nullable
as BlogCategory?,authorFilter: freezed == authorFilter ? _self.authorFilter : authorFilter // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
