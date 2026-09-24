import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../config/theme.dart';
import '../../models/blog_model.dart';
import '../../models/user_model.dart';
import '../../services/auth_service.dart';
import '../../services/database_service.dart';
import '../widgets/comment_section.dart';

class PostDetailScreen extends ConsumerStatefulWidget {
  final String postId;

  const PostDetailScreen({super.key, required this.postId});

  @override
  ConsumerState<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends ConsumerState<PostDetailScreen> {
  BlogPostModel? _post;
  bool _isLoading = true;
  bool _isLiked = false;
  bool _isBookmarked = false;
  int _likeCount = 0;

  @override
  void initState() {
    super.initState();
    _loadPost();
  }

  Future<void> _loadPost() async {
    try {
      final post = await ref.read(databaseServiceProvider).getBlogPost(widget.postId);
      if (post != null) {
        setState(() {
          _post = post;
          _likeCount = post.likes;
        });
        
        // Check if user has liked or bookmarked this post
        final userId = ref.read(authServiceProvider).currentUserId;
        if (userId != null) {
          final user = await ref.read(databaseServiceProvider).getUser(userId);
          if (user != null) {
            setState(() {
              _isLiked = user.likedVerseIds.contains(post.id);
              _isBookmarked = user.bookmarkedBlogPostIds.contains(post.id);
            });
          }
        }
        
        // Increment view count
        await ref.read(databaseServiceProvider).incrementBlogPostViews(widget.postId);
      }
    } catch (e) {
      // Handle error
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _toggleLike() async {
    final userId = ref.read(authServiceProvider).currentUserId;
    if (userId == null || _post == null) return;
    
    final databaseService = ref.read(databaseServiceProvider);
    
    if (_isLiked) {
      await databaseService.unlikeBlogPost(_post!.id, userId);
      setState(() {
        _isLiked = false;
        _likeCount--;
      });
    } else {
      await databaseService.likeBlogPost(_post!.id, userId);
      setState(() {
        _isLiked = true;
        _likeCount++;
      });
    }
  }

  Future<void> _toggleBookmark() async {
    final userId = ref.read(authServiceProvider).currentUserId;
    if (userId == null || _post == null) return;
    
    final databaseService = ref.read(databaseServiceProvider);
    
    if (_isBookmarked) {
      await databaseService.removeBookmarkBlogPost(_post!.id, userId);
    } else {
      await databaseService.bookmarkBlogPost(_post!.id, userId);
    }
    
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_post?.title ?? 'Post'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              // Share post
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _post == null
              ? _buildErrorView(context)
              : _buildPostDetailView(context),
    );
  }

  Widget _buildErrorView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.article_outlined,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: AppTheme.md),
          Text(
            'Post not found',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppTheme.sm),
          Text(
            'The post you are looking for could not be found',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
          ),
          const SizedBox(height: AppTheme.lg),
          ElevatedButton(
            onPressed: () => context.go('/blog'),
            child: const Text('Back to Blog'),
          ),
        ],
      ),
    );
  }

  Widget _buildPostDetailView(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Post header
          _buildPostHeader(context),
          
          const SizedBox(height: AppTheme.lg),
          
          // Post content
          _buildPostContent(context),
          
          const SizedBox(height: AppTheme.lg),
          
          // Post actions
          _buildPostActions(context),
          
          const SizedBox(height: AppTheme.lg),
          
          // Post metadata
          _buildPostMetadata(context),
          
          const SizedBox(height: AppTheme.lg),
          
          // Author info
          _buildAuthorInfo(context),
          
          const SizedBox(height: AppTheme.lg),
          
          // Comments section
          CommentSection(postId: widget.postId),
          
          const SizedBox(height: AppTheme.lg),
        ],
      ),
    );
  }

  Widget _buildPostHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Category badge
        Chip(
          label: Text(_post!.category.displayName),
          backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
          labelStyle: TextStyle(color: AppTheme.primaryColor),
          shape: RoundedRectangleBorder(
            borderRadius: AppTheme.mediumBorderRadius,
          ),
        ),
        
        const SizedBox(height: AppTheme.md),
        
        // Title
        Text(
          _post!.title,
          style: Theme.of(context).textTheme.displaySmall,
        ),
        
        const SizedBox(height: AppTheme.sm),
        
        // Excerpt
        if (_post!.excerpt != null && _post!.excerpt!.isNotEmpty)
          Text(
            _post!.excerpt!,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey,
                ),
          ),
      ],
    );
  }

  Widget _buildPostContent(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: AppTheme.mediumBorderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.lg),
        child: Text(
          _post!.content,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 16,
                height: 1.6,
              ),
        ),
      ),
    );
  }

  Widget _buildPostActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Like button
        IconButton.filledTonal(
          icon: Icon(
            _isLiked ? Icons.favorite : Icons.favorite_outline,
            color: _isLiked ? Colors.red : null,
          ),
          onPressed: _toggleLike,
          style: IconButton.styleFrom(
            backgroundColor: Colors.grey.shade100,
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.md,
              vertical: AppTheme.sm,
            ),
          ),
        ),
        const SizedBox(width: AppTheme.sm),
        Text('$_likeCount'),
        
        const SizedBox(width: AppTheme.md),
        
        // Comment button
        IconButton.filledTonal(
          icon: const Icon(Icons.comment_outlined),
          onPressed: () {
            // Scroll to comments
          },
          style: IconButton.styleFrom(
            backgroundColor: Colors.grey.shade100,
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.md,
              vertical: AppTheme.sm,
            ),
          ),
        ),
        const SizedBox(width: AppTheme.sm),
        Text('${_post!.comments}'),
        
        const SizedBox(width: AppTheme.md),
        
        // Bookmark button
        IconButton.filledTonal(
          icon: Icon(
            _isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
            color: _isBookmarked ? AppTheme.primaryColor : null,
          ),
          onPressed: _toggleBookmark,
          style: IconButton.styleFrom(
            backgroundColor: Colors.grey.shade100,
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.md,
              vertical: AppTheme.sm,
            ),
          ),
        ),
        
        const SizedBox(width: AppTheme.md),
        
        // Share button
        IconButton.filledTonal(
          icon: const Icon(Icons.share_outlined),
          onPressed: () {
            // Share post
          },
          style: IconButton.styleFrom(
            backgroundColor: Colors.grey.shade100,
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.md,
              vertical: AppTheme.sm,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPostMetadata(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Views
        Row(
          children: [
            const Icon(Icons.remove_red_eye_outlined, size: 16),
            const SizedBox(width: AppTheme.sm),
            Text('${_post!.views} views'),
          ],
        ),
        
        const SizedBox(width: AppTheme.md),
        
        // Reading time
        Row(
          children: [
            const Icon(Icons.timer_outlined, size: 16),
            const SizedBox(width: AppTheme.sm),
            Text('${_post!.readingTime} min read'),
          ],
        ),
        
        const SizedBox(width: AppTheme.md),
        
        // Published date
        Row(
          children: [
            const Icon(Icons.calendar_today_outlined, size: 16),
            const SizedBox(width: AppTheme.sm),
            Text(
              DateFormat('MMM dd, yyyy').format(_post!.publishedAt ?? DateTime.now()),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAuthorInfo(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: AppTheme.mediumBorderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.lg),
        child: Row(
          children: [
            // Author avatar
            if (_post!.authorPhotoUrl != null)
              CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(_post!.authorPhotoUrl!),
              )
            else
              CircleAvatar(
                radius: 24,
                backgroundColor: AppTheme.primaryColor,
                child: Text(
                  _post!.authorName?.isNotEmpty ?? false
                      ? _post!.authorName![0].toUpperCase()
                      : 'A',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            
            const SizedBox(width: AppTheme.md),
            
            // Author info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _post!.authorName ?? 'Anonymous',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    'Author',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
            ),
            
            // Follow button (if not current user)
            const Spacer(),
            
            if (_post!.authorId != ref.read(authServiceProvider).currentUserId)
              OutlinedButton(
                onPressed: () {
                  // Follow author
                },
                child: const Text('Follow'),
              ),
          ],
        ),
      ),
    );
  }
}

// Category extension for display names
extension on BlogCategory {
  String get displayName {
    switch (this) {
      case BlogCategory.devotionals:
        return 'Devotionals';
      case BlogCategory.sermons:
        return 'Sermons';
      case BlogCategory.testimonies:
        return 'Testimonies';
      case BlogCategory.bibleStudy:
        return 'Bible Study';
      case BlogCategory.faithJourney:
        return 'Faith Journey';
      case BlogCategory.gospelReflections:
        return 'Gospel Reflections';
    }
  }
}
