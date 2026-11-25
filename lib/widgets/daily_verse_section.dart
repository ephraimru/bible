import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/theme.dart';
import '../models/verse_model.dart';
import '../services/auth_service.dart';
import '../services/bible_service.dart';
import '../services/local_storage_service.dart';

class DailyVerseSection extends ConsumerStatefulWidget {
  const DailyVerseSection({super.key});

  @override
  ConsumerState<DailyVerseSection> createState() => _DailyVerseSectionState();
}

class _DailyVerseSectionState extends ConsumerState<DailyVerseSection> {
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
      final dailyVerseModel = await ref
          .read(bibleServiceProvider)
          .getDailyVerse();
      if (dailyVerseModel != null) {
        setState(() {
          _dailyVerse = dailyVerseModel.verse;
        });

        // Check if user has liked or saved this verse
        final userId = ref.read(authServiceProvider).currentUserId;
        if (userId != null) {
          final user = await ref
              .read(localStorageServiceProvider)
              .getUser(userId);
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
    final userId = ref.read(authServiceProvider).currentUserId;
    if (userId == null || _dailyVerse == null) return;

    final databaseService = ref.read(localStorageServiceProvider);

    if (_isLiked) {
      await databaseService.unlikeVerse(_dailyVerse!.id, userId);
      await databaseService.removeLikedVerse(userId, _dailyVerse!.id);
    } else {
      await databaseService.likeVerse(_dailyVerse!.id, userId);
      await databaseService.addLikedVerse(userId, _dailyVerse!.id);
    }

    setState(() {
      _isLiked = !_isLiked;
    });
  }

  Future<void> _toggleSave() async {
    final userId = ref.read(authServiceProvider).currentUserId;
    if (userId == null || _dailyVerse == null) return;

    final databaseService = ref.read(localStorageServiceProvider);

    if (_isSaved) {
      await databaseService.unsaveVerse(_dailyVerse!.id, userId);
      await databaseService.removeSavedVerse(userId, _dailyVerse!.id);
    } else {
      await databaseService.saveVerse(_dailyVerse!.id, userId);
      await databaseService.addSavedVerse(userId, _dailyVerse!.id);
    }

    setState(() {
      _isSaved = !_isSaved;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _buildLoadingView(context);
    }

    if (_dailyVerse == null) {
      return _buildNoVerseView(context);
    }

    return _buildDailyVerseView(context);
  }

  Widget _buildLoadingView(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: AppTheme.largeBorderRadius,
        gradient: AppTheme.primaryGradient,
      ),
      child: ClipRRect(
        borderRadius: AppTheme.largeBorderRadius,
        child: Container(
          height: 200,
          color: Colors.blue,
          child: const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNoVerseView(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: AppTheme.largeBorderRadius,
        gradient: AppTheme.primaryGradient,
      ),
      child: ClipRRect(
        borderRadius: AppTheme.largeBorderRadius,
        child: Container(
          height: 200,
          color: Colors.blue,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.menu_book, size: 48, color: Colors.white),
                const SizedBox(height: AppTheme.md),
                Text(
                  'No daily verse available',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: AppTheme.sm),
                ElevatedButton(
                  onPressed: _loadDailyVerse,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                  ),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDailyVerseView(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: AppTheme.largeBorderRadius),
      child: ClipRRect(
        borderRadius: AppTheme.largeBorderRadius,
        child: Stack(
          children: [
            // Background: fills whatever height the verse text needs
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.lightBlue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            Positioned(
              top: AppTheme.md,
              right: AppTheme.md,
              child: Icon(
                Icons.menu_book,
                size: 28,
                color: Colors.white.withValues(alpha: 0.35),
              ),
            ),

            // Overlay gradient
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.7),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(AppTheme.lg),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Date
                  Text(
                    _formatDate(DateTime.now()),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: AppTheme.md),

                  // Reference
                  Text(
                    _dailyVerse!.reference,
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: AppTheme.md),

                  // Verse text
                  Text(
                    _dailyVerse!.text,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: AppTheme.md),

                  // Action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Like button
                      IconButton.filledTonal(
                        icon: Icon(
                          _isLiked ? Icons.favorite : Icons.favorite_outline,
                          color: _isLiked ? Colors.red : Colors.white,
                        ),
                        onPressed: _toggleLike,
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white.withValues(alpha: 0.2),
                          padding: const EdgeInsets.all(AppTheme.sm),
                        ),
                      ),

                      const SizedBox(width: AppTheme.md),

                      // Save button
                      IconButton.filledTonal(
                        icon: Icon(
                          _isSaved ? Icons.bookmark : Icons.bookmark_outline,
                          color: _isSaved
                              ? AppTheme.primaryColor
                              : Colors.white,
                        ),
                        onPressed: _toggleSave,
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white.withValues(alpha: 0.2),
                          padding: const EdgeInsets.all(AppTheme.sm),
                        ),
                      ),

                      const SizedBox(width: AppTheme.md),

                      // View all button
                      ElevatedButton(
                        onPressed: () {
                          // Open daily verse detail
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppTheme.md,
                            vertical: AppTheme.sm,
                          ),
                        ),
                        child: const Text('View Full Verse'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
