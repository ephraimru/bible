import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/theme.dart';
import '../models/blog_model.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/database_service.dart';
import '../services/moderation_service.dart';

class CommentSection extends ConsumerStatefulWidget {
  final String postId;

  const CommentSection({super.key, required this.postId});

  @override
  ConsumerState<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends ConsumerState<CommentSection> {
  List<BlogCommentModel> _comments = [];
  bool _isLoading = true;
  final _commentController = TextEditingController();
  
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _loadComments() async {
    try {
      final comments = await ref.read(databaseServiceProvider).getBlogComments(
            widget.postId,
          );
      
      setState(() {
        _comments = comments;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _sendComment() async {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;
    
    final userId = ref.read(authServiceProvider).currentUserId;
    if (userId == null) return;
    
    setState(() {
      _isSending = true;
    });
    
    try {
      // Moderate comment
      final moderationResult = await ref.read(moderationServiceProvider).moderateBlogComment(
            content: text,
            authorId: userId,
            postId: widget.postId,
          );
      
      if (!moderationResult.isAllowed) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Your comment was blocked: ${moderationResult.reason}'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      
      // Get user info
      final user = ref.read(currentUserProvider).value;
      
      // Create comment
      final comment = BlogCommentModel(
        id: '',
        postId: widget.postId,
        authorId: userId,
        authorName: user?.displayName ?? 'Anonymous',
        authorPhotoUrl: user?.photoUrl,
        content: text,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      await ref.read(databaseServiceProvider).createBlogComment(comment);
      
      // Clear input
      _commentController.clear();
      
      // Add comment to local list
      setState(() {
        _comments.add(comment);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to post comment: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isSending = false;
      });
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
                
                // Comment actions
                if (isCurrentUser)
                  IconButton(
                    icon: const Icon(Icons.more_vert, size: 18),
                    onPressed: () {
                      // Show comment actions
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
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
                // Like button
                IconButton(
                  icon: const Icon(Icons.favorite_outline, size: 16),
                  onPressed: () {
                    // Like comment
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                
                const SizedBox(width: AppTheme.sm),
                
                // Like count
                Text('${comment.likes.length}'),
                
                const SizedBox(width: AppTheme.md),
                
                // Flag button
                IconButton(
                  icon: const Icon(Icons.flag_outlined, size: 16),
                  onPressed: () {
                    // Flag comment
                  },
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
