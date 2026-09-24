import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/theme.dart';
import '../../models/blog_model.dart';
import '../../models/user_model.dart';
import '../../services/auth_service.dart';
import '../../services/database_service.dart';
import '../../services/moderation_service.dart';

class CreatePostScreen extends ConsumerStatefulWidget {
  const CreatePostScreen({super.key});

  @override
  ConsumerState<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _excerptController = TextEditingController();
  
  bool _isLoading = false;
  String? _errorMessage;
  BlogCategory? _selectedCategory;
  List<String> _selectedTags = [];
  
  // Available tags
  final _availableTags = [
    'Faith',
    'Prayer',
    'Bible Study',
    'Devotional',
    'Testimony',
    'Encouragement',
    'Worship',
    'Salvation',
    'Grace',
    'Love',
    'Hope',
    'Peace',
    'Joy',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _excerptController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCategory == null) {
      setState(() {
        _errorMessage = 'Please select a category';
      });
      return;
    }
    
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    
    try {
      final user = ref.read(currentUserProvider).value;
      if (user == null) {
        throw Exception('User not logged in');
      }
      
      // Moderate content
      final moderationResult = await ref.read(moderationServiceProvider).moderateBlogPost(
            title: _titleController.text,
            content: _contentController.text,
            authorId: user.id,
          );
      
      if (!moderationResult.isAllowed) {
        setState(() {
          _errorMessage = 'Your post contains inappropriate content: ${moderationResult.reason}';
        });
        return;
      }
      
      // Create post
      final post = BlogPostModel(
        id: '',
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
        authorId: user.id,
        authorName: user.displayName,
        authorPhotoUrl: user.photoUrl,
        category: _selectedCategory!,
        tags: _selectedTags,
        excerpt: _excerptController.text.trim().isEmpty
            ? _contentController.text.trim().length > 150
                ? '${_contentController.text.trim().substring(0, 150)}...'
                : _contentController.text.trim()
            : _excerptController.text.trim(),
        readingTime: (_contentController.text.length / 200).ceil(),
        publishedAt: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      await ref.read(databaseServiceProvider).createBlogPost(post);
      
      if (mounted) {
        context.go('/blog');
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider).value;
    
    // Check if user can post
    if (user != null && !(user.role == UserRole.bishop || user.canPostOnBlog)) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Create Post'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.lock_outline,
                size: 64,
                color: Colors.grey,
              ),
              const SizedBox(height: AppTheme.md),
              Text(
                'Access Denied',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppTheme.sm),
              Text(
                'You need to be a Bishop or have blog posting permissions to create posts',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppTheme.lg),
              ElevatedButton(
                onPressed: () => context.go('/premium'),
                child: const Text('Upgrade to Bishop'),
              ),
            ],
          ),
        ),
      );
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _submit,
            child: const Text(
              'Publish',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.lg),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title field
              TextFormField(
                controller: _titleController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  hintText: 'Enter a catchy title for your post',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  if (value.length < 5) {
                    return 'Title must be at least 5 characters';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: AppTheme.md),
              
              // Category selector
              DropdownButtonFormField<BlogCategory>(
                value: _selectedCategory,
                hint: const Text('Select Category'),
                items: BlogCategory.values.map((category) {
                  return DropdownMenuItem<BlogCategory>(
                    value: category,
                    child: Text(category.displayName),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: AppTheme.md),
              
              // Tags selector
              Wrap(
                spacing: AppTheme.sm,
                runSpacing: AppTheme.sm,
                children: _availableTags.map((tag) {
                  final isSelected = _selectedTags.contains(tag);
                  return FilterChip(
                    label: Text(tag),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedTags.add(tag);
                        } else {
                          _selectedTags.remove(tag);
                        }
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: AppTheme.mediumBorderRadius,
                    ),
                  );
                }).toList(),
              ),
              
              const SizedBox(height: AppTheme.md),
              
              // Excerpt field
              TextFormField(
                controller: _excerptController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Excerpt (Optional)',
                  hintText: 'A short summary of your post (will be shown in previews)',
                  border: OutlineInputBorder(),
                ),
              ),
              
              const SizedBox(height: AppTheme.md),
              
              // Content field
              TextFormField(
                controller: _contentController,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
                maxLines: 10,
                decoration: const InputDecoration(
                  labelText: 'Content',
                  hintText: 'Write your post content here...',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter content';
                  }
                  if (value.length < 50) {
                    return 'Content must be at least 50 characters';
                  }
                  return null;
                },
                onFieldSubmitted: (_) => _submit(),
              ),
              
              // Error message
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: AppTheme.sm),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              
              const SizedBox(height: AppTheme.md),
              
              // Guidelines
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: AppTheme.mediumBorderRadius,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Posting Guidelines',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: AppTheme.sm),
                      Text(
                        'Please ensure your post:' ,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: AppTheme.sm),
                      Text(
                        '• Focuses on the Gospel and faith-related topics',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        '• Does not contain political content',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        '• Does not contain offensive or inappropriate language',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        '• Is respectful to all beliefs and denominations',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: AppTheme.lg),
              
              // Publish button
              ElevatedButton(
                onPressed: _isLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: AppTheme.md),
                  shape: RoundedRectangleBorder(
                    borderRadius: AppTheme.mediumBorderRadius,
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : const Text('Publish Post'),
              ),
            ],
          ),
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
