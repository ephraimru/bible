import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/verse_model.dart';
import 'database_service.dart';

// Bible Service Provider
final bibleServiceProvider = Provider<BibleService>((ref) {
  return BibleService(
    databaseService: ref.read(databaseServiceProvider),
  );
});

class BibleService {
  final DatabaseService _databaseService;
  
  // Cache for Bible data
  Map<String, List<BibleBook>> _bibleBooksCache = {};
  Map<String, BibleChapter> _bibleChaptersCache = {};
  
  BibleService({
    required DatabaseService databaseService,
  }) : _databaseService = databaseService;

  // ============ BIBLE BOOKS ============

  // Get all Bible books
  Future<List<BibleBook>> getBibleBooks() async {
    if (_bibleBooksCache.isNotEmpty) {
      return _bibleBooksCache.values.first;
    }
    
    // Try to get from assets
    try {
      final data = await rootBundle.loadString('assets/data/bible_books.json');
      final jsonData = json.decode(data) as List;
      final books = jsonData
          .map((bookJson) => BibleBook.fromJson(bookJson))
          .toList();
      
      _bibleBooksCache['kjv'] = books;
      return books;
    } catch (e) {
      // Return default books
      return _getDefaultBibleBooks();
    }
  }

  // Get default Bible books
  List<BibleBook> _getDefaultBibleBooks() {
    return [
      // Old Testament
      const BibleBook(name: 'Genesis', abbreviation: 'Gen', chapters: 50, testament: 1, order: 1),
      const BibleBook(name: 'Exodus', abbreviation: 'Exod', chapters: 40, testament: 1, order: 2),
      const BibleBook(name: 'Leviticus', abbreviation: 'Lev', chapters: 27, testament: 1, order: 3),
      const BibleBook(name: 'Numbers', abbreviation: 'Num', chapters: 36, testament: 1, order: 4),
      const BibleBook(name: 'Deuteronomy', abbreviation: 'Deut', chapters: 34, testament: 1, order: 5),
      const BibleBook(name: 'Joshua', abbreviation: 'Josh', chapters: 24, testament: 1, order: 6),
      const BibleBook(name: 'Judges', abbreviation: 'Judg', chapters: 21, testament: 1, order: 7),
      const BibleBook(name: 'Ruth', abbreviation: 'Ruth', chapters: 4, testament: 1, order: 8),
      const BibleBook(name: '1 Samuel', abbreviation: '1Sam', chapters: 31, testament: 1, order: 9),
      const BibleBook(name: '2 Samuel', abbreviation: '2Sam', chapters: 24, testament: 1, order: 10),
      const BibleBook(name: '1 Kings', abbreviation: '1Kgs', chapters: 22, testament: 1, order: 11),
      const BibleBook(name: '2 Kings', abbreviation: '2Kgs', chapters: 25, testament: 1, order: 12),
      const BibleBook(name: '1 Chronicles', abbreviation: '1Chr', chapters: 29, testament: 1, order: 13),
      const BibleBook(name: '2 Chronicles', abbreviation: '2Chr', chapters: 36, testament: 1, order: 14),
      const BibleBook(name: 'Ezra', abbreviation: 'Ezra', chapters: 10, testament: 1, order: 15),
      const BibleBook(name: 'Nehemiah', abbreviation: 'Neh', chapters: 13, testament: 1, order: 16),
      const BibleBook(name: 'Esther', abbreviation: 'Esth', chapters: 10, testament: 1, order: 17),
      const BibleBook(name: 'Job', abbreviation: 'Job', chapters: 42, testament: 1, order: 18),
      const BibleBook(name: 'Psalms', abbreviation: 'Ps', chapters: 150, testament: 1, order: 19),
      const BibleBook(name: 'Proverbs', abbreviation: 'Prov', chapters: 31, testament: 1, order: 20),
      const BibleBook(name: 'Ecclesiastes', abbreviation: 'Eccl', chapters: 12, testament: 1, order: 21),
      const BibleBook(name: 'Song of Solomon', abbreviation: 'Song', chapters: 8, testament: 1, order: 22),
      const BibleBook(name: 'Isaiah', abbreviation: 'Isa', chapters: 66, testament: 1, order: 23),
      const BibleBook(name: 'Jeremiah', abbreviation: 'Jer', chapters: 52, testament: 1, order: 24),
      const BibleBook(name: 'Lamentations', abbreviation: 'Lam', chapters: 5, testament: 1, order: 25),
      const BibleBook(name: 'Ezekiel', abbreviation: 'Ezek', chapters: 48, testament: 1, order: 26),
      const BibleBook(name: 'Daniel', abbreviation: 'Dan', chapters: 12, testament: 1, order: 27),
      const BibleBook(name: 'Hosea', abbreviation: 'Hos', chapters: 14, testament: 1, order: 28),
      const BibleBook(name: 'Joel', abbreviation: 'Joel', chapters: 3, testament: 1, order: 29),
      const BibleBook(name: 'Amos', abbreviation: 'Amos', chapters: 9, testament: 1, order: 30),
      const BibleBook(name: 'Obadiah', abbreviation: 'Obad', chapters: 1, testament: 1, order: 31),
      const BibleBook(name: 'Jonah', abbreviation: 'Jonah', chapters: 4, testament: 1, order: 32),
      const BibleBook(name: 'Micah', abbreviation: 'Mic', chapters: 7, testament: 1, order: 33),
      const BibleBook(name: 'Nahum', abbreviation: 'Nah', chapters: 3, testament: 1, order: 34),
      const BibleBook(name: 'Habakkuk', abbreviation: 'Hab', chapters: 3, testament: 1, order: 35),
      const BibleBook(name: 'Zephaniah', abbreviation: 'Zeph', chapters: 3, testament: 1, order: 36),
      const BibleBook(name: 'Haggai', abbreviation: 'Hag', chapters: 2, testament: 1, order: 37),
      const BibleBook(name: 'Zechariah', abbreviation: 'Zech', chapters: 14, testament: 1, order: 38),
      const BibleBook(name: 'Malachi', abbreviation: 'Mal', chapters: 4, testament: 1, order: 39),
      
      // New Testament
      const BibleBook(name: 'Matthew', abbreviation: 'Matt', chapters: 28, testament: 2, order: 40),
      const BibleBook(name: 'Mark', abbreviation: 'Mark', chapters: 16, testament: 2, order: 41),
      const BibleBook(name: 'Luke', abbreviation: 'Luke', chapters: 24, testament: 2, order: 42),
      const BibleBook(name: 'John', abbreviation: 'John', chapters: 21, testament: 2, order: 43),
      const BibleBook(name: 'Acts', abbreviation: 'Acts', chapters: 28, testament: 2, order: 44),
      const BibleBook(name: 'Romans', abbreviation: 'Rom', chapters: 16, testament: 2, order: 45),
      const BibleBook(name: '1 Corinthians', abbreviation: '1Cor', chapters: 16, testament: 2, order: 46),
      const BibleBook(name: '2 Corinthians', abbreviation: '2Cor', chapters: 13, testament: 2, order: 47),
      const BibleBook(name: 'Galatians', abbreviation: 'Gal', chapters: 6, testament: 2, order: 48),
      const BibleBook(name: 'Ephesians', abbreviation: 'Eph', chapters: 6, testament: 2, order: 49),
      const BibleBook(name: 'Philippians', abbreviation: 'Phil', chapters: 4, testament: 2, order: 50),
      const BibleBook(name: 'Colossians', abbreviation: 'Col', chapters: 4, testament: 2, order: 51),
      const BibleBook(name: '1 Thessalonians', abbreviation: '1Thess', chapters: 5, testament: 2, order: 52),
      const BibleBook(name: '2 Thessalonians', abbreviation: '2Thess', chapters: 3, testament: 2, order: 53),
      const BibleBook(name: '1 Timothy', abbreviation: '1Tim', chapters: 6, testament: 2, order: 54),
      const BibleBook(name: '2 Timothy', abbreviation: '2Tim', chapters: 4, testament: 2, order: 55),
      const BibleBook(name: 'Titus', abbreviation: 'Titus', chapters: 3, testament: 2, order: 56),
      const BibleBook(name: 'Philemon', abbreviation: 'Phlm', chapters: 1, testament: 2, order: 57),
      const BibleBook(name: 'Hebrews', abbreviation: 'Heb', chapters: 13, testament: 2, order: 58),
      const BibleBook(name: 'James', abbreviation: 'Jas', chapters: 5, testament: 2, order: 59),
      const BibleBook(name: '1 Peter', abbreviation: '1Pet', chapters: 5, testament: 2, order: 60),
      const BibleBook(name: '2 Peter', abbreviation: '2Pet', chapters: 3, testament: 2, order: 61),
      const BibleBook(name: '1 John', abbreviation: '1John', chapters: 5, testament: 2, order: 62),
      const BibleBook(name: '2 John', abbreviation: '2John', chapters: 1, testament: 2, order: 63),
      const BibleBook(name: '3 John', abbreviation: '3John', chapters: 1, testament: 2, order: 64),
      const BibleBook(name: 'Jude', abbreviation: 'Jude', chapters: 1, testament: 2, order: 65),
      const BibleBook(name: 'Revelation', abbreviation: 'Rev', chapters: 22, testament: 2, order: 66),
    ];
  }

  // Get Bible book by name
  Future<BibleBook?> getBibleBook(String name) async {
    final books = await getBibleBooks();
    return books.firstWhere(
      (book) => book.name.toLowerCase() == name.toLowerCase() ||
          book.abbreviation.toLowerCase() == name.toLowerCase(),
      orElse: () => null,
    );
  }

  // Get Bible book by order
  Future<BibleBook?> getBibleBookByOrder(int order) async {
    final books = await getBibleBooks();
    return books.firstWhere(
      (book) => book.order == order,
      orElse: () => null,
    );
  }

  // ============ BIBLE CHAPTERS AND VERSES ============

  // Get chapter from database
  Future<BibleChapter?> getChapter(String book, int chapter) async {
    final cacheKey = '$book:$chapter';
    if (_bibleChaptersCache.containsKey(cacheKey)) {
      return _bibleChaptersCache[cacheKey]!;
    }
    
    final verses = await _databaseService.getVersesByChapter(book, chapter);
    
    if (verses.isEmpty) {
      return null;
    }
    
    final bibleChapter = BibleChapter(
      book: book,
      chapter: chapter,
      verses: verses,
      totalVerses: verses.length,
    );
    
    _bibleChaptersCache[cacheKey] = bibleChapter;
    return bibleChapter;
  }

  // Get verse by reference
  Future<VerseModel?> getVerse(String reference) async {
    // Parse reference (e.g., "John 3:16", "Genesis 1:1")
    final parts = reference.split(' ');
    if (parts.length < 2) return null;
    
    final bookName = parts[0];
    final chapterVerse = parts[1].split(':');
    
    if (chapterVerse.length < 2) return null;
    
    final chapter = int.tryParse(chapterVerse[0]);
    final verse = int.tryParse(chapterVerse[1]);
    
    if (chapter == null || verse == null) return null;
    
    final verses = await _databaseService.getVersesByChapter(bookName, chapter);
    return verses.firstWhere(
      (v) => v.verse == verse,
      orElse: () => null,
    );
  }

  // Get verses by reference range
  Future<List<VerseModel>> getVersesByRange(String startRef, String endRef) async {
    final startVerse = await getVerse(startRef);
    final endVerse = await getVerse(endRef);
    
    if (startVerse == null || endVerse == null) {
      return [];
    }
    
    if (startVerse.book != endVerse.book ||
        startVerse.chapter != endVerse.chapter) {
      // Handle multi-chapter range
      final verses = <VerseModel>[];
      
      if (startVerse.book == endVerse.book) {
        // Same book, different chapters
        for (int chapter = startVerse.chapter; chapter <= endVerse.chapter; chapter++) {
          final chapterVerses = await _databaseService.getVersesByChapter(
            startVerse.book,
            chapter,
          );
          
          if (chapter == startVerse.chapter) {
            verses.addAll(
              chapterVerses.where((v) => v.verse >= startVerse.verse),
            );
          } else if (chapter == endVerse.chapter) {
            verses.addAll(
              chapterVerses.where((v) => v.verse <= endVerse.verse),
            );
          } else {
            verses.addAll(chapterVerses);
          }
        }
      }
      
      return verses;
    }
    
    // Same chapter
    final chapterVerses = await _databaseService.getVersesByChapter(
      startVerse.book,
      startVerse.chapter,
    );
    
    return chapterVerses
        .where((v) => v.verse >= startVerse.verse && v.verse <= endVerse.verse)
        .toList();
  }

  // ============ SEARCH ============

  // Search verses
  Future<List<VerseModel>> searchVerses({
    String? query,
    String? book,
    int? chapter,
    int limit = 50,
  }) async {
    return _databaseService.searchVerses(
      query: query,
      book: book,
      chapter: chapter,
      limit: limit,
    );
  }

  // Advanced search with filters
  Future<List<VerseModel>> advancedSearch({
    String? query,
    List<String>? books,
    List<int>? chapters,
    int? minVerse,
    int? maxVerse,
    int limit = 50,
  }) async {
    final allVerses = <VerseModel>[];
    
    if (books != null && books.isNotEmpty) {
      for (final book in books) {
        final bookChapters = chapters ?? List.generate(150, (i) => i + 1);
        
        for (final chapter in bookChapters) {
          final verses = await _databaseService.getVersesByChapter(book, chapter);
          allVerses.addAll(verses);
        }
      }
    } else {
      // Get all verses (limited)
      final snapshot = await _databaseService.versesCollection
          .limit(1000)
          .get();
      allVerses.addAll(snapshot.docs.map((doc) => doc.data()));
    }
    
    // Filter by chapter
    var filtered = allVerses;
    if (chapters != null && chapters!.isNotEmpty) {
      filtered = filtered.where((v) => chapters!.contains(v.chapter)).toList();
    }
    
    // Filter by verse number
    if (minVerse != null) {
      filtered = filtered.where((v) => v.verse >= minVerse!).toList();
    }
    if (maxVerse != null) {
      filtered = filtered.where((v) => v.verse <= maxVerse!).toList();
    }
    
    // Filter by query
    if (query != null && query!.isNotEmpty) {
      filtered = filtered
          .where((v) => v.text.toLowerCase().contains(query!.toLowerCase()))
          .toList();
    }
    
    return filtered.take(limit).toList();
  }

  // ============ DAILY VERSE ============

  // Get daily verse
  Future<DailyVerseModel?> getDailyVerse([DateTime? date]) async {
    final now = date ?? DateTime.now();
    return _databaseService.getDailyVerse(now);
  }

  // Get random verse
  Future<VerseModel?> getRandomVerse() async {
    return _databaseService.getRandomVerse();
  }

  // ============ READING PLANS ============

  // Get reading plan verses for today
  Future<List<VerseModel>> getReadingPlanVerses({
    required String planId,
    DateTime? date,
  }) async {
    final now = date ?? DateTime.now();
    
    // This would be implemented based on the specific reading plan
    // For now, return a random selection
    final allBooks = await getBibleBooks();
    final randomBook = allBooks[DateTime.now().day % allBooks.length];
    final randomChapter = 1 + (DateTime.now().hour % randomBook.chapters);
    
    return _databaseService.getVersesByChapter(
      randomBook.name,
      randomChapter,
    );
  }

  // Get reading plan progress
  Future<Map<String, dynamic>> getReadingPlanProgress({
    required String userId,
    required String planId,
  }) async {
    // This would track user's progress through a reading plan
    // For now, return mock data
    return {
      'totalDays': 365,
      'completedDays': 0,
      'currentDay': 1,
      'progress': 0.0,
      'lastRead': null,
    };
  }

  // ============ CROSS REFERENCES ============

  // Get cross references for a verse
  Future<List<VerseModel>> getCrossReferences(String verseId) async {
    // This would fetch related verses from a cross-reference database
    // For now, return empty list
    return [];
  }

  // ============ STUDY NOTES ============

  // Get study notes for a verse
  Future<List<Map<String, dynamic>>> getStudyNotes({
    required String userId,
    required String verseId,
  }) async {
    // This would fetch user's study notes from Firestore
    final snapshot = await _databaseService._firestore
        .collection('users/$userId/study_notes')
        .where('verseId', isEqualTo: verseId)
        .get();
    
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  // Save study note
  Future<void> saveStudyNote({
    required String userId,
    required String verseId,
    required String note,
    String? title,
  }) async {
    await _databaseService._firestore
        .collection('users/$userId/study_notes')
        .add({
      'verseId': verseId,
      'note': note,
      'title': title,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // Delete study note
  Future<void> deleteStudyNote({
    required String userId,
    required String noteId,
  }) async {
    await _databaseService._firestore
        .collection('users/$userId/study_notes')
        .doc(noteId)
        .delete();
  }

  // ============ BOOKMARKS ============

  // Get bookmarked verses
  Future<List<VerseModel>> getBookmarkedVerses(String userId) async {
    final user = await _databaseService.getUser(userId);
    if (user == null) return [];
    
    final bookmarkedIds = user.savedVerseIds;
    if (bookmarkedIds.isEmpty) return [];
    
    final verses = <VerseModel>[];
    for (final verseId in bookmarkedIds) {
      final verse = await _databaseService.getVerse(verseId);
      if (verse != null) {
        verses.add(verse);
      }
    }
    
    return verses;
  }

  // Get liked verses
  Future<List<VerseModel>> getLikedVerses(String userId) async {
    final user = await _databaseService.getUser(userId);
    if (user == null) return [];
    
    final likedIds = user.likedVerseIds;
    if (likedIds.isEmpty) return [];
    
    final verses = <VerseModel>[];
    for (final verseId in likedIds) {
      final verse = await _databaseService.getVerse(verseId);
      if (verse != null) {
        verses.add(verse);
      }
    }
    
    return verses;
  }

  // ============ STATISTICS ============

  // Get Bible statistics
  Future<Map<String, dynamic>> getBibleStatistics() async {
    final books = await getBibleBooks();
    final totalChapters = books.fold(0, (sum, book) => sum + book.chapters);
    
    // Count total verses (this might be slow for large databases)
    // For now, use known KJV statistics
    const kjvStats = {
      'totalBooks': 66,
      'totalChapters': 1189,
      'totalVerses': 31102,
      'totalWords': 783137,
    };
    
    return {
      'totalBooks': books.length,
      'totalChapters': totalChapters,
      'totalVerses': kjvStats['totalVerses'],
      'totalWords': kjvStats['totalWords'],
      'oldTestamentBooks': books.where((b) => b.testament == 1).length,
      'newTestamentBooks': books.where((b) => b.testament == 2).length,
    };
  }

  // Get book statistics
  Future<Map<String, dynamic>> getBookStatistics(String book) async {
    final bibleBook = await getBibleBook(book);
    if (bibleBook == null) {
      return {};
    }
    
    final verses = await _databaseService.getVersesByBook(book);
    
    return {
      'name': bibleBook.name,
      'abbreviation': bibleBook.abbreviation,
      'chapters': bibleBook.chapters,
      'verses': verses.length,
      'testament': bibleBook.testament == 1 ? 'Old Testament' : 'New Testament',
    };
  }
}
