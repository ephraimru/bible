import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/theme.dart';
import '../../models/verse_model.dart';
import '../../services/auth_service.dart';
import '../../services/bible_service.dart';
import '../../services/database_service.dart';
import '../../widgets/verse_card.dart';

class DailyVerseScreen extends ConsumerStatefulWidget {
  const DailyVerseScreen({super.key});

  @override
  ConsumerState<DailyVerseScreen> createState() => _DailyVerseScreenState();
}

class _DailyVerseScreenState extends ConsumerState<DailyVerseScreen> {
  VerseModel? _dailyVerse;
  bool _isLoading = true;
  bool _isLiked = false;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _loadDailyVerse();
  }

  Future<void> _loadDailyVerse() async {
    try {
      final dailyVerseModel = await ref.read(mockBibleServiceProvider).getDailyVerse();
      if (dailyVerseModel != null) {
        setState(() {
          _dailyVerse = dailyVerseModel.verse;
        });
        
        // Check if user has liked or saved this verse
        final userId = ref.read(localAuthServiceProvider).currentUserId;
        if (userId != null) {
          final user = await ref.read(localStorageServiceProvider).getUser(userId);
          if (user != null) {
            setState(() {
              _isLiked = user.likedVerseIds.contains(_dailyVerse?.id);
              _isSaved = user.savedVerseIds.contains(_dailyVerse?.id);
            });
          }
        }
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
    final userId = ref.read(localAuthServiceProvider).currentUserId;
    if (userId == null || _dailyVerse == null) return;
    
    final databaseService = ref.read(localStorageServiceProvider);
    
    if (_isLiked) {
      // Unlike
      await databaseService.unlikeVerse(_dailyVerse!.id, userId);
      await databaseService.removeLikedVerse(userId, _dailyVerse!.id);
    } else {
      // Like
      await databaseService.likeVerse(_dailyVerse!.id, userId);
      await databaseService.addLikedVerse(userId, _dailyVerse!.id);
    }
    
    setState(() {
      _isLiked = !_isLiked;
    });
  }

  Future<void> _toggleSave() async {
    final userId = ref.read(localAuthServiceProvider).currentUserId;
    if (userId == null || _dailyVerse == null) return;
    
    final databaseService = ref.read(localStorageServiceProvider);
    
    if (_isSaved) {
      // Unsaved
      await databaseService.unsaveVerse(_dailyVerse!.id, userId);
      await databaseService.removeSavedVerse(userId, _dailyVerse!.id);
    } else {
      // Save
      await databaseService.saveVerse(_dailyVerse!.id, userId);
      await databaseService.addSavedVerse(userId, _dailyVerse!.id);
    }
    
    setState(() {
      _isSaved = !_isSaved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Verse'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              // Share verse
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _dailyVerse == null
              ? _buildNoVerseView(context)
              : _buildVerseView(context),
    );
  }

  Widget _buildNoVerseView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.menu_book_outlined,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: AppTheme.md),
          Text(
            'No daily verse available',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppTheme.sm),
          Text(
            'Check back later for today\'s verse',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
          ),
          const SizedBox(height: AppTheme.lg),
          ElevatedButton(
            onPressed: () => _loadDailyVerse(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildVerseView(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Date banner
          Container(
            padding: const EdgeInsets.symmetric(vertical: AppTheme.md),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: AppTheme.mediumBorderRadius,
            ),
            child: Text(
              _formatDate(DateTime.now()),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.primaryColor,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          
          const SizedBox(height: AppTheme.lg),
          
          // Verse card with background
          Container(
            decoration: BoxDecoration(
              borderRadius: AppTheme.largeBorderRadius,
              boxShadow: AppTheme.mediumShadow,
            ),
            child: ClipRRect(
              borderRadius: AppTheme.largeBorderRadius,
              child: Stack(
                children: [
                  // Background image (placeholder)
                  Container(
                    height: 300,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue, Colors.lightBlue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.menu_book,
                        size: 80,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ),
                  
                  // Verse content
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
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
                        // Reference
                        Text(
                          _dailyVerse!.reference,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Colors.white,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppTheme.md),
                        
                        // Verse text
                        Text(
                          _dailyVerse!.text,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: AppTheme.lg),
          
          // Action buttons
          Row(
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
                  padding: const EdgeInsets.all(AppTheme.md),
                ),
              ),
              const SizedBox(width: AppTheme.md),
              
              // Save button
              IconButton.filledTonal(
                icon: Icon(
                  _isSaved ? Icons.bookmark : Icons.bookmark_outline,
                  color: _isSaved ? AppTheme.primaryColor : null,
                ),
                onPressed: _toggleSave,
                style: IconButton.styleFrom(
                  backgroundColor: Colors.grey.shade100,
                  padding: const EdgeInsets.all(AppTheme.md),
                ),
              ),
              const SizedBox(width: AppTheme.md),
              
              // Share button
              IconButton.filledTonal(
                icon: const Icon(Icons.share_outlined),
                onPressed: () {
                  // Share verse
                },
                style: IconButton.styleFrom(
                  backgroundColor: Colors.grey.shade100,
                  padding: const EdgeInsets.all(AppTheme.md),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppTheme.lg),
          
          // Verse details
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: AppTheme.mediumBorderRadius,
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Today\'s Verse',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppTheme.md),
                  
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Book',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey,
                                  ),
                            ),
                            Text(
                              _dailyVerse!.book,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Chapter',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey,
                                  ),
                            ),
                            Text(
                              '${_dailyVerse!.chapter}',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Verse',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey,
                                  ),
                            ),
                            Text(
                              '${_dailyVerse!.verse}',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: AppTheme.lg),
          
          // Reflection section
          _buildReflectionSection(context),
          
          const SizedBox(height: AppTheme.lg),
        ],
      ),
    );
  }

  Widget _buildReflectionSection(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: AppTheme.mediumBorderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(Icons.lightbulb_outline, color: AppTheme.primaryColor),
                const SizedBox(width: AppTheme.sm),
                Text(
                  'Daily Reflection',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: AppTheme.md),
            
            Text(
              'Take a moment to reflect on today\'s verse. What does it mean to you? How can you apply it to your life today?',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: AppTheme.md),
            
            OutlinedButton.icon(
              onPressed: () {
                // Open reflection input
              },
              icon: const Icon(Icons.edit_outlined),
              label: const Text('Write Reflection'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: AppTheme.md),
                shape: RoundedRectangleBorder(
                  borderRadius: AppTheme.mediumBorderRadius,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
