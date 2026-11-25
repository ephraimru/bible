// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verse_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VerseModel _$VerseModelFromJson(Map<String, dynamic> json) => _VerseModel(
  id: json['id'] as String,
  reference: json['reference'] as String,
  text: json['text'] as String,
  book: json['book'] as String,
  chapter: (json['chapter'] as num).toInt(),
  verse: (json['verse'] as num).toInt(),
  translation: json['translation'] as String?,
  imageUrl: json['imageUrl'] as String?,
  backgroundImageUrl: json['backgroundImageUrl'] as String?,
  likes: (json['likes'] as num?)?.toInt() ?? 0,
  saves: (json['saves'] as num?)?.toInt() ?? 0,
  likedBy:
      (json['likedBy'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  savedBy:
      (json['savedBy'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  themeColor: json['themeColor'] as String? ?? null,
  date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  isDailyVerse: json['isDailyVerse'] as bool? ?? false,
  author: json['author'] as String? ?? null,
  reflection: json['reflection'] as String? ?? null,
);

Map<String, dynamic> _$VerseModelToJson(_VerseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'reference': instance.reference,
      'text': instance.text,
      'book': instance.book,
      'chapter': instance.chapter,
      'verse': instance.verse,
      'translation': instance.translation,
      'imageUrl': instance.imageUrl,
      'backgroundImageUrl': instance.backgroundImageUrl,
      'likes': instance.likes,
      'saves': instance.saves,
      'likedBy': instance.likedBy,
      'savedBy': instance.savedBy,
      'tags': instance.tags,
      'themeColor': instance.themeColor,
      'date': instance.date?.toIso8601String(),
      'isDailyVerse': instance.isDailyVerse,
      'author': instance.author,
      'reflection': instance.reflection,
    };

_DailyVerseModel _$DailyVerseModelFromJson(Map<String, dynamic> json) =>
    _DailyVerseModel(
      verse: VerseModel.fromJson(json['verse'] as Map<String, dynamic>),
      date: DateTime.parse(json['date'] as String),
      backgroundImageUrl: json['backgroundImageUrl'] as String?,
      themeColor: json['themeColor'] as String?,
      reflection: json['reflection'] as String?,
      author: json['author'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
    );

Map<String, dynamic> _$DailyVerseModelToJson(_DailyVerseModel instance) =>
    <String, dynamic>{
      'verse': instance.verse,
      'date': instance.date.toIso8601String(),
      'backgroundImageUrl': instance.backgroundImageUrl,
      'themeColor': instance.themeColor,
      'reflection': instance.reflection,
      'author': instance.author,
      'tags': instance.tags,
    };

_BibleBook _$BibleBookFromJson(Map<String, dynamic> json) => _BibleBook(
  name: json['name'] as String,
  abbreviation: json['abbreviation'] as String,
  chapters: (json['chapters'] as num).toInt(),
  testament: (json['testament'] as num).toInt(),
  order: (json['order'] as num).toInt(),
);

Map<String, dynamic> _$BibleBookToJson(_BibleBook instance) =>
    <String, dynamic>{
      'name': instance.name,
      'abbreviation': instance.abbreviation,
      'chapters': instance.chapters,
      'testament': instance.testament,
      'order': instance.order,
    };

_BibleChapter _$BibleChapterFromJson(Map<String, dynamic> json) =>
    _BibleChapter(
      book: json['book'] as String,
      chapter: (json['chapter'] as num).toInt(),
      verses: (json['verses'] as List<dynamic>)
          .map((e) => VerseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalVerses: (json['totalVerses'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$BibleChapterToJson(_BibleChapter instance) =>
    <String, dynamic>{
      'book': instance.book,
      'chapter': instance.chapter,
      'verses': instance.verses,
      'totalVerses': instance.totalVerses,
    };

_VerseSearchResult _$VerseSearchResultFromJson(Map<String, dynamic> json) =>
    _VerseSearchResult(
      verses: (json['verses'] as List<dynamic>)
          .map((e) => VerseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num).toInt(),
      query: json['query'] as String,
      hasMore: json['hasMore'] as bool? ?? false,
    );

Map<String, dynamic> _$VerseSearchResultToJson(_VerseSearchResult instance) =>
    <String, dynamic>{
      'verses': instance.verses,
      'totalCount': instance.totalCount,
      'query': instance.query,
      'hasMore': instance.hasMore,
    };
