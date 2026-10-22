
import 'package:freezed_annotation/freezed_annotation.dart';

part 'verse_model.freezed.dart';
part 'verse_model.g.dart';

@freezed
class VerseModel with _$VerseModel {
  const factory VerseModel({
    required String id,
    required String reference,
    required String text,
    required String book,
    required int chapter,
    required int verse,
    String? translation,
    String? imageUrl,
    String? backgroundImageUrl,
    @Default(0) int likes,
    @Default(0) int saves,
    @Default([]) List<String> likedBy,
    @Default([]) List<String> savedBy,
    @Default([]) List<String> tags,
    @Default(null) String? themeColor,
    @Default(null) DateTime? date,
    @Default(false) bool isDailyVerse,
    @Default(null) String? author,
    @Default(null) String? reflection,
  }) = _VerseModel;

  factory VerseModel.fromJson(Map<String, dynamic> json) =>
      _$VerseModelFromJson(json);
}

/// Daily verse model with additional metadata
@freezed
class DailyVerseModel with _$DailyVerseModel {
  const factory DailyVerseModel({
    required VerseModel verse,
    required DateTime date,
    String? backgroundImageUrl,
    String? themeColor,
    String? reflection,
    String? author,
    @Default([]) List<String> tags,
  }) = _DailyVerseModel;

  factory DailyVerseModel.fromJson(Map<String, dynamic> json) =>
      _$DailyVerseModelFromJson(json);
}
}

/// Bible book model
@freezed
class BibleBook with _$BibleBook {
  const factory BibleBook({
    required String name,
    required String abbreviation,
    required int chapters,
    required int testament, // 1 = Old Testament, 2 = New Testament
    required int order,
  }) = _BibleBook;

  factory BibleBook.fromJson(Map<String, dynamic> json) =>
      _$BibleBookFromJson(json);
}

/// Bible chapter model
@freezed
class BibleChapter with _$BibleChapter {
  const factory BibleChapter({
    required String book,
    required int chapter,
    required List<VerseModel> verses,
    @Default(0) int totalVerses,
  }) = _BibleChapter;

  factory BibleChapter.fromJson(Map<String, dynamic> json) =>
      _$BibleChapterFromJson(json);
}

/// Search result for verses
@freezed
class VerseSearchResult with _$VerseSearchResult {
  const factory VerseSearchResult({
    required List<VerseModel> verses,
    required int totalCount,
    required String query,
    @Default(false) bool hasMore,
  }) = _VerseSearchResult;

  factory VerseSearchResult.fromJson(Map<String, dynamic> json) =>
      _$VerseSearchResultFromJson(json);
}
