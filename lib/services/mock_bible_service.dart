import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/verse_model.dart';
import 'local_storage_service.dart';

// Mock Bible Service Provider
final mockBibleServiceProvider = Provider<MockBibleService>((ref) {
  return MockBibleService(
    localStorageService: ref.read(localStorageServiceProvider),
  );
});

class MockBibleService {
  final LocalStorageService _localStorageService;
  
  // Cache for Bible data
  Map<String, List<BibleBook>> _bibleBooksCache = {};
  Map<String, List<VerseModel>> _versesCache = {};
  
  MockBibleService({
    required LocalStorageService localStorageService,
  }) : _localStorageService = localStorageService;

  // Initialize with mock data
  Future<void> initialize() async {
    _bibleBooksCache['kjv'] = _getMockBibleBooks();

    // Seed storage only once. Re-seeding would also reset every verse's
    // likes and saves, and slows startup considerably.
    if (_localStorageService.getAppSetting<bool>(_seededKey) == true) return;

    for (final book in _bibleBooksCache['kjv']!) {
      final verses = _generateMockVerses(book);
      _versesCache[book.name] = verses;
      for (final verse in verses) {
        await _localStorageService.createVerse(verse);
      }
    }

    await _localStorageService.setAppSetting(_seededKey, true);
  }

  static const _seededKey = 'bible_books_loaded';

  // Get all Bible books
  Future<List<BibleBook>> getBibleBooks() async {
    if (_bibleBooksCache.isNotEmpty) {
      return _bibleBooksCache.values.first;
    }
    
    // Load from local storage if available
    try {
      final books = await _localStorageService.getAllVerses();
      if (books.isNotEmpty) {
        // Group by book
        final booksMap = <String, List<VerseModel>>{};
        for (final verse in books) {
          booksMap.putIfAbsent(verse.book, () => []).add(verse);
        }
        
        // Create BibleBook objects
        return booksMap.keys.map((bookName) {
          final verses = booksMap[bookName]!;
          final chapters = verses.map((v) => v.chapter).toSet().length;
          final testament = _getTestament(bookName);
          final order = _getBookOrder(bookName);
          return BibleBook(
            name: bookName,
            abbreviation: _getAbbreviation(bookName),
            chapters: chapters,
            testament: testament,
            order: order,
          );
        }).toList()
          ..sort((a, b) => a.order.compareTo(b.order));
      }
    } catch (e) {
      // Fallback to mock data
    }
    
    _bibleBooksCache['kjv'] = _getMockBibleBooks();
    return _bibleBooksCache.values.first;
  }

  // Get testament for a book
  int _getTestament(String bookName) {
    final oldTestamentBooks = [
      'Genesis', 'Exodus', 'Leviticus', 'Numbers', 'Deuteronomy',
      'Joshua', 'Judges', 'Ruth', '1 Samuel', '2 Samuel',
      '1 Kings', '2 Kings', '1 Chronicles', '2 Chronicles',
      'Ezra', 'Nehemiah', 'Esther', 'Job', 'Psalms',
      'Proverbs', 'Ecclesiastes', 'Song of Solomon', 'Isaiah',
      'Jeremiah', 'Lamentations', 'Ezekiel', 'Daniel',
      'Hosea', 'Joel', 'Amos', 'Obadiah', 'Jonah',
      'Micah', 'Nahum', 'Habakkuk', 'Zephaniah', 'Haggai',
      'Zechariah', 'Malachi',
    ];
    return oldTestamentBooks.contains(bookName) ? 1 : 2;
  }

  // Get book order
  int _getBookOrder(String bookName) {
    final bookOrders = {
      'Genesis': 1, 'Exodus': 2, 'Leviticus': 3, 'Numbers': 4, 'Deuteronomy': 5,
      'Joshua': 6, 'Judges': 7, 'Ruth': 8, '1 Samuel': 9, '2 Samuel': 10,
      '1 Kings': 11, '2 Kings': 12, '1 Chronicles': 13, '2 Chronicles': 14,
      'Ezra': 15, 'Nehemiah': 16, 'Esther': 17, 'Job': 18, 'Psalms': 19,
      'Proverbs': 20, 'Ecclesiastes': 21, 'Song of Solomon': 22, 'Isaiah': 23,
      'Jeremiah': 24, 'Lamentations': 25, 'Ezekiel': 26, 'Daniel': 27,
      'Hosea': 28, 'Joel': 29, 'Amos': 30, 'Obadiah': 31, 'Jonah': 32,
      'Micah': 33, 'Nahum': 34, 'Habakkuk': 35, 'Zephaniah': 36, 'Haggai': 37,
      'Zechariah': 38, 'Malachi': 39,
      'Matthew': 40, 'Mark': 41, 'Luke': 42, 'John': 43, 'Acts': 44,
      'Romans': 45, '1 Corinthians': 46, '2 Corinthians': 47, 'Galatians': 48,
      'Ephesians': 49, 'Philippians': 50, 'Colossians': 51, '1 Thessalonians': 52,
      '2 Thessalonians': 53, '1 Timothy': 54, '2 Timothy': 55, 'Titus': 56,
      'Philemon': 57, 'Hebrews': 58, 'James': 59, '1 Peter': 60,
      '2 Peter': 61, '1 John': 62, '2 John': 63, '3 John': 64,
      'Jude': 65, 'Revelation': 66,
    };
    return bookOrders[bookName] ?? 0;
  }

  // Get book abbreviation
  String _getAbbreviation(String bookName) {
    final abbreviations = {
      'Genesis': 'Gen', 'Exodus': 'Exod', 'Leviticus': 'Lev', 'Numbers': 'Num',
      'Deuteronomy': 'Deut', 'Joshua': 'Josh', 'Judges': 'Judg', 'Ruth': 'Ruth',
      '1 Samuel': '1Sam', '2 Samuel': '2Sam', '1 Kings': '1Kgs', '2 Kings': '2Kgs',
      '1 Chronicles': '1Chr', '2 Chronicles': '2Chr', 'Ezra': 'Ezra',
      'Nehemiah': 'Neh', 'Esther': 'Esth', 'Job': 'Job', 'Psalms': 'Ps',
      'Proverbs': 'Prov', 'Ecclesiastes': 'Eccl', 'Song of Solomon': 'Song',
      'Isaiah': 'Isa', 'Jeremiah': 'Jer', 'Lamentations': 'Lam', 'Ezekiel': 'Ezek',
      'Daniel': 'Dan', 'Hosea': 'Hos', 'Joel': 'Joel', 'Amos': 'Amos',
      'Obadiah': 'Obad', 'Jonah': 'Jonah', 'Micah': 'Mic', 'Nahum': 'Nah',
      'Habakkuk': 'Hab', 'Zephaniah': 'Zeph', 'Haggai': 'Hag', 'Zechariah': 'Zech',
      'Malachi': 'Mal', 'Matthew': 'Matt', 'Mark': 'Mark', 'Luke': 'Luke',
      'John': 'John', 'Acts': 'Acts', 'Romans': 'Rom',
      '1 Corinthians': '1Cor', '2 Corinthians': '2Cor', 'Galatians': 'Gal',
      'Ephesians': 'Eph', 'Philippians': 'Phil', 'Colossians': 'Col',
      '1 Thessalonians': '1Thess', '2 Thessalonians': '2Thess',
      '1 Timothy': '1Tim', '2 Timothy': '2Tim', 'Titus': 'Tit',
      'Philemon': 'Phlm', 'Hebrews': 'Heb', 'James': 'Jas',
      '1 Peter': '1Pet', '2 Peter': '2Pet', '1 John': '1John',
      '2 John': '2John', '3 John': '3John', 'Jude': 'Jude', 'Revelation': 'Rev',
    };
    return abbreviations[bookName] ?? bookName.substring(0, 3);
  }

  // Get mock Bible books
  List<BibleBook> _getMockBibleBooks() {
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
      const BibleBook(name: 'Titus', abbreviation: 'Tit', chapters: 3, testament: 2, order: 56),
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

  // Generate mock verses for a book
  List<VerseModel> _generateMockVerses(BibleBook book) {
    final verses = <VerseModel>[];
    final verseTexts = _getVerseTexts(book.name);
    
    for (int chapter = 1; chapter <= book.chapters; chapter++) {
      final chapterVerses = verseTexts[chapter] ?? [];
      final verseCount = chapterVerses.isNotEmpty ? chapterVerses.length : _getRandomVerseCount();
      
      for (int verseNum = 1; verseNum <= verseCount; verseNum++) {
        final verseText = chapterVerses.isNotEmpty && verseNum <= chapterVerses.length
            ? chapterVerses[verseNum - 1]
            : _getRandomVerseText(book.name, chapter, verseNum);
        
        final verseId = '${book.name}_$chapter:$verseNum';
        verses.add(VerseModel(
          id: verseId,
          reference: '${book.name} $chapter:$verseNum',
          text: verseText,
          book: book.name,
          chapter: chapter,
          verse: verseNum,
          translation: 'KJV',
          likes: 0,
          saves: 0,
          tags: [book.name, 'Bible'],
          likedBy: [],
          savedBy: [],
        ));
      }
    }
    
    return verses;
  }

  // Get verse texts for specific books
  Map<int, List<String>> _getVerseTexts(String bookName) {
    // Famous verses
    if (bookName == 'John') {
      return {
        3: [
          'In the beginning was the Word, and the Word was with God, and the Word was God.',
          'The same was in the beginning with God.',
          'All things were made by him; and without him was not any thing made that was made.',
          'In him was life; and the life was the light of men.',
          'And the light shineth in darkness; and the darkness comprehended it not.',
          'There was a man sent from God, whose name was John.',
          'The same came for a witness, to bear witness of the Light, that all men through him might believe.',
          'He was not that Light, but was sent to bear witness of that Light.',
          'That was the true Light, which lighteth every man that cometh into the world.',
          'He was in the world, and the world was made by him, and the world knew him not.',
        ],
      };
    }
    
    if (bookName == 'Genesis') {
      return {
        1: [
          'In the beginning God created the heaven and the earth.',
          'And the earth was without form, and void; and darkness was upon the face of the deep. And the Spirit of God moved upon the face of the waters.',
          'And God said, Let there be light: and there was light.',
          'And God saw the light, that it was good: and God divided the light from the darkness.',
          'And God called the light Day, and the darkness he called Night. And the evening and the morning were the first day.',
        ],
      };
    }
    
    if (bookName == 'Psalms') {
      return {
        23: [
          'The LORD is my shepherd; I shall not want.',
          'He maketh me to lie down in green pastures: he leadeth me beside the still waters.',
          'He restoreth my soul: he leadeth me in the paths of righteousness for his name\'s sake.',
          'Yea, though I walk through the valley of the shadow of death, I will fear no evil: for thou art with me; thy rod and thy staff they comfort me.',
          'Thou preparest a table before me in the presence of mine enemies: thou anointest my head with oil; my cup runneth over.',
          'Surely goodness and mercy shall follow me all the days of my life: and I will dwell in the house of the LORD for ever.',
        ],
      };
    }
    
    return {};
  }

  // Get random verse count for a chapter
  int _getRandomVerseCount() {
    return 10 + (DateTime.now().millisecondsSinceEpoch % 20);
  }

  // Get random verse text
  String _getRandomVerseText(String book, int chapter, int verse) {
    final famousVerses = [
      'For God so loved the world, that he gave his only begotten Son, that whosoever believeth in him should not perish, but have everlasting life.',
      'I can do all things through Christ which strengtheneth me.',
      'The LORD is my shepherd; I shall not want.',
      'Be still, and know that I am God.',
      'Thy word is a lamp unto my feet, and a light unto my path.',
      'Trust in the LORD with all thine heart; and lean not unto thine own understanding.',
      'In all thy ways acknowledge him, and he shall direct thy paths.',
      'The fear of the LORD is the beginning of wisdom.',
      'And we know that all things work together for good to them that love God, to them who are the called according to his purpose.',
      'For I know the thoughts that I think toward you, saith the LORD, thoughts of peace, and not of evil, to give you an expected end.',
      'Behold, I stand at the door, and knock: if any man hear my voice, and open the door, I will come in to him, and will sup with him, and he with me.',
      'Ask, and it shall be given you; seek, and ye shall find; knock, and it shall be opened unto you.',
      'For whosoever shall call upon the name of the Lord shall be saved.',
      'The Lord is not slack concerning his promise, as some men count slackness; but is longsuffering to us-ward, not willing that any should perish, but that all should come to repentance.',
      'And this is the confidence that we have in him, that, if we ask any thing according to his will, he heareth us.',
    ];
    
    final index = (chapter + verse + book.hashCode) % famousVerses.length;
    return famousVerses[index];
  }

  // Get verses by book
  Future<List<VerseModel>> getVersesByBook(String book) async {
    // Check cache first
    if (_versesCache.containsKey(book)) {
      return _versesCache[book]!;
    }
    
    // Load from local storage
    final verses = await _localStorageService.getVersesByBook(book);
    if (verses.isNotEmpty) {
      _versesCache[book] = verses;
      return verses;
    }
    
    // Generate mock verses
    final books = _bibleBooksCache['kjv'] ?? _getMockBibleBooks();
    final bookObj = books.firstWhereOrNull((b) => b.name == book);
    
    if (bookObj != null) {
      final generatedVerses = _generateMockVerses(bookObj);
      _versesCache[book] = generatedVerses;
      
      // Save to local storage
      for (final verse in generatedVerses) {
        await _localStorageService.createVerse(verse);
      }
      
      return generatedVerses;
    }
    
    return [];
  }

  // Get verses by book and chapter
  Future<List<VerseModel>> getVersesByChapter(String book, int chapter) async {
    final verses = await getVersesByBook(book);
    return verses.where((v) => v.chapter == chapter).toList();
  }

  // Get a specific verse
  Future<VerseModel?> getVerse(String book, int chapter, int verse) async {
    final verses = await getVersesByChapter(book, chapter);
    return verses.firstWhereOrNull(
      (v) => v.verse == verse);
  }

  // Search verses
  Future<List<VerseModel>> searchVerses({String? query, String? book, int? chapter, int limit = 50}) async {
    var allVerses = <VerseModel>[];
    
    if (book != null) {
      allVerses = await getVersesByBook(book);
      if (chapter != null) {
        allVerses = allVerses.where((v) => v.chapter == chapter).toList();
      }
    } else {
      // Load all verses
      final books = _bibleBooksCache['kjv'] ?? _getMockBibleBooks();
      for (final bookObj in books) {
        allVerses.addAll(await getVersesByBook(bookObj.name));
      }
    }
    
    if (query != null && query.isNotEmpty) {
      allVerses = allVerses.where((v) => 
        v.text.toLowerCase().contains(query.toLowerCase()) ||
        v.reference.toLowerCase().contains(query.toLowerCase())
      ).toList();
    }
    
    return allVerses.take(limit).toList();
  }

  // Get random verse
  Future<VerseModel?> getRandomVerse() async {
    final allVerses = <VerseModel>[];
    final books = _bibleBooksCache['kjv'] ?? _getMockBibleBooks();
    
    for (final bookObj in books) {
      allVerses.addAll(await getVersesByBook(bookObj.name));
    }
    
    if (allVerses.isEmpty) return null;
    
    final randomIndex = DateTime.now().millisecondsSinceEpoch % allVerses.length;
    return allVerses.elementAt(randomIndex);
  }

  // Get today's daily verse, picking and storing a random one if needed
  Future<DailyVerseModel?> getDailyVerse() async {
    final today = DateTime.now();
    final existing = await _localStorageService.getDailyVerse(today);
    if (existing != null) return existing;

    final randomVerse = await getRandomVerse();
    if (randomVerse == null) return null;

    final dailyVerse = DailyVerseModel(verse: randomVerse, date: today);
    await _localStorageService.createDailyVerse(dailyVerse);
    return dailyVerse;
  }

  // Get verse of the day
  Future<VerseModel?> getVerseOfTheDay() async {
    return (await getDailyVerse())?.verse;
  }
}
