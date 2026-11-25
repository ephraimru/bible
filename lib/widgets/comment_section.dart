import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/theme.dart';
import '../models/blog_model.dart';
import '../services/auth_service.dart';
import '../services/community_service.dart';
import '../services/moderation_service.dart';
import 'report_dialog.dart';

/// Live comments on a blog post, with a box to add one.
class CommentSection extends ConsumerStatefulWidget {
  final String postId;

  /// The post's author may remove any comment on their post.
  final String? postAuthorId;

  const CommentSection({super.key, required this.postId, this.postAuthorId});

  @override
  ConsumerState<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends ConsumerState<CommentSection> {
  List<BlogCommentModel> _comments = [];
  bool _isLoading = true;
  final _commentController = TextEditingController();
  
  bool _isSending = false;

  StreamSubscription<List<BlogCommentModel>>? _sub;

  @override
  void initState() {
    super.initState();
    _sub = ref.read(communityServiceProvider).watchComments(widget.postId).listen(
      (comments) {
        if (!mounted) return;
        final blocked = ref.read(currentUserProvider)?.blockedUserIds ?? const [];
        setState(() {
          _comments = comments.where((c) => !blocked.contains(c.authorId)).toList();
          _isLoading = false;
        });
      },
      onError: (Object e) {
        if (mounted) setState(() => _isLoading = false);
      },
    );
  }

  @override
  void dispose() {
    _sub?.cancel();
    _commentController.dispose();
    super.dispose();
  }

  void _toast(String message, {bool error = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: error ? Colors.red : null),
    );
  }

  Future<void> _sendComment() async {
    final text = _commentController.text.trim();
    final user = ref.read(currentUserProvider);
    if (text.isEmpty || user == null) return;
    if (text.length > CommunityService.maxCommentLength) {
      _toast('Comments can be up to ${CommunityService.maxCommentLength} characters.', error: true);
      return;
    }

    setState(() => _isSending = true);
    try {
      final moderation = await ref.read(moderationServiceProvider).moderateBlogComment(
            content: text,
            authorId: user.id,
            postId: widget.postId,
          );
      if (!moderation.isAllowed) {
        _toast('Your comment was blocked: ${moderation.reason}', error: true);
        return;
      }
      await ref.read(communityServiceProvider).addComment(
            postId: widget.postId,
            author: user,
            content: text,
          );
      _commentController.clear();
    } catch (e) {
      _toast('Could not post your comment. Check your connection.', error: true);
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  Future<void> _deleteComment(BlogCommentModel comment) async {
    try {
      await ref.read(communityServiceProvider).deleteComment(widget.postId, comment.id);
    } catch (_) {
      _toast('Could not delete the comment.', error: true);
    }
  }

  Future<void> _reportComment(BlogCommentModel comment) async {
    final uid = ref.read(authServiceProvider).currentUserId;
    if (uid == null) return;
    final reason = await showReportDialog(context);
    if (reason == null) return;
    try {
      await ref.read(communityServiceProvider).report(
            reporterId: uid,
            contentPath: CommunityService.commentPath(widget.postId, comment.id),
            authorId: comment.authorId,
            reason: reason,
            excerpt: comment.content,
          );
      _toast('Thank you. The comment was reported to the admin.');
    } catch (_) {
      _toast('Could not send the report.', error: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Section header
        Row(
          children: [
            const Icon(Icons.comment_outlined, color: AppTheme.primaryColor),
            const SizedBox(width: AppTheme.sm),
            Text(
              'Comments (${_comments.length})',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        
        const SizedBox(height: AppTheme.md),
        
        // Comments list
        _buildCommentsList(context),
        
        const SizedBox(height: AppTheme.md),
        
        // Comment input
        _buildCommentInput(context),
      ],
    );
  }

  Widget _buildCommentsList(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    
    if (_comments.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: AppTheme.lg),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: AppTheme.mediumBorderRadius,
        ),
        child: Center(
          child: Column(
            children: [
              const Icon(
                Icons.comment_outlined,
                size: 32,
                color: Colors.grey,
              ),
              const SizedBox(height: AppTheme.sm),
              Text(
                'No comments yet',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                    ),
              ),
              const SizedBox(height: AppTheme.sm),
              Text(
                'Be the first to comment!',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                    ),
              ),
            ],
          ),
        ),
      );
    }
    
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _comments.length,
      itemBuilder: (context, index) {
        final comment = _comments[index];
        return _buildCommentItem(context, comment);
      },
    );
  }

  Widget _buildCommentItem(BuildContext context, BlogCommentModel comment) {
    final userId = ref.read(authServiceProvider).currentUserId;
    final isCurrentUser = comment.authorId == userId;
    
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: AppTheme.mediumBorderRadius,
      ),
      margin: const EdgeInsets.only(bottom: AppTheme.md),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Comment header
            Row(
              children: [
                // Author avatar
                if (comment.authorPhotoUrl != null)
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(comment.authorPhotoUrl!),
                  )
                else
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: AppTheme.primaryColor,
                    child: Text(
                      comment.authorName?.isNotEmpty ?? false
                          ? comment.authorName![0].toUpperCase()
                          : 'A',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                
                const SizedBox(width: AppTheme.sm),
                
                // Author name
                Expanded(
                  child: Text(
                    comment.authorName ?? 'Anonymous',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                
                // Delete: the comment's author or the post's author
                if (isCurrentUser || widget.postAuthorId == userId)
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert, size: 18),
                    onSelected: (_) => _deleteComment(comment),
                    itemBuilder: (context) => const [
                      PopupMenuItem(value: 'delete', child: Text('Delete comment')),
                    ],
                  ),
              ],
            ),
            
            const SizedBox(height: AppTheme.sm),
            
            // Comment content
            Text(
              comment.content,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            
            const SizedBox(height: AppTheme.sm),
            
            // Comment metadata
            Row(
              children: [
                // Report someone else's comment
                if (!isCurrentUser)
                  IconButton(
                    icon: const Icon(Icons.flag_outlined, size: 16),
                    tooltip: 'Report',
                    onPressed: () => _reportComment(comment),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                
                const Spacer(),
                
                // Timestamp
                Text(
                  _formatDate(comment.createdAt ?? DateTime.now()),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentInput(BuildContext context) {
    final userId = ref.read(authServiceProvider).currentUserId;
    
    if (userId == null) {
      return Container(
        padding: const EdgeInsets.all(AppTheme.md),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: AppTheme.mediumBorderRadius,
        ),
        child: Center(
          child: Text(
            'Please log in to comment',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      );
    }
    
    return Container(
      padding: const EdgeInsets.all(AppTheme.md),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: AppTheme.mediumBorderRadius,
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          // User avatar
          const CircleAvatar(
            radius: 16,
            backgroundColor: AppTheme.primaryColor,
            child: Icon(Icons.person, color: Colors.white, size: 16),
          ),
          
          const SizedBox(width: AppTheme.md),
          
          // Comment input
          Expanded(
            child: TextField(
              controller: _commentController,
              decoration: const InputDecoration(
                hintText: 'Write a comment...',
                border: InputBorder.none,
              ),
              maxLines: 3,
              minLines: 1,
              onSubmitted: (_) => _sendComment(),
            ),
          ),
          
          const SizedBox(width: AppTheme.md),
          
          // Send button
          IconButton(
            icon: _isSending
                ? const CircularProgressIndicator()
                : const Icon(Icons.send),
            tooltip: 'Post comment',
            onPressed: _isSending ? null : _sendComment,
            style: IconButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(AppTheme.sm),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    
    if (diff.inDays > 7) {
      return '${diff.inDays} days ago';
    } else if (diff.inDays > 0) {
      return '${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago';
    } else if (diff.inHours > 0) {
      return '${diff.inHours} hour${diff.inHours > 1 ? 's' : ''} ago';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes} minute${diff.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }
}
