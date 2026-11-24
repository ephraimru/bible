import 'dart:convert';
import 'dart:io';

import 'package:faith_mission_app/services/bible_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late BibleService bible;

  setUpAll(() {
    final raw = File('assets/data/bible_kjv.json').readAsStringSync();
    bible = BibleService()..loadFromJson(jsonDecode(raw) as Map<String, dynamic>);
  });

  test('bundles the complete KJV: 66 books, 1189 chapters, 31102 verses', () async {
    final books = await bible.getBibleBooks();
    expect(books, hasLength(66));
    expect(books.where((b) => b.testament == 1), hasLength(39));
    expect(books.fold<int>(0, (sum, b) => sum + b.chapters), 1189);

    var verses = 0;
    for (final b in books) {
      verses += (await bible.getVersesByBook(b.name)).length;
    }
    expect(verses, 31102);
  });

  test('returns the real text at the right reference', () async {
    final john316 = await bible.getVerse('John', 3, 16);
    expect(john316!.text, startsWith('For God so loved the world'));
    expect(john316.reference, 'John 3:16');

    final gen11 = await bible.getVerse('Genesis', 1, 1);
    expect(gen11!.text, 'In the beginning God created the heaven and the earth.');

    final ps119 = await bible.getVersesByChapter('Psalms', 119);
    expect(ps119, hasLength(176));
  });

  test('resolves abbreviations and alternative names', () {
    expect(bible.resolveBookName('Gen'), 'Genesis');
    expect(bible.resolveBookName('psalm'), 'Psalms');
    expect(bible.resolveBookName('1 john'), '1 John');
    expect(bible.resolveBookName('1john'), '1 John');
    expect(bible.resolveBookName('Hezekiah'), isNull);
  });

  test('verse ids round-trip, including legacy format', () async {
    final id = BibleService.verseId('1 John', 4, 8);
    expect(id, '1 John.4.8');
    final verse = await bible.getVerseById(id);
    expect(verse!.text, contains('God is love'));
    expect((await bible.getVerseById('John_3:16'))!.verse, 16);
    expect(await bible.getVerseById('nonsense'), isNull);
    expect(await bible.getVerse('John', 99, 1), isNull);
  });

  test('searches by phrase and by reference', () async {
    final phrase = await bible.searchVerses(query: 'living water');
    expect(phrase, isNotEmpty);
    expect(phrase.every((v) => v.text.toLowerCase().contains('living water')), isTrue);

    final ref = await bible.searchVerses(query: 'John 3:16');
    expect(ref.single.reference, 'John 3:16');

    final range = await bible.searchVerses(query: '1 Cor 13:4-7');
    expect(range.map((v) => v.verse), [4, 5, 6, 7]);

    final chapter = await bible.searchVerses(query: 'Ps 23');
    expect(chapter, hasLength(6));
  });

  test('daily verse is deterministic per day and uses real text', () async {
    final day = DateTime(2026, 11, 24);
    final a = await bible.getDailyVerse(day);
    final b = await bible.getDailyVerse(day);
    expect(a!.verse.reference, b!.verse.reference);
    expect(a.verse.text, isNotEmpty);

    final refs = <String>{};
    for (var i = 0; i < 30; i++) {
      refs.add((await bible.getDailyVerse(day.add(Duration(days: i))))!.verse.reference);
    }
    expect(refs.length, greaterThan(20), reason: 'should rotate through many verses');
  });
}
