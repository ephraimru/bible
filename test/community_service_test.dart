import 'package:faith_mission_app/models/blog_model.dart';
import 'package:faith_mission_app/models/user_model.dart';
import 'package:faith_mission_app/services/community_service.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeFirebaseFirestore db;
  late CommunityService community;
  final paul = UserModel(id: 'paul', email: 'p@x.com', displayName: 'Paul', chosenTitle: 'Bishop');
  final ruth = UserModel(id: 'ruth', email: 'r@x.com', displayName: 'Ruth');

  setUp(() {
    db = FakeFirebaseFirestore();
    community = CommunityService(db);
  });

  test('a published post appears for everyone, newest first, with author and title', () async {
    await community.createPost(
        author: paul, title: 'First', content: 'Grace and peace.', category: BlogCategory.devotionals);
    await Future<void>.delayed(const Duration(milliseconds: 5));
    await community.createPost(
        author: paul, title: 'Second', content: 'Rejoice always.', category: BlogCategory.sermons);

    final posts = await community.watchPosts().first;
    expect(posts.map((p) => p.title), ['Second', 'First']);
    expect(posts.first.authorName, 'Bishop Paul');
    expect(posts.first.category, BlogCategory.sermons);
    expect(posts.first.likes, 0);
  });

  test('likes, comments and their counts', () async {
    final id = await community.createPost(
        author: paul, title: 'Hope', content: 'Hope maketh not ashamed.', category: BlogCategory.devotionals);

    await community.setPostLiked(id, 'ruth', true);
    var post = (await community.watchPost(id).first)!;
    expect(post.likedBy, ['ruth']);
    expect(post.likes, 1);
    await community.setPostLiked(id, 'ruth', false);
    expect((await community.watchPost(id).first)!.likes, 0);

    await community.addComment(postId: id, author: ruth, content: 'Amen!');
    await community.addComment(postId: id, author: paul, content: 'Thank you, Ruth.');
    final comments = await community.watchComments(id).first;
    expect(comments.map((c) => c.content), ['Amen!', 'Thank you, Ruth.']);
    post = (await community.watchPost(id).first)!;
    expect(post.comments, 2);

    await community.deleteComment(id, comments.first.id);
    expect((await community.watchComments(id).first), hasLength(1));
    expect((await community.watchPost(id).first)!.comments, 1);
  });

  test('chat messages come back oldest first, per room', () async {
    await community.sendMessage(roomId: 'general', sender: ruth, content: 'Good morning!');
    await Future<void>.delayed(const Duration(milliseconds: 5));
    await community.sendMessage(roomId: 'general', sender: paul, content: 'Grace to you.');
    await community.sendMessage(roomId: 'prayer', sender: ruth, content: 'Please pray for my mother.');

    final general = await community.watchMessages('general').first;
    expect(general.map((m) => m.content), ['Good morning!', 'Grace to you.']);
    expect(general.last.senderName, 'Bishop Paul');
    expect((await community.watchLastMessage('prayer').first)!.content, 'Please pray for my mother.');
  });

  test('there are four fixed rooms', () {
    expect(CommunityService.rooms.map((r) => r.id), ['general', 'prayer', 'bible-study', 'testimonies']);
    expect(CommunityService.roomById('prayer')!.name, 'Prayer Requests');
    expect(CommunityService.roomById('nope'), isNull);
  });

  test('reports are filed for the admin', () async {
    await community.report(
      reporterId: 'ruth',
      contentPath: CommunityService.messagePath('general', 'm1'),
      authorId: 'naomi',
      reason: 'Offensive or hateful',
      excerpt: 'x' * 400,
    );
    final reports = await db.collection('reports').get();
    expect(reports.docs, hasLength(1));
    final report = reports.docs.single.data();
    expect(report['contentPath'], 'rooms/general/messages/m1');
    expect((report['excerpt'] as String).length, lessThanOrEqualTo(301));
  });
}
