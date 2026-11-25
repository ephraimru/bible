import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/router.dart';
import '../../config/theme.dart';
import '../../models/blog_model.dart';
import '../../models/user_model.dart';
import '../../services/auth_service.dart';
import '../../services/community_service.dart';
import '../../widgets/blog_post_card.dart';

class BlogScreen extends ConsumerStatefulWidget {
  const BlogScreen({super.key});

  @override
  ConsumerState<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends ConsumerState<BlogScreen> {
  List<BlogPostModel> _posts = [];
  List<BlogPostModel> _filteredPosts = [];
  bool _isLoading = true;
  String? _error;
  BlogCategory? _selectedCategory;
  String _searchQuery = '';
  StreamSubscription<List<BlogPostModel>>? _sub;

  @override
  void initState() {
    super.initState();
    _listen();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  /// Posts update live as anyone publishes, likes or comments.
  void _listen() {
    _sub?.cancel();
    _sub = ref.read(communityServiceProvider).watchPosts().listen(
      (posts) {
        if (!mounted) return;
        final blocked = ref.read(currentUserProvider)?.blockedUserIds ?? const [];
        _posts = posts.where((p) => !blocked.contains(p.authorId)).toList();
        _isLoading = false;
        _error = null;
        _filterPosts();
      },
      onError: (Object e) {
        if (!mounted) return;
        setState(() {
          _isLoading = false;
          _error = 'Could not load posts. Check your internet connection.';
        });
      },
    );
  }

  void _filterPosts() {
    var filtered = _posts;
    
    // Filter by category
    if (_selectedCategory != null) {
      filtered = filtered.where((post) => post.category == _selectedCategory).toList();
    }
    
    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      filtered = filtered.where((post) {
        return post.title.toLowerCase().contains(query) ||
            post.content.toLowerCase().contains(query) ||
            (post.authorName?.toLowerCase().contains(query) ?? false);
      }).toList();
    }
    
    setState(() {
      _filteredPosts = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog'),
        actions: [
          if (user != null && (user.role == UserRole.bishop || user.canPostOnBlog))
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: 'Write a post',
              onPressed: () => context.go('/blog/create'),
            ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _error != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(AppTheme.lg),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_error!, textAlign: TextAlign.center),
                        const SizedBox(height: AppTheme.md),
                        FilledButton(
                          onPressed: () {
                            setState(() => _isLoading = true);
                            _listen();
                          },
                          child: const Text('Try again'),
                        ),
                      ],
                    ),
                  ),
                )
              : _buildBlogContent(context, user),
    );
  }

  Widget _buildBlogContent(BuildContext context, UserModel? user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Search and filter
        _buildSearchAndFilter(context),
        
        // Featured post (if available)
        _buildFeaturedPost(context),
        
        // Posts list
        _buildPostsList(context, user),
      ],
    );
  }

  Widget _buildSearchAndFilter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.md),
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Search bar
          TextField(
            decoration: InputDecoration(
              hintText: 'Search posts...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: AppTheme.mediumBorderRadius,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
            onChanged: (query) {
              setState(() {
                _searchQuery = query;
              });
              _filterPosts();
            },
          ),
          
          const SizedBox(height: AppTheme.md),
          
          // Category filter
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildCategoryChip(context, null, 'All'),
                const SizedBox(width: AppTheme.sm),
                ...BlogCategory.values.map((category) {
                  return Padding(
                    padding: const EdgeInsets.only(right: AppTheme.sm),
                    child: _buildCategoryChip(context, category, category.displayName),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(BuildContext context, BlogCategory? category, String label) {
    return FilterChip(
      label: Text(label),
      selected: _selectedCategory == category,
      onSelected: (selected) {
        setState(() {
          _selectedCategory = selected ? category : null;
        });
        _filterPosts();
      },
      shape: RoundedRectangleBorder(
        borderRadius: AppTheme.mediumBorderRadius,
      ),
    );
  }

  Widget _buildFeaturedPost(BuildContext context) {
    final featuredPosts = _filteredPosts.where((post) => post.isFeatured).toList();
    
    if (featuredPosts.isEmpty) return const SizedBox();
    
    final featuredPost = featuredPosts.first;
    
    return Container(
      margin: const EdgeInsets.all(AppTheme.md),
      decoration: BoxDecoration(
        borderRadius: AppTheme.largeBorderRadius,
        gradient: AppTheme.primaryGradient,
      ),
      child: ClipRRect(
        borderRadius: AppTheme.largeBorderRadius,
        child: Stack(
          children: [
            // Background image (placeholder)
            Container(
              height: 200,
              color: Colors.blue,
              child: Center(
                child: Icon(
                  Icons.article,
                  size: 64,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
            
            // Content
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              padding: const EdgeInsets.all(AppTheme.lg),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Featured',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white.withOpacity(0.8),
                        ),
                  ),
                  Text(
                    featuredPost.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostsList(BuildContext context, UserModel? user) {
    if (_filteredPosts.isEmpty) {
      return Expanded(
        child: Center(
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
                'No posts found',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppTheme.sm),
              if (user != null && (user.role == UserRole.bishop || user.canPostOnBlog))
                Text(
                  'Be the first to share your thoughts!',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                ),
            ],
          ),
        ),
      );
    }
    
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.md),
        itemCount: _filteredPosts.length,
        itemBuilder: (context, index) {
          final post = _filteredPosts[index];
          return BlogPostCard(
            post: post,
            onTap: () => context.pushPostDetail(post.id),
          );
        },
      ),
    );
  }
}
