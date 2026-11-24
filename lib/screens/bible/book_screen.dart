import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/router.dart';
import '../../config/theme.dart';
import '../../models/verse_model.dart';
import '../../services/bible_service.dart';
import '../../services/faith_journey_service.dart';
import '../../services/local_auth_service.dart';
import 'bible_screen.dart';

/// Reads one book of the Bible, a chapter at a time.
class BookScreen extends ConsumerStatefulWidget {
  final String book;
  final int initialChapter;

  const BookScreen({super.key, required this.book, this.initialChapter = 1});

  @override
  ConsumerState<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends ConsumerState<BookScreen> {
  final ScrollController _scrollController = ScrollController();

  BibleBook? _currentBook;
  List<VerseModel> _verses = [];
  bool _isLoading = true;
  int _selectedChapter = 1;
  bool _chapterCompleted = false;
  bool _markingRead = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final book = await ref.read(bibleServiceProvider).getBook(Uri.decodeComponent(widget.book));
    if (!mounted) return;
    if (book == null) {
      setState(() => _isLoading = false);
      return;
    }
    setState(() => _currentBook = book);
    await _loadChapter(widget.initialChapter.clamp(1, book.chapters));
  }

  Future<void> _loadChapter(int chapter) async {
    final book = _currentBook;
    if (book == null) return;
    final verses = await ref.read(bibleServiceProvider).getVersesByChapter(book.name, chapter);
    final userId = ref.read(localAuthServiceProvider).currentUserId;
    final completed = userId != null &&
        await ref.read(faithJourneyServiceProvider).isChapterCompleted(userId, book.name, chapter);
    if (!mounted) return;
    setState(() {
      _verses = verses;
      _selectedChapter = chapter;
      _chapterCompleted = completed;
      _isLoading = false;
    });
    if (_scrollController.hasClients) _scrollController.jumpTo(0);
  }

  Future<void> _markChapterRead() async {
    final userId = ref.read(localAuthServiceProvider).currentUserId;
    final book = _currentBook;
    if (userId == null || book == null) return;
    setState(() => _markingRead = true);
    try {
      await ref.read(faithJourneyServiceProvider).updateReadingProgress(
            userId: userId,
            book: book.name,
            chapter: _selectedChapter,
            versesCount: _verses.length,
          );
      if (!mounted) return;
      setState(() => _chapterCompleted = true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${book.name} $_selectedChapter marked as read')),
      );
    } finally {
      if (mounted) setState(() => _markingRead = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final book = _currentBook;
    return Scaffold(
      appBar: AppBar(
        title: Text(book == null ? widget.book : '${book.name} $_selectedChapter'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search the Bible',
            onPressed: () => openBibleSearch(context, ref),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : book == null
              ? _buildErrorView(context)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildChapterSelector(context, book),
                    const Divider(height: 1),
                    Expanded(child: _buildChapter(context, book)),
                  ],
                ),
    );
  }

  Widget _buildErrorView(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.menu_book_outlined, size: 64, color: Colors.grey),
            const SizedBox(height: AppTheme.md),
            Text('Book not found', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppTheme.sm),
            Text(
              'The book "${widget.book}" was not found in the Bible',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: AppTheme.lg),
            ElevatedButton(
              onPressed: () => context.go('/bible'),
              child: const Text('Back to Bible'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChapterSelector(BuildContext context, BibleBook book) {
    return SizedBox(
      height: 56,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.sm, vertical: AppTheme.sm),
        itemCount: book.chapters,
        itemBuilder: (context, index) {
          final chapter = index + 1;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ChoiceChip(
              label: Text('$chapter'),
              selected: _selectedChapter == chapter,
              onSelected: (selected) {
                if (selected) _loadChapter(chapter);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildChapter(BuildContext context, BibleBook book) {
    final theme = Theme.of(context);
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(AppTheme.md, AppTheme.md, AppTheme.md, AppTheme.xl),
      itemCount: _verses.length + 2,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppTheme.md),
            child: Text(
              '${book.testament == 1 ? 'Old' : 'New'} Testament · Chapter $_selectedChapter of ${book.chapters}',
              style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
          );
        }
        if (index == _verses.length + 1) return _buildChapterFooter(context, book);

        final verse = _verses[index - 1];
        return InkWell(
          borderRadius: AppTheme.smallBorderRadius,
          onTap: () => context.pushVerseDetail(verse.id),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${verse.verse}  ',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: verse.text),
                ],
              ),
              style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
            ),
          ),
        );
      },
    );
  }

  Widget _buildChapterFooter(BuildContext context, BibleBook book) {
    return Padding(
      padding: const EdgeInsets.only(top: AppTheme.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FilledButton.icon(
            onPressed: _chapterCompleted || _markingRead ? null : _markChapterRead,
            icon: Icon(_chapterCompleted ? Icons.check_circle : Icons.check_circle_outline),
            label: Text(_chapterCompleted ? 'Chapter read' : 'Mark chapter as read'),
          ),
          const SizedBox(height: AppTheme.sm),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _selectedChapter > 1 ? () => _loadChapter(_selectedChapter - 1) : null,
                  icon: const Icon(Icons.chevron_left),
                  label: const Text('Previous'),
                ),
              ),
              const SizedBox(width: AppTheme.sm),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _selectedChapter < book.chapters
                      ? () => _loadChapter(_selectedChapter + 1)
                      : null,
                  icon: const Icon(Icons.chevron_right),
                  label: const Text('Next'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
