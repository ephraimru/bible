import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/theme.dart';
import '../../models/verse_model.dart';
import '../../services/bible_service.dart';
import '../../widgets/book_card.dart';
import '../../widgets/search_bar.dart';

class BibleScreen extends ConsumerStatefulWidget {
  const BibleScreen({super.key});

  @override
  ConsumerState<BibleScreen> createState() => _BibleScreenState();
}

class _BibleScreenState extends ConsumerState<BibleScreen> {
  List<BibleBook> _books = [];
  List<BibleBook> _filteredBooks = [];
  bool _isLoading = true;
  String _searchQuery = '';
  
  // Selected testament filter
  int? _selectedTestament;
  
  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks() async {
    try {
      final books = await ref.read(mockBibleServiceProvider).getBibleBooks();
      setState(() {
        _books = books;
        _filteredBooks = books;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterBooks() {
    var filtered = _books;
    
    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      filtered = filtered.where((book) {
        return book.name.toLowerCase().contains(query) ||
            book.abbreviation.toLowerCase().contains(query);
      }).toList();
    }
    
    // Filter by testament
    if (_selectedTestament != null) {
      filtered = filtered.where((book) => book.testament == _selectedTestament).toList();
    }
    
    setState(() {
      _filteredBooks = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bible (KJV)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Open search dialog
              showSearch(
                context: context,
                delegate: BibleSearchDelegate(ref: ref),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _buildBooksList(context),
    );
  }

  Widget _buildBooksList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Filters
        _buildFilters(context),
        
        // Books list
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(AppTheme.md),
            itemCount: _filteredBooks.length,
            itemBuilder: (context, index) {
              final book = _filteredBooks[index];
              return BookCard(
                book: book,
                onTap: () => context.pushBibleBook(book.name),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFilters(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.md),
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Search bar
          CustomSearchBar(
            hintText: 'Search books...',
            onChanged: (query) {
              setState(() {
                _searchQuery = query;
              });
              _filterBooks();
            },
          ),
          
          const SizedBox(height: AppTheme.md),
          
          // Testament filter
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip(context, null, 'All'),
                const SizedBox(width: AppTheme.sm),
                _buildFilterChip(context, 1, 'Old Testament'),
                const SizedBox(width: AppTheme.sm),
                _buildFilterChip(context, 2, 'New Testament'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(BuildContext context, int? testament, String label) {
    return FilterChip(
      label: Text(label),
      selected: _selectedTestament == testament,
      onSelected: (selected) {
        setState(() {
          _selectedTestament = selected ? testament : null;
        });
        _filterBooks();
      },
      shape: RoundedRectangleBorder(
        borderRadius: AppTheme.mediumBorderRadius,
      ),
    );
  }
}

// Bible search delegate
class BibleSearchDelegate extends SearchDelegate<String> {
  final ProviderRef ref;
  
  BibleSearchDelegate({required this.ref});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context);
  }

  Widget _buildSearchResults(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Text('Enter a search term'),
      );
    }
    
    return FutureBuilder<List<VerseModel>>(
      future: ref.read(mockBibleServiceProvider).searchVerses(query: query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        
        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No results found'),
          );
        }
        
        final verses = snapshot.data!;
        
        return ListView.builder(
          itemCount: verses.length,
          itemBuilder: (context, index) {
            final verse = verses[index];
            return ListTile(
              title: Text(verse.reference),
              subtitle: Text(
                verse.text.length > 100
                    ? '${verse.text.substring(0, 100)}...'
                    : verse.text,
              ),
              onTap: () {
                close(context, verse.id);
                context.pushVerseDetail(verse.id);
              },
            );
          },
        );
      },
    );
  }

  @override
  String get searchFieldLabel => 'Search Bible...';
}
