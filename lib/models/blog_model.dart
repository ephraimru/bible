
import 'package:freezed_annotation/freezed_annotation.dart';

part 'blog_model.freezed.dart';
part 'blog_model.g.dart';

/// Blog post category
enum BlogCategory {
  devotionals,
  sermons,
  testimonies,
  bibleStudy,
  faithJourney,
  gospelReflections,
}

/// Blog post status
enum BlogPostStatus {
  draft,
  published,
  archived,
  deleted,
}

@freezed
abstract class BlogPostModel with _$BlogPostModel {
  const factory BlogPostModel({
    required String id,
    required String title,
    required String content,
    required String authorId,
    String? authorName,
    String? authorPhotoUrl,
    required BlogCategory category,
    @Default(BlogPostStatus.published) BlogPostStatus status,
    @Default([]) List<String> tags,
    String? coverImageUrl,
    @Default(0) int views,
    @Default(0) int likes,
    @Default(0) int comments,
    @Default([]) List<String> likedBy,
    @Default([]) List<String> bookmarkedBy,
    @Default([]) List<BlogCommentModel> comments,
    @Default(null) DateTime? publishedAt,
    @Default(null) DateTime? createdAt,
    @Default(null) DateTime? updatedAt,
    @Default(false) bool isFeatured,
    @Default(false) bool isPremium,
    String? excerpt,
    @Default(0) int readingTime, // in minutes
  }) = _BlogPostModel;

  factory BlogPostModel.fromJson(Map<String, dynamic> json) =>
      _$BlogPostModelFromJson(json);

}

/// Blog comment model
@freezed
abstract class BlogCommentModel with _$BlogCommentModel {
  const factory BlogCommentModel({
    required String id,
    required String postId,
    required String authorId,
    String? authorName,
    String? authorPhotoUrl,
    required String content,
    @Default([]) List<String> likes,
    @Default([]) List<BlogCommentModel> replies,
    @Default(null) DateTime? createdAt,
    @Default(null) DateTime? updatedAt,
    @Default(false) bool isEdited,
    @Default(false) bool isDeleted,
    String? parentCommentId,
  }) = _BlogCommentModel;

  factory BlogCommentModel.fromJson(Map<String, dynamic> json) =>
      _$BlogCommentModelFromJson(json);

}

/// Blog category model with metadata
@freezed
abstract class BlogCategoryModel with _$BlogCategoryModel {
  const factory BlogCategoryModel({
    required BlogCategory category,
    required String displayName,
    required String icon,
    required String description,
    required String color,
    @Default(0) int postCount,
  }) = _BlogCategoryModel;

  factory BlogCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$BlogCategoryModelFromJson(json);

}

/// Blog search result
@freezed
abstract class BlogSearchResult with _$BlogSearchResult {
  const factory BlogSearchResult({
    required List<BlogPostModel> posts,
    required int totalCount,
    required String query,
    @Default(false) bool hasMore,
    BlogCategory? categoryFilter,
    String? authorFilter,
  }) = _BlogSearchResult;

  factory BlogSearchResult.fromJson(Map<String, dynamic> json) =>
      _$BlogSearchResultFromJson(json);

}
