import 'package:faith_mission_app/services/moderation_service.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/test_storage.dart';

void main() {
  late ModerationService moderation;

  setUp(() async {
    moderation = ModerationService(storage: await createTestStorage());
  });
  tearDown(disposeTestStorage);

  Future<ModerationResult> check(String text) =>
      moderation.moderateMessage(message: text, senderId: 's', roomId: 'r');

  test('allows Scripture that the old word list blocked', () async {
    for (final verse in [
      'Thou shalt not kill. (Exodus 20:13)',
      'Be sober, be vigilant; because your adversary the devil walketh about.',
      'The fool hath said in his heart, There is no God.',
      'and the wall fell down flat (Joshua 6:20)',
      'For the government shall be upon his shoulder',
      'Hello everyone, let us pray toward a great reward!',
    ]) {
      final result = await check(verse);
      expect(result.isAllowed, isTrue, reason: verse);
      expect(result.isFlagged, isFalse, reason: verse);
    }
  });

  test('rejects profanity and slurs', () async {
    final result = await check('this is shit');
    expect(result.isAllowed, isFalse);
    expect(result.isFlagged, isTrue);
  });

  test('flags insults for review but still delivers them', () async {
    final result = await check('you are an idiot');
    expect(result.isAllowed, isTrue);
    expect(result.isFlagged, isTrue);
    expect(result.requiresReview, isTrue);
  });

  test('keeps chat on the Gospel: rejects political debate', () async {
    final political = await check('The election results prove the democrats are wrong');
    expect(political.isAllowed, isFalse);

    final oneMention = await check('Pray for the president today');
    expect(oneMention.isFlagged, isFalse);
  });

  test('filterContent masks whole words only', () {
    expect(moderation.filterContent('shit happens'), '**** happens');
    expect(moderation.filterContent('Dickens wrote books'), 'Dickens wrote books');
  });
}
