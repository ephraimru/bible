import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/theme.dart';
import '../../models/verse_model.dart';
import '../../services/auth_service.dart';
import '../../services/bible_service.dart';
import '../../services/database_service.dart';
import '../widgets/verse_card.dart';

class VerseDetailScreen extends ConsumerStatefulWidget {
  final String verseId;

  const VerseDetailScreen({super.key, required this.verseId});

  @override
  ConsumerState<VerseDetailScreen> createState() => _VerseDetailScreenState();
}

class _VerseDetailScreenState extends ConsumerState<VerseDetailScreen> {
  VerseModel? _verse;
  bool _isLoading = true;
  bool _isLiked = false;
  bool _isSaved = false;
  List<VerseModel> _relatedVerses = [];

  @override
  void initState() {
    super.initState();
    _loadVerse();
  }

  Future<void> _loadVerse() async {
    try {
      final verse = await ref.read(mockBibleServiceProvider).getVerse(widget.verseId);
      if (verse != null) {
        setState(() {
          _verse = verse;
        });
        
        // Check if user has liked or saved this verse
        final userId = ref.read(localAuthServiceProvider).currentUserId;
        if (userId != null) {
          final user = await ref.read(localStorageServiceProvider).getUser(userId);
          if (user != null) {
            setState(() {
              _isLiked = user.likedVerseIds.contains(verse.id);
              _isSaved = user.savedVerseIds.contains(verse.id);
            });
          }
        }
        
        // Load related verses (from same chapter)
        final chapterVerses = await ref.read(mockBibleServiceProvider).getVersesByChapter(
              verse.book,
              verse.chapter,
            );
        
        // Get verses around this one
        final index = chapterVerses.indexWhere((v) => v.id == verse.id);
        if (index >= 0) {
          final start = (index - 2).clamp(0, chapterVerses.length - 1);
          final end = (index + 3).clamp(0, chapterVerses.length);
          setState(() {
            _relatedVerses = chapterVerses.sublist(start, end);
          });
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
    if (userId == null || _verse == null) return;
    
    final databaseService = ref.read(localStorageServiceProvider);
    
    if (_isLiked) {
      await databaseService.unlikeVerse(_verse!.id, userId);
      await databaseService.removeLikedVerse(userId, _verse!.id);
    } else {
      await databaseService.likeVerse(_verse!.id, userId);
      await databaseService.addLikedVerse(userId, _verse!.id);
    }
    
    setState(() {
      _isLiked = !_isLiked;
    });
  }

  Future<void> _toggleSave() async {
    final userId = ref.read(localAuthServiceProvider).currentUserId;
    if (userId == null || _verse == null) return;
    
    final databaseService = ref.read(localStorageServiceProvider);
    
    if (_isSaved) {
      await databaseService.unsaveVerse(_verse!.id, userId);
      await databaseService.removeSavedVerse(userId, _verse!.id);
    } else {
      await databaseService.saveVerse(_verse!.id, userId);
      await databaseService.addSavedVerse(userId, _verse!.id);
    }
    
    setState(() {
      _isSaved = !_isSaved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_verse?.reference ?? 'Verse'),
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
          : _verse == null
              ? _buildErrorView(context)
              : _buildVerseDetailView(context),
    );
  }

  Widget _buildErrorView(BuildContext context) {
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
            'Verse not found',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppTheme.sm),
          Text(
            'The verse you are looking for could not be found',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
          ),
          const SizedBox(height: AppTheme.lg),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Go Back'),
          ),
        ],
      ),
    );
  }

  Widget _buildVerseDetailView(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Verse card
          VerseCard(
            verse: _verse!,
            showActions: false,
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
              const SizedBox(width: AppTheme.md),
              
              // Notes button
              IconButton.filledTonal(
                icon: const Icon(Icons.note_outlined),
                onPressed: () {
                  // Open notes
                },
                style: IconButton.styleFrom(
                  backgroundColor: Colors.grey.shade100,
                  padding: const EdgeInsets.all(AppTheme.md),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppTheme.lg),
          
          // Verse info
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
                    'Verse Information',
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
                              _verse!.book,
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
                              '${_verse!.chapter}',
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
                              '${_verse!.verse}',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: AppTheme.md),
                  
                  Text(
                    'Translation: ${_verse!.translation ?? 'KJV'}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: AppTheme.lg),
          
          // Related verses
          if (_relatedVerses.isNotEmpty) _buildRelatedVersesSection(context),
          
          const SizedBox(height: AppTheme.lg),
          
          // Study tools
          _buildStudyToolsSection(context),
          
          const SizedBox(height: AppTheme.lg),
        ],
      ),
    );
  }

  Widget _buildRelatedVersesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Related Verses',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: AppTheme.md),
        
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _relatedVerses.length,
            itemBuilder: (context, index) {
              final verse = _relatedVerses[index];
              return Padding(
                padding: const EdgeInsets.only(right: AppTheme.md),
                child: GestureDetector(
                  onTap: () {
                    // Navigate to this verse
                  },
                  child: Container(
                    width: 120,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: AppTheme.mediumBorderRadius,
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    padding: const EdgeInsets.all(AppTheme.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          verse.reference,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppTheme.primaryColor,
                              ),
                        ),
                        const SizedBox(height: AppTheme.sm),
                        Expanded(
                          child: Text(
                            verse.text.length > 80
                                ? '${verse.text.substring(0, 80)}...'
                                : verse.text,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStudyToolsSection(BuildContext context) {
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
            Text(
              'Study Tools',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppTheme.md),
            
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              childAspectRatio: 1.2,
              children: [
                _buildStudyToolButton(
                  context,
                  Icons.comment_outlined,
                  'Commentaries',
                  () {
                    // Open commentaries
                  },
                ),
                _buildStudyToolButton(
                  context,
                  Icons.link,
                  'Cross References',
                  () {
                    // Open cross references
                  },
                ),
                _buildStudyToolButton(
                  context,
                  Icons.compare,
                  'Compare',
                  () {
                    // Open comparison
                  },
                ),
                _buildStudyToolButton(
                  context,
                  Icons.note_outlined,
                  'Study Notes',
                  () {
                    // Open study notes
                  },
                ),
                _buildStudyToolButton(
                  context,
                  Icons.bookmark_outline,
                  'Highlight',
                  () {
                    // Highlight verse
                  },
                ),
                _buildStudyToolButton(
                  context,
                  Icons.copy_outlined,
                  'Copy',
                  () {
                    // Copy verse
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudyToolButton(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onPressed,
  ) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: AppTheme.sm),
      ),
    );
  }
}
