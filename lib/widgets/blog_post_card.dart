import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../config/theme.dart';
import '../models/blog_model.dart';

class BlogPostCard extends StatelessWidget {
  final BlogPostModel post;
  final VoidCallback? onTap;

  const BlogPostCard({
    super.key,
    required this.post,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: AppTheme.mediumBorderRadius,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppTheme.mediumBorderRadius,
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Author and date
              Row(
                children: [
                  // Author avatar
                  if (post.authorPhotoUrl != null)
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(post.authorPhotoUrl!),
                    )
                  else
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: AppTheme.primaryColor,
                      child: Text(
                        post.authorName?.isNotEmpty ?? false
                            ? post.authorName![0].toUpperCase()
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
                      post.authorName ?? 'Anonymous',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  
                  // Date
                  Text(
                    DateFormat('MMM dd').format(post.publishedAt ?? DateTime.now()),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
              
              const SizedBox(height: AppTheme.md),
              
              // Title
              Text(
                post.title,
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              
              const SizedBox(height: AppTheme.sm),
              
              // Excerpt
              if (post.excerpt != null && post.excerpt!.isNotEmpty)
                Text(
                  post.excerpt!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              
              const SizedBox(height: AppTheme.md),
              
              // Post metadata
              Row(
                children: [
                  // Category
                  Chip(
                    label: Text(post.category.displayName),
                    backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                    labelStyle: TextStyle(
                      color: AppTheme.primaryColor,
                      fontSize: 10,
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.zero,
                  ),
                  
                  const SizedBox(width: AppTheme.sm),
                  
                  // Reading time
                  Row(
                    children: [
                      const Icon(Icons.timer_outlined, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        '${post.readingTime} min',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(width: AppTheme.sm),
                  
                  // Views
                  Row(
                    children: [
                      const Icon(Icons.remove_red_eye_outlined, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        '${post.views}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                    ],
                  ),
                  
                  const Spacer(),
                  
                  // Featured badge
                  if (post.isFeatured)
                    Chip(
                      label: const Text('Featured'),
                      backgroundColor: Colors.amber.withOpacity(0.1),
                      labelStyle: const TextStyle(
                        color: Colors.amber,
                        fontSize: 10,
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: EdgeInsets.zero,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
