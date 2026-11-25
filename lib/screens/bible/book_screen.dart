import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/theme.dart';
import '../../models/verse_model.dart';
import '../../services/bible_service.dart';
import '../../widgets/verse_card.dart';

class BookScreen extends ConsumerStatefulWidget {
  final String book;

  const BookScreen({super.key, required this.book});

  @override
  ConsumerState<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends ConsumerState<BookScreen> {
  List<BibleBook> _books = [];
  BibleBook? _currentBook;
  List<VerseModel> _verses = [];
  bool _isLoading = true;
  int _selectedChapter = 1;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final books = await ref.read(mockBibleServiceProvider).getBibleBooks();
      final currentBook = books.firstWhere(
        (book) => book.name.toLowerCase() == widget.book.toLowerCase() ||
            book.abbreviation.toLowerCase() == widget.book.toLowerCase(),
        orElse: () => null,
      );
      
      if (currentBook != null) {
        setState(() {
          _currentBook = currentBook;
        });
        
        await _loadChapter(currentBook, 1);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadChapter(BibleBook book, int chapter) async {
    try {
      final verses = await ref.read(mockBibleServiceProvider).getVersesByChapter(
            book.name,
            chapter,
          );
      
      setState(() {
        _verses = verses;
        _selectedChapter = chapter;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentBook?.name ?? widget.book),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Open search
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _currentBook == null
              ? _buildErrorView(context)
              : _buildBookView(context),
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
            'Book not found',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppTheme.sm),
          Text(
            'The book "${widget.book}" was not found in the Bible',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
          ),
          const SizedBox(height: AppTheme.lg),
          ElevatedButton(
            onPressed: () => context.go('/bible'),
            child: const Text('Back to Bible'),
          ),
        ],
      ),
    );
  }

  Widget _buildBookView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Chapter selector
        _buildChapterSelector(context),
        
        // Book info
        _buildBookInfo(context),
        
        // Verses list
        _buildVersesList(context),
      ],
    );
  }

  Widget _buildChapterSelector(BuildContext context) {
    if (_currentBook == null) return const SizedBox();
    
    return Container(
      padding: const EdgeInsets.all(AppTheme.md),
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Select Chapter',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: AppTheme.sm),
          
          // Chapter grid
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _currentBook!.chapters,
              itemBuilder: (context, index) {
                final chapter = index + 1;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(chapter.toString()),
                    selected: _selectedChapter == chapter,
                    onSelected: (selected) {
                      if (selected) {
                        _loadChapter(_currentBook!, chapter);
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: AppTheme.mediumBorderRadius,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookInfo(BuildContext context) {
    if (_currentBook == null) return const SizedBox();
    
    return Container(
      padding: const EdgeInsets.all(AppTheme.md),
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Testament',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                ),
                Text(
                  _currentBook!.testament == 1 ? 'Old Testament' : 'New Testament',
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
                  'Chapters',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                ),
                Text(
                  '${_currentBook!.chapters}',
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
                  'Current Chapter',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                ),
                Text(
                  '$_selectedChapter',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVersesList(BuildContext context) {
    if (_verses.isEmpty) {
      return Expanded(
        child: Center(
          child: Text(
            'No verses found in chapter $_selectedChapter',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
          ),
        ),
      );
    }
    
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(AppTheme.md),
        itemCount: _verses.length,
        itemBuilder: (context, index) {
          final verse = _verses[index];
          return VerseCard(
            verse: verse,
            showBook: false,
            onTap: () => context.pushVerseDetail(verse.id),
          );
        },
      ),
    );
  }
}
