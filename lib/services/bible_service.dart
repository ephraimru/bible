import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/verse_model.dart';

final bibleServiceProvider = Provider<BibleService>((ref) => BibleService());

/// The full King James Version, bundled offline in `assets/data/bible_kjv.json`.
///
/// Asset layout:
/// ```json
/// { "books": [ { "name": "Genesis", "abbreviation": "Gen", "testament": 1,
///                "chapters": [ ["In the beginning ...", ...], ... ] } ],
///   "daily_verses": [ { "book": "John", "chapter": 3, "verse": 16,
///                       "endVerse": 16, "theme": "Love",
///                       "backgroundColor": "0xFF4CAF50" } ] }
/// ```
class BibleService {
  BibleService({AssetBundle? bundle, this.assetPath = 'assets/data/bible_kjv.json'})
      : _bundle = bundle ?? rootBundle;

  static const String translation = 'KJV';

  final AssetBundle _bundle;
  final String assetPath;

  Future<void>? _loading;
  final List<BibleBook> _books = [];
  final Map<String, List<List<String>>> _text = {};
  final Map<String, String> _bookLookup = {}; // lower-case name/abbrev -> name
  final List<Map<String, dynamic>> _dailyVerses = [];

  bool get isLoaded => _books.isNotEmpty;

  /// Loads and parses the Bible once. Safe to call repeatedly.
  Future<void> initialize() => _loading ??= _load();

  Future<void> _load() async {
    final raw = await _bundle.loadString(assetPath, cache: false);
    // Parsing ~4 MB of JSON off the UI thread keeps the splash screen smooth.
    final data = await compute(_decode, raw);
    loadFromJson(data);
  }

  static Map<String, dynamic> _decode(String raw) =>
      jsonDecode(raw) as Map<String, dynamic>;

  /// Populates the service from already-decoded asset JSON (also used by tests).
  @visibleForTesting
  void loadFromJson(Map<String, dynamic> data) {
    _books.clear();
    _text.clear();
    _bookLookup.clear();
    _dailyVerses.clear();

    final books = data['books'] as List;
    for (var i = 0; i < books.length; i++) {
      final b = books[i] as Map<String, dynamic>;
      final name = b['name'] as String;
      final abbreviation = b['abbreviation'] as String;
      final chapters = (b['chapters'] as List)
          .map((c) => (c as List).cast<String>())
          .toList(growable: false);
      _text[name] = chapters;
      _books.add(BibleBook(
        name: name,
        abbreviation: abbreviation,
        chapters: chapters.length,
        testament: b['testament'] as int,
        order: i + 1,
      ));
      _bookLookup[name.toLowerCase()] = name;
      _bookLookup[name.toLowerCase().replaceAll(' ', '')] = name;
      _bookLookup[abbreviation.toLowerCase()] = name;
    }
    // Common alternative names.
    _bookLookup['psalm'] = 'Psalms';
    _bookLookup['ps'] = 'Psalms';
    _bookLookup['song of songs'] = 'Song of Solomon';
    _bookLookup['revelations'] = 'Revelation';

    for (final d in (data['daily_verses'] as List? ?? const [])) {
      _dailyVerses.add(Map<String, dynamic>.from(d as Map));
    }
    _loading ??= Future.value();
  }

  // ------------------------------------------------------------------ ids

  /// Stable, readable verse id, e.g. `John.3.16` or `1 John.4.8`.
  static String verseId(String book, int chapter, int verse) => '$book.$chapter.$verse';

  /// Parses an id created by [verseId]. Also accepts the legacy
  /// `Book_chapter:verse` format.
  static ({String book, int chapter, int verse})? parseVerseId(String id) {
    final match = RegExp(r'^(.+)[._](\d+)[.:](\d+)$').firstMatch(id);
    if (match == null) return null;
    return (
      book: match.group(1)!,
      chapter: int.parse(match.group(2)!),
      verse: int.parse(match.group(3)!),
    );
  }

  // ---------------------------------------------------------------- books

  Future<List<BibleBook>> getBibleBooks() async {
    await initialize();
    return List.unmodifiable(_books);
  }

  Future<BibleBook?> getBook(String name) async {
    await initialize();
    final resolved = resolveBookName(name);
    if (resolved == null) return null;
    return _books.firstWhere((b) => b.name == resolved);
  }

  /// Resolves a book name or abbreviation ("John", "john", "Gen", "1 Sam",
  /// "1sam", "Psalm") to its canonical name. Returns null if unknown.
  String? resolveBookName(String input) {
    final key = input.trim().toLowerCase();
    return _bookLookup[key] ?? _bookLookup[key.replaceAll(' ', '')];
  }

  // --------------------------------------------------------------- verses

  VerseModel _verse(String book, int chapter, int verse, String text) => VerseModel(
        id: verseId(book, chapter, verse),
        reference: '$book $chapter:$verse',
        text: text,
        book: book,
        chapter: chapter,
        verse: verse,
        translation: translation,
      );

  Future<int> getChapterCount(String book) async {
    await initialize();
    final name = resolveBookName(book);
    return name == null ? 0 : _text[name]!.length;
  }

  Future<List<VerseModel>> getVersesByChapter(String book, int chapter) async {
    await initialize();
    final name = resolveBookName(book);
    if (name == null) return const [];
    final chapters = _text[name]!;
    if (chapter < 1 || chapter > chapters.length) return const [];
    final verses = chapters[chapter - 1];
    return [
      for (var i = 0; i < verses.length; i++) _verse(name, chapter, i + 1, verses[i]),
    ];
  }

  Future<List<VerseModel>> getVersesByBook(String book) async {
    await initialize();
    final name = resolveBookName(book);
    if (name == null) return const [];
    final result = <VerseModel>[];
    final chapters = _text[name]!;
    for (var c = 0; c < chapters.length; c++) {
      for (var v = 0; v < chapters[c].length; v++) {
        result.add(_verse(name, c + 1, v + 1, chapters[c][v]));
      }
    }
    return result;
  }

  Future<VerseModel?> getVerse(String book, int chapter, int verse) async {
    await initialize();
    final name = resolveBookName(book);
    if (name == null) return null;
    final chapters = _text[name]!;
    if (chapter < 1 || chapter > chapters.length) return null;
    final verses = chapters[chapter - 1];
    if (verse < 1 || verse > verses.length) return null;
    return _verse(name, chapter, verse, verses[verse - 1]);
  }

  Future<VerseModel?> getVerseById(String id) async {
    final parsed = parseVerseId(Uri.decodeComponent(id));
    if (parsed == null) return null;
    return getVerse(parsed.book, parsed.chapter, parsed.verse);
  }

  // --------------------------------------------------------------- search

  static final RegExp _referencePattern =
      RegExp(r'^\s*((?:[1-3]\s*)?[a-zA-Z][a-zA-Z ]*?)\.?\s+(\d+)(?:\s*:\s*(\d+)(?:\s*-\s*(\d+))?)?\s*$');

  /// Searches the whole Bible (or one [book]).
  ///
  /// A query that looks like a reference ("John 3:16", "Ps 23", "1 Cor 13:4-7")
  /// returns those verses; anything else is a case-insensitive phrase search.
  Future<List<VerseModel>> searchVerses({
    String? query,
    String? book,
    int? chapter,
    int limit = 50,
  }) async {
    await initialize();
    final q = query?.trim() ?? '';

    if (q.isNotEmpty) {
      final reference = await _searchReference(q, limit);
      if (reference != null) return reference;
    }

    final needle = q.toLowerCase();
    final bookName = book == null ? null : resolveBookName(book);
    final results = <VerseModel>[];
    for (final b in _books) {
      if (bookName != null && b.name != bookName) continue;
      final chapters = _text[b.name]!;
      for (var c = 0; c < chapters.length; c++) {
        if (chapter != null && c + 1 != chapter) continue;
        final verses = chapters[c];
        for (var v = 0; v < verses.length; v++) {
          if (needle.isEmpty || verses[v].toLowerCase().contains(needle)) {
            results.add(_verse(b.name, c + 1, v + 1, verses[v]));
            if (results.length >= limit) return results;
          }
        }
      }
    }
    return results;
  }

  Future<List<VerseModel>?> _searchReference(String q, int limit) async {
    final m = _referencePattern.firstMatch(q);
    if (m == null) return null;
    final name = resolveBookName(m.group(1)!);
    if (name == null) return null;
    final chapter = int.parse(m.group(2)!);
    final verses = await getVersesByChapter(name, chapter);
    if (m.group(3) == null) return verses.take(limit).toList();
    final start = int.parse(m.group(3)!);
    final end = m.group(4) == null ? start : int.parse(m.group(4)!);
    return verses.where((v) => v.verse >= start && v.verse <= end).take(limit).toList();
  }

  // ---------------------------------------------------------- daily verse

  /// The verse of the day. The same date always yields the same verse.
  Future<DailyVerseModel?> getDailyVerse([DateTime? date]) async {
    await initialize();
    if (_dailyVerses.isEmpty) return null;
    final day = date ?? DateTime.now();
    final dayNumber =
        DateTime.utc(day.year, day.month, day.day).millisecondsSinceEpoch ~/ Duration.millisecondsPerDay;
    final entry = _dailyVerses[dayNumber % _dailyVerses.length];

    final book = entry['book'] as String;
    final chapter = entry['chapter'] as int;
    final start = entry['verse'] as int;
    final end = (entry['endVerse'] as int?) ?? start;
    final passage = (await getVersesByChapter(book, chapter))
        .where((v) => v.verse >= start && v.verse <= end)
        .toList();
    if (passage.isEmpty) return null;

    final theme = entry['theme'] as String?;
    final color = entry['backgroundColor'] as String?;
    final verse = passage.first.copyWith(
      reference: end == start ? '$book $chapter:$start' : '$book $chapter:$start-$end',
      text: passage.map((v) => v.text).join(' '),
      isDailyVerse: true,
      date: day,
      themeColor: color,
      tags: [if (theme != null) theme],
    );
    return DailyVerseModel(
      verse: verse,
      date: DateTime(day.year, day.month, day.day),
      themeColor: color,
      tags: [if (theme != null) theme],
    );
  }

  Future<VerseModel?> getVerseOfTheDay() async => (await getDailyVerse())?.verse;
}
