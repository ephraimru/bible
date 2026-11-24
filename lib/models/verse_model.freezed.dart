// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verse_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VerseModel {

 String get id; String get reference; String get text; String get book; int get chapter; int get verse; String? get translation; String? get imageUrl; String? get backgroundImageUrl; int get likes; int get saves; List<String> get likedBy; List<String> get savedBy; List<String> get tags; String? get themeColor; DateTime? get date; bool get isDailyVerse; String? get author; String? get reflection;
/// Create a copy of VerseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerseModelCopyWith<VerseModel> get copyWith => _$VerseModelCopyWithImpl<VerseModel>(this as VerseModel, _$identity);

  /// Serializes this VerseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.text, text) || other.text == text)&&(identical(other.book, book) || other.book == book)&&(identical(other.chapter, chapter) || other.chapter == chapter)&&(identical(other.verse, verse) || other.verse == verse)&&(identical(other.translation, translation) || other.translation == translation)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.backgroundImageUrl, backgroundImageUrl) || other.backgroundImageUrl == backgroundImageUrl)&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.saves, saves) || other.saves == saves)&&const DeepCollectionEquality().equals(other.likedBy, likedBy)&&const DeepCollectionEquality().equals(other.savedBy, savedBy)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.themeColor, themeColor) || other.themeColor == themeColor)&&(identical(other.date, date) || other.date == date)&&(identical(other.isDailyVerse, isDailyVerse) || other.isDailyVerse == isDailyVerse)&&(identical(other.author, author) || other.author == author)&&(identical(other.reflection, reflection) || other.reflection == reflection));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,reference,text,book,chapter,verse,translation,imageUrl,backgroundImageUrl,likes,saves,const DeepCollectionEquality().hash(likedBy),const DeepCollectionEquality().hash(savedBy),const DeepCollectionEquality().hash(tags),themeColor,date,isDailyVerse,author,reflection]);

@override
String toString() {
  return 'VerseModel(id: $id, reference: $reference, text: $text, book: $book, chapter: $chapter, verse: $verse, translation: $translation, imageUrl: $imageUrl, backgroundImageUrl: $backgroundImageUrl, likes: $likes, saves: $saves, likedBy: $likedBy, savedBy: $savedBy, tags: $tags, themeColor: $themeColor, date: $date, isDailyVerse: $isDailyVerse, author: $author, reflection: $reflection)';
}


}

/// @nodoc
abstract mixin class $VerseModelCopyWith<$Res>  {
  factory $VerseModelCopyWith(VerseModel value, $Res Function(VerseModel) _then) = _$VerseModelCopyWithImpl;
@useResult
$Res call({
 String id, String reference, String text, String book, int chapter, int verse, String? translation, String? imageUrl, String? backgroundImageUrl, int likes, int saves, List<String> likedBy, List<String> savedBy, List<String> tags, String? themeColor, DateTime? date, bool isDailyVerse, String? author, String? reflection
});




}
/// @nodoc
class _$VerseModelCopyWithImpl<$Res>
    implements $VerseModelCopyWith<$Res> {
  _$VerseModelCopyWithImpl(this._self, this._then);

  final VerseModel _self;
  final $Res Function(VerseModel) _then;

/// Create a copy of VerseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? reference = null,Object? text = null,Object? book = null,Object? chapter = null,Object? verse = null,Object? translation = freezed,Object? imageUrl = freezed,Object? backgroundImageUrl = freezed,Object? likes = null,Object? saves = null,Object? likedBy = null,Object? savedBy = null,Object? tags = null,Object? themeColor = freezed,Object? date = freezed,Object? isDailyVerse = null,Object? author = freezed,Object? reflection = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,book: null == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as String,chapter: null == chapter ? _self.chapter : chapter // ignore: cast_nullable_to_non_nullable
as int,verse: null == verse ? _self.verse : verse // ignore: cast_nullable_to_non_nullable
as int,translation: freezed == translation ? _self.translation : translation // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,backgroundImageUrl: freezed == backgroundImageUrl ? _self.backgroundImageUrl : backgroundImageUrl // ignore: cast_nullable_to_non_nullable
as String?,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,saves: null == saves ? _self.saves : saves // ignore: cast_nullable_to_non_nullable
as int,likedBy: null == likedBy ? _self.likedBy : likedBy // ignore: cast_nullable_to_non_nullable
as List<String>,savedBy: null == savedBy ? _self.savedBy : savedBy // ignore: cast_nullable_to_non_nullable
as List<String>,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,themeColor: freezed == themeColor ? _self.themeColor : themeColor // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime?,isDailyVerse: null == isDailyVerse ? _self.isDailyVerse : isDailyVerse // ignore: cast_nullable_to_non_nullable
as bool,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,reflection: freezed == reflection ? _self.reflection : reflection // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VerseModel].
extension VerseModelPatterns on VerseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerseModel value)  $default,){
final _that = this;
switch (_that) {
case _VerseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerseModel value)?  $default,){
final _that = this;
switch (_that) {
case _VerseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String reference,  String text,  String book,  int chapter,  int verse,  String? translation,  String? imageUrl,  String? backgroundImageUrl,  int likes,  int saves,  List<String> likedBy,  List<String> savedBy,  List<String> tags,  String? themeColor,  DateTime? date,  bool isDailyVerse,  String? author,  String? reflection)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerseModel() when $default != null:
return $default(_that.id,_that.reference,_that.text,_that.book,_that.chapter,_that.verse,_that.translation,_that.imageUrl,_that.backgroundImageUrl,_that.likes,_that.saves,_that.likedBy,_that.savedBy,_that.tags,_that.themeColor,_that.date,_that.isDailyVerse,_that.author,_that.reflection);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String reference,  String text,  String book,  int chapter,  int verse,  String? translation,  String? imageUrl,  String? backgroundImageUrl,  int likes,  int saves,  List<String> likedBy,  List<String> savedBy,  List<String> tags,  String? themeColor,  DateTime? date,  bool isDailyVerse,  String? author,  String? reflection)  $default,) {final _that = this;
switch (_that) {
case _VerseModel():
return $default(_that.id,_that.reference,_that.text,_that.book,_that.chapter,_that.verse,_that.translation,_that.imageUrl,_that.backgroundImageUrl,_that.likes,_that.saves,_that.likedBy,_that.savedBy,_that.tags,_that.themeColor,_that.date,_that.isDailyVerse,_that.author,_that.reflection);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String reference,  String text,  String book,  int chapter,  int verse,  String? translation,  String? imageUrl,  String? backgroundImageUrl,  int likes,  int saves,  List<String> likedBy,  List<String> savedBy,  List<String> tags,  String? themeColor,  DateTime? date,  bool isDailyVerse,  String? author,  String? reflection)?  $default,) {final _that = this;
switch (_that) {
case _VerseModel() when $default != null:
return $default(_that.id,_that.reference,_that.text,_that.book,_that.chapter,_that.verse,_that.translation,_that.imageUrl,_that.backgroundImageUrl,_that.likes,_that.saves,_that.likedBy,_that.savedBy,_that.tags,_that.themeColor,_that.date,_that.isDailyVerse,_that.author,_that.reflection);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VerseModel implements VerseModel {
  const _VerseModel({required this.id, required this.reference, required this.text, required this.book, required this.chapter, required this.verse, this.translation, this.imageUrl, this.backgroundImageUrl, this.likes = 0, this.saves = 0, final  List<String> likedBy = const [], final  List<String> savedBy = const [], final  List<String> tags = const [], this.themeColor = null, this.date = null, this.isDailyVerse = false, this.author = null, this.reflection = null}): _likedBy = likedBy,_savedBy = savedBy,_tags = tags;
  factory _VerseModel.fromJson(Map<String, dynamic> json) => _$VerseModelFromJson(json);

@override final  String id;
@override final  String reference;
@override final  String text;
@override final  String book;
@override final  int chapter;
@override final  int verse;
@override final  String? translation;
@override final  String? imageUrl;
@override final  String? backgroundImageUrl;
@override@JsonKey() final  int likes;
@override@JsonKey() final  int saves;
 final  List<String> _likedBy;
@override@JsonKey() List<String> get likedBy {
  if (_likedBy is EqualUnmodifiableListView) return _likedBy;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_likedBy);
}

 final  List<String> _savedBy;
@override@JsonKey() List<String> get savedBy {
  if (_savedBy is EqualUnmodifiableListView) return _savedBy;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_savedBy);
}

 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override@JsonKey() final  String? themeColor;
@override@JsonKey() final  DateTime? date;
@override@JsonKey() final  bool isDailyVerse;
@override@JsonKey() final  String? author;
@override@JsonKey() final  String? reflection;

/// Create a copy of VerseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerseModelCopyWith<_VerseModel> get copyWith => __$VerseModelCopyWithImpl<_VerseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerseModel&&(identical(other.id, id) || other.id == id)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.text, text) || other.text == text)&&(identical(other.book, book) || other.book == book)&&(identical(other.chapter, chapter) || other.chapter == chapter)&&(identical(other.verse, verse) || other.verse == verse)&&(identical(other.translation, translation) || other.translation == translation)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.backgroundImageUrl, backgroundImageUrl) || other.backgroundImageUrl == backgroundImageUrl)&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.saves, saves) || other.saves == saves)&&const DeepCollectionEquality().equals(other._likedBy, _likedBy)&&const DeepCollectionEquality().equals(other._savedBy, _savedBy)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.themeColor, themeColor) || other.themeColor == themeColor)&&(identical(other.date, date) || other.date == date)&&(identical(other.isDailyVerse, isDailyVerse) || other.isDailyVerse == isDailyVerse)&&(identical(other.author, author) || other.author == author)&&(identical(other.reflection, reflection) || other.reflection == reflection));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,reference,text,book,chapter,verse,translation,imageUrl,backgroundImageUrl,likes,saves,const DeepCollectionEquality().hash(_likedBy),const DeepCollectionEquality().hash(_savedBy),const DeepCollectionEquality().hash(_tags),themeColor,date,isDailyVerse,author,reflection]);

@override
String toString() {
  return 'VerseModel(id: $id, reference: $reference, text: $text, book: $book, chapter: $chapter, verse: $verse, translation: $translation, imageUrl: $imageUrl, backgroundImageUrl: $backgroundImageUrl, likes: $likes, saves: $saves, likedBy: $likedBy, savedBy: $savedBy, tags: $tags, themeColor: $themeColor, date: $date, isDailyVerse: $isDailyVerse, author: $author, reflection: $reflection)';
}


}

/// @nodoc
abstract mixin class _$VerseModelCopyWith<$Res> implements $VerseModelCopyWith<$Res> {
  factory _$VerseModelCopyWith(_VerseModel value, $Res Function(_VerseModel) _then) = __$VerseModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String reference, String text, String book, int chapter, int verse, String? translation, String? imageUrl, String? backgroundImageUrl, int likes, int saves, List<String> likedBy, List<String> savedBy, List<String> tags, String? themeColor, DateTime? date, bool isDailyVerse, String? author, String? reflection
});




}
/// @nodoc
class __$VerseModelCopyWithImpl<$Res>
    implements _$VerseModelCopyWith<$Res> {
  __$VerseModelCopyWithImpl(this._self, this._then);

  final _VerseModel _self;
  final $Res Function(_VerseModel) _then;

/// Create a copy of VerseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? reference = null,Object? text = null,Object? book = null,Object? chapter = null,Object? verse = null,Object? translation = freezed,Object? imageUrl = freezed,Object? backgroundImageUrl = freezed,Object? likes = null,Object? saves = null,Object? likedBy = null,Object? savedBy = null,Object? tags = null,Object? themeColor = freezed,Object? date = freezed,Object? isDailyVerse = null,Object? author = freezed,Object? reflection = freezed,}) {
  return _then(_VerseModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,book: null == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as String,chapter: null == chapter ? _self.chapter : chapter // ignore: cast_nullable_to_non_nullable
as int,verse: null == verse ? _self.verse : verse // ignore: cast_nullable_to_non_nullable
as int,translation: freezed == translation ? _self.translation : translation // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,backgroundImageUrl: freezed == backgroundImageUrl ? _self.backgroundImageUrl : backgroundImageUrl // ignore: cast_nullable_to_non_nullable
as String?,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,saves: null == saves ? _self.saves : saves // ignore: cast_nullable_to_non_nullable
as int,likedBy: null == likedBy ? _self._likedBy : likedBy // ignore: cast_nullable_to_non_nullable
as List<String>,savedBy: null == savedBy ? _self._savedBy : savedBy // ignore: cast_nullable_to_non_nullable
as List<String>,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,themeColor: freezed == themeColor ? _self.themeColor : themeColor // ignore: cast_nullable_to_non_nullable
as String?,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime?,isDailyVerse: null == isDailyVerse ? _self.isDailyVerse : isDailyVerse // ignore: cast_nullable_to_non_nullable
as bool,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,reflection: freezed == reflection ? _self.reflection : reflection // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$DailyVerseModel {

 VerseModel get verse; DateTime get date; String? get backgroundImageUrl; String? get themeColor; String? get reflection; String? get author; List<String> get tags;
/// Create a copy of DailyVerseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyVerseModelCopyWith<DailyVerseModel> get copyWith => _$DailyVerseModelCopyWithImpl<DailyVerseModel>(this as DailyVerseModel, _$identity);

  /// Serializes this DailyVerseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyVerseModel&&(identical(other.verse, verse) || other.verse == verse)&&(identical(other.date, date) || other.date == date)&&(identical(other.backgroundImageUrl, backgroundImageUrl) || other.backgroundImageUrl == backgroundImageUrl)&&(identical(other.themeColor, themeColor) || other.themeColor == themeColor)&&(identical(other.reflection, reflection) || other.reflection == reflection)&&(identical(other.author, author) || other.author == author)&&const DeepCollectionEquality().equals(other.tags, tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,verse,date,backgroundImageUrl,themeColor,reflection,author,const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'DailyVerseModel(verse: $verse, date: $date, backgroundImageUrl: $backgroundImageUrl, themeColor: $themeColor, reflection: $reflection, author: $author, tags: $tags)';
}


}

/// @nodoc
abstract mixin class $DailyVerseModelCopyWith<$Res>  {
  factory $DailyVerseModelCopyWith(DailyVerseModel value, $Res Function(DailyVerseModel) _then) = _$DailyVerseModelCopyWithImpl;
@useResult
$Res call({
 VerseModel verse, DateTime date, String? backgroundImageUrl, String? themeColor, String? reflection, String? author, List<String> tags
});


$VerseModelCopyWith<$Res> get verse;

}
/// @nodoc
class _$DailyVerseModelCopyWithImpl<$Res>
    implements $DailyVerseModelCopyWith<$Res> {
  _$DailyVerseModelCopyWithImpl(this._self, this._then);

  final DailyVerseModel _self;
  final $Res Function(DailyVerseModel) _then;

/// Create a copy of DailyVerseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? verse = null,Object? date = null,Object? backgroundImageUrl = freezed,Object? themeColor = freezed,Object? reflection = freezed,Object? author = freezed,Object? tags = null,}) {
  return _then(_self.copyWith(
verse: null == verse ? _self.verse : verse // ignore: cast_nullable_to_non_nullable
as VerseModel,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,backgroundImageUrl: freezed == backgroundImageUrl ? _self.backgroundImageUrl : backgroundImageUrl // ignore: cast_nullable_to_non_nullable
as String?,themeColor: freezed == themeColor ? _self.themeColor : themeColor // ignore: cast_nullable_to_non_nullable
as String?,reflection: freezed == reflection ? _self.reflection : reflection // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of DailyVerseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VerseModelCopyWith<$Res> get verse {
  
  return $VerseModelCopyWith<$Res>(_self.verse, (value) {
    return _then(_self.copyWith(verse: value));
  });
}
}


/// Adds pattern-matching-related methods to [DailyVerseModel].
extension DailyVerseModelPatterns on DailyVerseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyVerseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyVerseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyVerseModel value)  $default,){
final _that = this;
switch (_that) {
case _DailyVerseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyVerseModel value)?  $default,){
final _that = this;
switch (_that) {
case _DailyVerseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( VerseModel verse,  DateTime date,  String? backgroundImageUrl,  String? themeColor,  String? reflection,  String? author,  List<String> tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyVerseModel() when $default != null:
return $default(_that.verse,_that.date,_that.backgroundImageUrl,_that.themeColor,_that.reflection,_that.author,_that.tags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( VerseModel verse,  DateTime date,  String? backgroundImageUrl,  String? themeColor,  String? reflection,  String? author,  List<String> tags)  $default,) {final _that = this;
switch (_that) {
case _DailyVerseModel():
return $default(_that.verse,_that.date,_that.backgroundImageUrl,_that.themeColor,_that.reflection,_that.author,_that.tags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( VerseModel verse,  DateTime date,  String? backgroundImageUrl,  String? themeColor,  String? reflection,  String? author,  List<String> tags)?  $default,) {final _that = this;
switch (_that) {
case _DailyVerseModel() when $default != null:
return $default(_that.verse,_that.date,_that.backgroundImageUrl,_that.themeColor,_that.reflection,_that.author,_that.tags);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DailyVerseModel implements DailyVerseModel {
  const _DailyVerseModel({required this.verse, required this.date, this.backgroundImageUrl, this.themeColor, this.reflection, this.author, final  List<String> tags = const []}): _tags = tags;
  factory _DailyVerseModel.fromJson(Map<String, dynamic> json) => _$DailyVerseModelFromJson(json);

@override final  VerseModel verse;
@override final  DateTime date;
@override final  String? backgroundImageUrl;
@override final  String? themeColor;
@override final  String? reflection;
@override final  String? author;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}


/// Create a copy of DailyVerseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyVerseModelCopyWith<_DailyVerseModel> get copyWith => __$DailyVerseModelCopyWithImpl<_DailyVerseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailyVerseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyVerseModel&&(identical(other.verse, verse) || other.verse == verse)&&(identical(other.date, date) || other.date == date)&&(identical(other.backgroundImageUrl, backgroundImageUrl) || other.backgroundImageUrl == backgroundImageUrl)&&(identical(other.themeColor, themeColor) || other.themeColor == themeColor)&&(identical(other.reflection, reflection) || other.reflection == reflection)&&(identical(other.author, author) || other.author == author)&&const DeepCollectionEquality().equals(other._tags, _tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,verse,date,backgroundImageUrl,themeColor,reflection,author,const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'DailyVerseModel(verse: $verse, date: $date, backgroundImageUrl: $backgroundImageUrl, themeColor: $themeColor, reflection: $reflection, author: $author, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$DailyVerseModelCopyWith<$Res> implements $DailyVerseModelCopyWith<$Res> {
  factory _$DailyVerseModelCopyWith(_DailyVerseModel value, $Res Function(_DailyVerseModel) _then) = __$DailyVerseModelCopyWithImpl;
@override @useResult
$Res call({
 VerseModel verse, DateTime date, String? backgroundImageUrl, String? themeColor, String? reflection, String? author, List<String> tags
});


@override $VerseModelCopyWith<$Res> get verse;

}
/// @nodoc
class __$DailyVerseModelCopyWithImpl<$Res>
    implements _$DailyVerseModelCopyWith<$Res> {
  __$DailyVerseModelCopyWithImpl(this._self, this._then);

  final _DailyVerseModel _self;
  final $Res Function(_DailyVerseModel) _then;

/// Create a copy of DailyVerseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? verse = null,Object? date = null,Object? backgroundImageUrl = freezed,Object? themeColor = freezed,Object? reflection = freezed,Object? author = freezed,Object? tags = null,}) {
  return _then(_DailyVerseModel(
verse: null == verse ? _self.verse : verse // ignore: cast_nullable_to_non_nullable
as VerseModel,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,backgroundImageUrl: freezed == backgroundImageUrl ? _self.backgroundImageUrl : backgroundImageUrl // ignore: cast_nullable_to_non_nullable
as String?,themeColor: freezed == themeColor ? _self.themeColor : themeColor // ignore: cast_nullable_to_non_nullable
as String?,reflection: freezed == reflection ? _self.reflection : reflection // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of DailyVerseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VerseModelCopyWith<$Res> get verse {
  
  return $VerseModelCopyWith<$Res>(_self.verse, (value) {
    return _then(_self.copyWith(verse: value));
  });
}
}


/// @nodoc
mixin _$BibleBook {

 String get name; String get abbreviation; int get chapters; int get testament;// 1 = Old Testament, 2 = New Testament
 int get order;
/// Create a copy of BibleBook
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BibleBookCopyWith<BibleBook> get copyWith => _$BibleBookCopyWithImpl<BibleBook>(this as BibleBook, _$identity);

  /// Serializes this BibleBook to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BibleBook&&(identical(other.name, name) || other.name == name)&&(identical(other.abbreviation, abbreviation) || other.abbreviation == abbreviation)&&(identical(other.chapters, chapters) || other.chapters == chapters)&&(identical(other.testament, testament) || other.testament == testament)&&(identical(other.order, order) || other.order == order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,abbreviation,chapters,testament,order);

@override
String toString() {
  return 'BibleBook(name: $name, abbreviation: $abbreviation, chapters: $chapters, testament: $testament, order: $order)';
}


}

/// @nodoc
abstract mixin class $BibleBookCopyWith<$Res>  {
  factory $BibleBookCopyWith(BibleBook value, $Res Function(BibleBook) _then) = _$BibleBookCopyWithImpl;
@useResult
$Res call({
 String name, String abbreviation, int chapters, int testament, int order
});




}
/// @nodoc
class _$BibleBookCopyWithImpl<$Res>
    implements $BibleBookCopyWith<$Res> {
  _$BibleBookCopyWithImpl(this._self, this._then);

  final BibleBook _self;
  final $Res Function(BibleBook) _then;

/// Create a copy of BibleBook
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? abbreviation = null,Object? chapters = null,Object? testament = null,Object? order = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,abbreviation: null == abbreviation ? _self.abbreviation : abbreviation // ignore: cast_nullable_to_non_nullable
as String,chapters: null == chapters ? _self.chapters : chapters // ignore: cast_nullable_to_non_nullable
as int,testament: null == testament ? _self.testament : testament // ignore: cast_nullable_to_non_nullable
as int,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BibleBook].
extension BibleBookPatterns on BibleBook {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BibleBook value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BibleBook() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BibleBook value)  $default,){
final _that = this;
switch (_that) {
case _BibleBook():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BibleBook value)?  $default,){
final _that = this;
switch (_that) {
case _BibleBook() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String abbreviation,  int chapters,  int testament,  int order)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BibleBook() when $default != null:
return $default(_that.name,_that.abbreviation,_that.chapters,_that.testament,_that.order);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String abbreviation,  int chapters,  int testament,  int order)  $default,) {final _that = this;
switch (_that) {
case _BibleBook():
return $default(_that.name,_that.abbreviation,_that.chapters,_that.testament,_that.order);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String abbreviation,  int chapters,  int testament,  int order)?  $default,) {final _that = this;
switch (_that) {
case _BibleBook() when $default != null:
return $default(_that.name,_that.abbreviation,_that.chapters,_that.testament,_that.order);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BibleBook implements BibleBook {
  const _BibleBook({required this.name, required this.abbreviation, required this.chapters, required this.testament, required this.order});
  factory _BibleBook.fromJson(Map<String, dynamic> json) => _$BibleBookFromJson(json);

@override final  String name;
@override final  String abbreviation;
@override final  int chapters;
@override final  int testament;
// 1 = Old Testament, 2 = New Testament
@override final  int order;

/// Create a copy of BibleBook
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BibleBookCopyWith<_BibleBook> get copyWith => __$BibleBookCopyWithImpl<_BibleBook>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BibleBookToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BibleBook&&(identical(other.name, name) || other.name == name)&&(identical(other.abbreviation, abbreviation) || other.abbreviation == abbreviation)&&(identical(other.chapters, chapters) || other.chapters == chapters)&&(identical(other.testament, testament) || other.testament == testament)&&(identical(other.order, order) || other.order == order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,abbreviation,chapters,testament,order);

@override
String toString() {
  return 'BibleBook(name: $name, abbreviation: $abbreviation, chapters: $chapters, testament: $testament, order: $order)';
}


}

/// @nodoc
abstract mixin class _$BibleBookCopyWith<$Res> implements $BibleBookCopyWith<$Res> {
  factory _$BibleBookCopyWith(_BibleBook value, $Res Function(_BibleBook) _then) = __$BibleBookCopyWithImpl;
@override @useResult
$Res call({
 String name, String abbreviation, int chapters, int testament, int order
});




}
/// @nodoc
class __$BibleBookCopyWithImpl<$Res>
    implements _$BibleBookCopyWith<$Res> {
  __$BibleBookCopyWithImpl(this._self, this._then);

  final _BibleBook _self;
  final $Res Function(_BibleBook) _then;

/// Create a copy of BibleBook
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? abbreviation = null,Object? chapters = null,Object? testament = null,Object? order = null,}) {
  return _then(_BibleBook(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,abbreviation: null == abbreviation ? _self.abbreviation : abbreviation // ignore: cast_nullable_to_non_nullable
as String,chapters: null == chapters ? _self.chapters : chapters // ignore: cast_nullable_to_non_nullable
as int,testament: null == testament ? _self.testament : testament // ignore: cast_nullable_to_non_nullable
as int,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$BibleChapter {

 String get book; int get chapter; List<VerseModel> get verses; int get totalVerses;
/// Create a copy of BibleChapter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BibleChapterCopyWith<BibleChapter> get copyWith => _$BibleChapterCopyWithImpl<BibleChapter>(this as BibleChapter, _$identity);

  /// Serializes this BibleChapter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BibleChapter&&(identical(other.book, book) || other.book == book)&&(identical(other.chapter, chapter) || other.chapter == chapter)&&const DeepCollectionEquality().equals(other.verses, verses)&&(identical(other.totalVerses, totalVerses) || other.totalVerses == totalVerses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,book,chapter,const DeepCollectionEquality().hash(verses),totalVerses);

@override
String toString() {
  return 'BibleChapter(book: $book, chapter: $chapter, verses: $verses, totalVerses: $totalVerses)';
}


}

/// @nodoc
abstract mixin class $BibleChapterCopyWith<$Res>  {
  factory $BibleChapterCopyWith(BibleChapter value, $Res Function(BibleChapter) _then) = _$BibleChapterCopyWithImpl;
@useResult
$Res call({
 String book, int chapter, List<VerseModel> verses, int totalVerses
});




}
/// @nodoc
class _$BibleChapterCopyWithImpl<$Res>
    implements $BibleChapterCopyWith<$Res> {
  _$BibleChapterCopyWithImpl(this._self, this._then);

  final BibleChapter _self;
  final $Res Function(BibleChapter) _then;

/// Create a copy of BibleChapter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? book = null,Object? chapter = null,Object? verses = null,Object? totalVerses = null,}) {
  return _then(_self.copyWith(
book: null == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as String,chapter: null == chapter ? _self.chapter : chapter // ignore: cast_nullable_to_non_nullable
as int,verses: null == verses ? _self.verses : verses // ignore: cast_nullable_to_non_nullable
as List<VerseModel>,totalVerses: null == totalVerses ? _self.totalVerses : totalVerses // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BibleChapter].
extension BibleChapterPatterns on BibleChapter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BibleChapter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BibleChapter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BibleChapter value)  $default,){
final _that = this;
switch (_that) {
case _BibleChapter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BibleChapter value)?  $default,){
final _that = this;
switch (_that) {
case _BibleChapter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String book,  int chapter,  List<VerseModel> verses,  int totalVerses)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BibleChapter() when $default != null:
return $default(_that.book,_that.chapter,_that.verses,_that.totalVerses);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String book,  int chapter,  List<VerseModel> verses,  int totalVerses)  $default,) {final _that = this;
switch (_that) {
case _BibleChapter():
return $default(_that.book,_that.chapter,_that.verses,_that.totalVerses);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String book,  int chapter,  List<VerseModel> verses,  int totalVerses)?  $default,) {final _that = this;
switch (_that) {
case _BibleChapter() when $default != null:
return $default(_that.book,_that.chapter,_that.verses,_that.totalVerses);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BibleChapter implements BibleChapter {
  const _BibleChapter({required this.book, required this.chapter, required final  List<VerseModel> verses, this.totalVerses = 0}): _verses = verses;
  factory _BibleChapter.fromJson(Map<String, dynamic> json) => _$BibleChapterFromJson(json);

@override final  String book;
@override final  int chapter;
 final  List<VerseModel> _verses;
@override List<VerseModel> get verses {
  if (_verses is EqualUnmodifiableListView) return _verses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_verses);
}

@override@JsonKey() final  int totalVerses;

/// Create a copy of BibleChapter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BibleChapterCopyWith<_BibleChapter> get copyWith => __$BibleChapterCopyWithImpl<_BibleChapter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BibleChapterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BibleChapter&&(identical(other.book, book) || other.book == book)&&(identical(other.chapter, chapter) || other.chapter == chapter)&&const DeepCollectionEquality().equals(other._verses, _verses)&&(identical(other.totalVerses, totalVerses) || other.totalVerses == totalVerses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,book,chapter,const DeepCollectionEquality().hash(_verses),totalVerses);

@override
String toString() {
  return 'BibleChapter(book: $book, chapter: $chapter, verses: $verses, totalVerses: $totalVerses)';
}


}

/// @nodoc
abstract mixin class _$BibleChapterCopyWith<$Res> implements $BibleChapterCopyWith<$Res> {
  factory _$BibleChapterCopyWith(_BibleChapter value, $Res Function(_BibleChapter) _then) = __$BibleChapterCopyWithImpl;
@override @useResult
$Res call({
 String book, int chapter, List<VerseModel> verses, int totalVerses
});




}
/// @nodoc
class __$BibleChapterCopyWithImpl<$Res>
    implements _$BibleChapterCopyWith<$Res> {
  __$BibleChapterCopyWithImpl(this._self, this._then);

  final _BibleChapter _self;
  final $Res Function(_BibleChapter) _then;

/// Create a copy of BibleChapter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? book = null,Object? chapter = null,Object? verses = null,Object? totalVerses = null,}) {
  return _then(_BibleChapter(
book: null == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as String,chapter: null == chapter ? _self.chapter : chapter // ignore: cast_nullable_to_non_nullable
as int,verses: null == verses ? _self._verses : verses // ignore: cast_nullable_to_non_nullable
as List<VerseModel>,totalVerses: null == totalVerses ? _self.totalVerses : totalVerses // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$VerseSearchResult {

 List<VerseModel> get verses; int get totalCount; String get query; bool get hasMore;
/// Create a copy of VerseSearchResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerseSearchResultCopyWith<VerseSearchResult> get copyWith => _$VerseSearchResultCopyWithImpl<VerseSearchResult>(this as VerseSearchResult, _$identity);

  /// Serializes this VerseSearchResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerseSearchResult&&const DeepCollectionEquality().equals(other.verses, verses)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.query, query) || other.query == query)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(verses),totalCount,query,hasMore);

@override
String toString() {
  return 'VerseSearchResult(verses: $verses, totalCount: $totalCount, query: $query, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class $VerseSearchResultCopyWith<$Res>  {
  factory $VerseSearchResultCopyWith(VerseSearchResult value, $Res Function(VerseSearchResult) _then) = _$VerseSearchResultCopyWithImpl;
@useResult
$Res call({
 List<VerseModel> verses, int totalCount, String query, bool hasMore
});




}
/// @nodoc
class _$VerseSearchResultCopyWithImpl<$Res>
    implements $VerseSearchResultCopyWith<$Res> {
  _$VerseSearchResultCopyWithImpl(this._self, this._then);

  final VerseSearchResult _self;
  final $Res Function(VerseSearchResult) _then;

/// Create a copy of VerseSearchResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? verses = null,Object? totalCount = null,Object? query = null,Object? hasMore = null,}) {
  return _then(_self.copyWith(
verses: null == verses ? _self.verses : verses // ignore: cast_nullable_to_non_nullable
as List<VerseModel>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [VerseSearchResult].
extension VerseSearchResultPatterns on VerseSearchResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerseSearchResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerseSearchResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerseSearchResult value)  $default,){
final _that = this;
switch (_that) {
case _VerseSearchResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerseSearchResult value)?  $default,){
final _that = this;
switch (_that) {
case _VerseSearchResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<VerseModel> verses,  int totalCount,  String query,  bool hasMore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerseSearchResult() when $default != null:
return $default(_that.verses,_that.totalCount,_that.query,_that.hasMore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<VerseModel> verses,  int totalCount,  String query,  bool hasMore)  $default,) {final _that = this;
switch (_that) {
case _VerseSearchResult():
return $default(_that.verses,_that.totalCount,_that.query,_that.hasMore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<VerseModel> verses,  int totalCount,  String query,  bool hasMore)?  $default,) {final _that = this;
switch (_that) {
case _VerseSearchResult() when $default != null:
return $default(_that.verses,_that.totalCount,_that.query,_that.hasMore);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VerseSearchResult implements VerseSearchResult {
  const _VerseSearchResult({required final  List<VerseModel> verses, required this.totalCount, required this.query, this.hasMore = false}): _verses = verses;
  factory _VerseSearchResult.fromJson(Map<String, dynamic> json) => _$VerseSearchResultFromJson(json);

 final  List<VerseModel> _verses;
@override List<VerseModel> get verses {
  if (_verses is EqualUnmodifiableListView) return _verses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_verses);
}

@override final  int totalCount;
@override final  String query;
@override@JsonKey() final  bool hasMore;

/// Create a copy of VerseSearchResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerseSearchResultCopyWith<_VerseSearchResult> get copyWith => __$VerseSearchResultCopyWithImpl<_VerseSearchResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerseSearchResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerseSearchResult&&const DeepCollectionEquality().equals(other._verses, _verses)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.query, query) || other.query == query)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_verses),totalCount,query,hasMore);

@override
String toString() {
  return 'VerseSearchResult(verses: $verses, totalCount: $totalCount, query: $query, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class _$VerseSearchResultCopyWith<$Res> implements $VerseSearchResultCopyWith<$Res> {
  factory _$VerseSearchResultCopyWith(_VerseSearchResult value, $Res Function(_VerseSearchResult) _then) = __$VerseSearchResultCopyWithImpl;
@override @useResult
$Res call({
 List<VerseModel> verses, int totalCount, String query, bool hasMore
});




}
/// @nodoc
class __$VerseSearchResultCopyWithImpl<$Res>
    implements _$VerseSearchResultCopyWith<$Res> {
  __$VerseSearchResultCopyWithImpl(this._self, this._then);

  final _VerseSearchResult _self;
  final $Res Function(_VerseSearchResult) _then;

/// Create a copy of VerseSearchResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? verses = null,Object? totalCount = null,Object? query = null,Object? hasMore = null,}) {
  return _then(_VerseSearchResult(
verses: null == verses ? _self._verses : verses // ignore: cast_nullable_to_non_nullable
as List<VerseModel>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
