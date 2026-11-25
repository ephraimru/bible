import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../config/theme.dart';
import '../../models/blog_model.dart';
import '../../services/auth_service.dart';
import '../../services/community_service.dart';
import '../../services/local_storage_service.dart';
import '../../widgets/report_dialog.dart';
import '../../widgets/comment_section.dart';

class PostDetailScreen extends ConsumerStatefulWidget {
  final String postId;

  const PostDetailScreen({super.key, required this.postId});

  @override
  ConsumerState<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends ConsumerState<PostDetailScreen> {
  BlogPostModel? _post;
  bool _isLoading = true;
  bool _isBookmarked = false;
  bool _likeBusy = false;
  StreamSubscription<BlogPostModel?>? _sub;
  final _commentsKey = GlobalKey();

  String? get _uid => ref.read(authServiceProvider).currentUserId;
  bool get _isLiked => _uid != null && (_post?.likedBy.contains(_uid) ?? false);

  @override
  void initState() {
    super.initState();
    final user = ref.read(currentUserProvider);
    _isBookmarked = user?.bookmarkedBlogPostIds.contains(widget.postId) ?? false;
    _sub = ref.read(communityServiceProvider).watchPost(widget.postId).listen(
      (post) {
        if (!mounted) return;
        setState(() {
          _post = post;
          _isLoading = false;
        });
      },
      onError: (Object e) {
        if (mounted) setState(() => _isLoading = false);
      },
    );
    // Count the view (best effort).
    ref.read(communityServiceProvider).recordView(widget.postId).catchError((_) {});
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  void _toast(String message) {
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _toggleLike() async {
    final uid = _uid;
    if (uid == null || _post == null || _likeBusy) return;
    setState(() => _likeBusy = true);
    try {
      await ref.read(communityServiceProvider).setPostLiked(_post!.id, uid, !_isLiked);
    } catch (_) {
      _toast('Could not update your like. Check your connection.');
    } finally {
      if (mounted) setState(() => _likeBusy = false);
    }
  }

  /// Bookmarks are personal, so they stay on this device.
  Future<void> _toggleBookmark() async {
    final uid = _uid;
    if (uid == null || _post == null) return;
    final storage = ref.read(localStorageServiceProvider);
    if (_isBookmarked) {
      await storage.removeBookmarkBlogPost(_post!.id, uid);
    } else {
      await storage.bookmarkBlogPost(_post!.id, uid);
    }
    setState(() => _isBookmarked = !_isBookmarked);
  }

  Future<void> _copyPost() async {
    final post = _post;
    if (post == null) return;
    await Clipboard.setData(ClipboardData(
      text: '${post.title}\n\n${post.content}\n\n— ${post.authorName ?? 'Faith Mission'}',
    ));
    _toast('Post copied to clipboard');
  }

  Future<void> _report() async {
    final uid = _uid;
    final post = _post;
    if (uid == null || post == null) return;
    final reason = await showReportDialog(context);
    if (reason == null) return;
    try {
      await ref.read(communityServiceProvider).report(
            reporterId: uid,
            contentPath: CommunityService.postPath(post.id),
            authorId: post.authorId,
            reason: reason,
            excerpt: post.title,
          );
      _toast('Thank you. The post was reported to the admin.');
    } catch (_) {
      _toast('Could not send the report. Check your connection.');
    }
  }

  Future<void> _delete() async {
    final post = _post;
    if (post == null) return;
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete post?'),
        content: const Text('This removes the post for everyone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete')),
        ],
      ),
    );
    if (ok != true) return;
    try {
      await ref.read(communityServiceProvider).deletePost(post.id);
      if (mounted) context.go('/blog');
    } catch (_) {
      _toast('Could not delete the post.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isAuthor = _post != null && _post!.authorId == _uid;
    return Scaffold(
      appBar: AppBar(
        title: Text(_post?.title ?? 'Post'),
        actions: [
          if (_post != null)
            PopupMenuButton<String>(
              onSelected: (v) => v == 'delete' ? _delete() : _report(),
              itemBuilder: (context) => [
                if (isAuthor)
                  const PopupMenuItem(value: 'delete', child: Text('Delete post'))
                else
                  const PopupMenuItem(value: 'report', child: Text('Report post')),
              ],
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
          CommentSection(key: _commentsKey, postId: widget.postId, postAuthorId: _post!.authorId),
          
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
        Text('${_post!.likes}'),
        
        const SizedBox(width: AppTheme.md),
        
        // Comment button
        IconButton.filledTonal(
          icon: const Icon(Icons.comment_outlined),
          tooltip: 'Comments',
          onPressed: () {
            final target = _commentsKey.currentContext;
            if (target != null) {
              Scrollable.ensureVisible(target, duration: const Duration(milliseconds: 300));
            }
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
        
        // Copy button
        IconButton.filledTonal(
          icon: const Icon(Icons.copy_outlined),
          tooltip: 'Copy post',
          onPressed: _copyPost,
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
            
          ],
        ),
      ),
    );
  }
}

// Category extension for display names
