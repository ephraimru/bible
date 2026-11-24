// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BlogPostModel _$BlogPostModelFromJson(Map<String, dynamic> json) =>
    _BlogPostModel(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      authorId: json['authorId'] as String,
      authorName: json['authorName'] as String?,
      authorPhotoUrl: json['authorPhotoUrl'] as String?,
      category: $enumDecode(_$BlogCategoryEnumMap, json['category']),
      status:
          $enumDecodeNullable(_$BlogPostStatusEnumMap, json['status']) ??
          BlogPostStatus.published,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      coverImageUrl: json['coverImageUrl'] as String?,
      views: (json['views'] as num?)?.toInt() ?? 0,
      likes: (json['likes'] as num?)?.toInt() ?? 0,
      comments: (json['comments'] as num?)?.toInt() ?? 0,
      likedBy:
          (json['likedBy'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      bookmarkedBy:
          (json['bookmarkedBy'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      publishedAt: json['publishedAt'] == null
          ? null
          : DateTime.parse(json['publishedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      isFeatured: json['isFeatured'] as bool? ?? false,
      isPremium: json['isPremium'] as bool? ?? false,
      excerpt: json['excerpt'] as String?,
      readingTime: (json['readingTime'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$BlogPostModelToJson(_BlogPostModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'authorId': instance.authorId,
      'authorName': instance.authorName,
      'authorPhotoUrl': instance.authorPhotoUrl,
      'category': _$BlogCategoryEnumMap[instance.category]!,
      'status': _$BlogPostStatusEnumMap[instance.status]!,
      'tags': instance.tags,
      'coverImageUrl': instance.coverImageUrl,
      'views': instance.views,
      'likes': instance.likes,
      'comments': instance.comments,
      'likedBy': instance.likedBy,
      'bookmarkedBy': instance.bookmarkedBy,
      'publishedAt': instance.publishedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'isFeatured': instance.isFeatured,
      'isPremium': instance.isPremium,
      'excerpt': instance.excerpt,
      'readingTime': instance.readingTime,
    };

const _$BlogCategoryEnumMap = {
  BlogCategory.devotionals: 'devotionals',
  BlogCategory.sermons: 'sermons',
  BlogCategory.testimonies: 'testimonies',
  BlogCategory.bibleStudy: 'bibleStudy',
  BlogCategory.faithJourney: 'faithJourney',
  BlogCategory.gospelReflections: 'gospelReflections',
};

const _$BlogPostStatusEnumMap = {
  BlogPostStatus.draft: 'draft',
  BlogPostStatus.published: 'published',
  BlogPostStatus.archived: 'archived',
  BlogPostStatus.deleted: 'deleted',
};

_BlogCommentModel _$BlogCommentModelFromJson(Map<String, dynamic> json) =>
    _BlogCommentModel(
      id: json['id'] as String,
      postId: json['postId'] as String,
      authorId: json['authorId'] as String,
      authorName: json['authorName'] as String?,
      authorPhotoUrl: json['authorPhotoUrl'] as String?,
      content: json['content'] as String,
      likes:
          (json['likes'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      replies:
          (json['replies'] as List<dynamic>?)
              ?.map((e) => BlogCommentModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      isEdited: json['isEdited'] as bool? ?? false,
      isDeleted: json['isDeleted'] as bool? ?? false,
      parentCommentId: json['parentCommentId'] as String?,
    );

Map<String, dynamic> _$BlogCommentModelToJson(_BlogCommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'authorId': instance.authorId,
      'authorName': instance.authorName,
      'authorPhotoUrl': instance.authorPhotoUrl,
      'content': instance.content,
      'likes': instance.likes,
      'replies': instance.replies.map((e) => e.toJson()).toList(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'isEdited': instance.isEdited,
      'isDeleted': instance.isDeleted,
      'parentCommentId': instance.parentCommentId,
    };

_BlogCategoryModel _$BlogCategoryModelFromJson(Map<String, dynamic> json) =>
    _BlogCategoryModel(
      category: $enumDecode(_$BlogCategoryEnumMap, json['category']),
      displayName: json['displayName'] as String,
      icon: json['icon'] as String,
      description: json['description'] as String,
      color: json['color'] as String,
      postCount: (json['postCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$BlogCategoryModelToJson(_BlogCategoryModel instance) =>
    <String, dynamic>{
      'category': _$BlogCategoryEnumMap[instance.category]!,
      'displayName': instance.displayName,
      'icon': instance.icon,
      'description': instance.description,
      'color': instance.color,
      'postCount': instance.postCount,
    };

_BlogSearchResult _$BlogSearchResultFromJson(Map<String, dynamic> json) =>
    _BlogSearchResult(
      posts: (json['posts'] as List<dynamic>)
          .map((e) => BlogPostModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num).toInt(),
      query: json['query'] as String,
      hasMore: json['hasMore'] as bool? ?? false,
      categoryFilter: $enumDecodeNullable(
        _$BlogCategoryEnumMap,
        json['categoryFilter'],
      ),
      authorFilter: json['authorFilter'] as String?,
    );

Map<String, dynamic> _$BlogSearchResultToJson(_BlogSearchResult instance) =>
    <String, dynamic>{
      'posts': instance.posts.map((e) => e.toJson()).toList(),
      'totalCount': instance.totalCount,
      'query': instance.query,
      'hasMore': instance.hasMore,
      'categoryFilter': _$BlogCategoryEnumMap[instance.categoryFilter],
      'authorFilter': instance.authorFilter,
    };
