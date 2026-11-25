import 'package:faith_mission_app/services/social_service.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeFirebaseFirestore db;
  late SocialService social;

  setUp(() async {
    db = FakeFirebaseFirestore();
    social = SocialService(db);
    for (final uid in ['ruth', 'paul', 'naomi']) {
      await db.collection('users').doc(uid).set({'displayName': uid, 'role': 'believer'});
    }
  });

  Future<int> followers(String uid) async =>
      ((await db.collection('users').doc(uid).get()).data()!['followersCount'] as num?)?.toInt() ?? 0;

  test('follow and unfollow keep the count and lists right', () async {
    await social.follow(me: 'ruth', target: 'paul');
    await social.follow(me: 'naomi', target: 'paul');
    expect(await followers('paul'), 2);
    expect(await social.watchIsFollowing(me: 'ruth', target: 'paul').first, isTrue);
    expect(await social.watchFollowingCount('ruth').first, 1);
    expect((await social.watchProfile('paul').first)!.followersCount, 2);

    await social.unfollow(me: 'ruth', target: 'paul');
    expect(await followers('paul'), 1);
    expect(await social.watchIsFollowing(me: 'ruth', target: 'paul').first, isFalse);
    expect(await social.watchFollowingCount('ruth').first, 0);
  });

  test('following twice or yourself changes nothing', () async {
    await social.follow(me: 'ruth', target: 'paul');
    await social.follow(me: 'ruth', target: 'paul');
    await social.follow(me: 'ruth', target: 'ruth');
    expect(await followers('paul'), 1);
    expect(await followers('ruth'), 0);
  });

  test('unfollowAll releases everyone (account deletion)', () async {
    await social.follow(me: 'ruth', target: 'paul');
    await social.follow(me: 'ruth', target: 'naomi');
    await social.unfollowAll('ruth');
    expect(await followers('paul'), 0);
    expect(await followers('naomi'), 0);
  });
}
