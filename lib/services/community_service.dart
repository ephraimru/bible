import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/blog_model.dart';
import '../models/chat_model.dart';
import '../models/user_model.dart';
import 'auth_service.dart';

final communityServiceProvider = Provider<CommunityService>((ref) {
  return CommunityService(ref.read(firestoreProvider));
});

/// The shared, online parts of the app: the blog and the chat rooms.
///
/// Data layout in Firestore (access rules in `firestore.rules`):
/// - `posts/{postId}`: blog posts; `likedBy` holds the ids of users who liked it
/// - `posts/{postId}/comments/{commentId}`
/// - `rooms/{roomId}/messages/{messageId}`: chat messages for the fixed [rooms]
/// - `reports/{reportId}`: content reported by users, read by the admin only
class CommunityService {
  CommunityService(this._db);

  final FirebaseFirestore _db;

  static const int maxMessageLength = 1000;
  static const int maxCommentLength = 1000;

  /// The chat rooms. They are fixed, so nobody has to create them.
  static final List<ChatRoomModel> rooms = [
    const ChatRoomModel(
      id: 'general',
      name: 'Gospel Discussions',
      type: ChatRoomType.general,
      description: 'Talk about the Gospel and what God is doing in your life.',
    ),
    const ChatRoomModel(
      id: 'prayer',
      name: 'Prayer Requests',
      type: ChatRoomType.prayerGroup,
      description: 'Share prayer requests and pray for one another.',
    ),
    const ChatRoomModel(
      id: 'bible-study',
      name: 'Bible Study',
      type: ChatRoomType.bibleStudy,
      description: 'Questions and insights from your reading.',
    ),
    const ChatRoomModel(
      id: 'testimonies',
      name: 'Testimonies',
      type: ChatRoomType.testimonies,
      description: 'Tell how God has worked in your life.',
    ),
  ];

  static ChatRoomModel? roomById(String id) {
    for (final room in rooms) {
      if (room.id == id) return room;
    }
    return null;
  }

  // ------------------------------------------------------------ helpers

  /// Converts Firestore values (Timestamps) into the JSON the models expect.
  static dynamic _toJson(dynamic value) {
    if (value is Timestamp) return value.toDate().toIso8601String();
    if (value is Map) return value.map((k, v) => MapEntry(k.toString(), _toJson(v)));
    if (value is List) return value.map(_toJson).toList();
    return value;
  }

  static Map<String, dynamic> _docJson(DocumentSnapshot<Map<String, dynamic>> doc) {
    // A just-written server timestamp reads as null until the server confirms
    // it; the models treat missing dates as "now".
    final data = doc.data() ?? {};
    return {..._toJson(data) as Map<String, dynamic>, 'id': doc.id};
  }

  static BlogPostModel? _post(DocumentSnapshot<Map<String, dynamic>> doc) {
    if (!doc.exists) return null;
    try {
      return BlogPostModel.fromJson(_docJson(doc));
    } catch (_) {
      return null; // skip malformed records rather than break the list
    }
  }

  CollectionReference<Map<String, dynamic>> get _posts => _db.collection('posts');
  CollectionReference<Map<String, dynamic>> _comments(String postId) =>
      _posts.doc(postId).collection('comments');
  CollectionReference<Map<String, dynamic>> _messages(String roomId) =>
      _db.collection('rooms').doc(roomId).collection('messages');

  static String _displayName(UserModel user) =>
      user.chosenTitle != null ? '${user.chosenTitle} ${user.displayName}' : user.displayName;

  // --------------------------------------------------------------- blog

  /// Newest published posts first, updated live.
  ///
  /// Uses a single-field order only, so it works on a new Firebase project
  /// without creating composite indexes. Unpublished posts are filtered here.
  Stream<List<BlogPostModel>> watchPosts({int limit = 50}) => _posts
      .orderBy('publishedAt', descending: true)
      .limit(limit)
      .snapshots()
      .map((s) => s.docs
          .map(_post)
          .whereType<BlogPostModel>()
          .where((p) => p.status == BlogPostStatus.published)
          .toList());

  /// One member's posts, newest first (sorted here to avoid needing an index).
  Stream<List<BlogPostModel>> watchPostsBy(String authorId, {int limit = 50}) => _posts
      .where('authorId', isEqualTo: authorId)
      .limit(limit)
      .snapshots()
      .map((s) {
        final posts = s.docs
            .map(_post)
            .whereType<BlogPostModel>()
            .where((p) => p.status == BlogPostStatus.published)
            .toList()
          ..sort((a, b) => (b.publishedAt ?? DateTime.now()).compareTo(a.publishedAt ?? DateTime.now()));
        return posts;
      });

  Stream<BlogPostModel?> watchPost(String postId) =>
      _posts.doc(postId).snapshots().map(_post);

  /// Publishes a post by [author]. Firestore only accepts it from Bishops.
  Future<String> createPost({
    required UserModel author,
    required String title,
    required String content,
    required BlogCategory category,
    String? excerpt,
    List<String> tags = const [],
  }) async {
    final words = content.trim().split(RegExp(r'\s+')).length;
    final doc = await _posts.add({
      'title': title.trim(),
      'content': content.trim(),
      'excerpt': (excerpt == null || excerpt.trim().isEmpty) ? null : excerpt.trim(),
      'category': category.name,
      'tags': tags,
      'authorId': author.id,
      'authorName': _displayName(author),
      'status': BlogPostStatus.published.name,
      'likedBy': <String>[],
      'likes': 0,
      'comments': 0,
      'views': 0,
      'readingTime': (words / 200).ceil().clamp(1, 120),
      'createdAt': FieldValue.serverTimestamp(),
      'publishedAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    return doc.id;
  }

  Future<void> deletePost(String postId) => _posts.doc(postId).delete();

  Future<void> setPostLiked(String postId, String userId, bool liked) {
    return _posts.doc(postId).update({
      'likedBy': liked ? FieldValue.arrayUnion([userId]) : FieldValue.arrayRemove([userId]),
      'likes': FieldValue.increment(liked ? 1 : -1),
    });
  }

  Future<void> recordView(String postId) =>
      _posts.doc(postId).update({'views': FieldValue.increment(1)});

  /// Comments on a post, oldest first, updated live.
  Stream<List<BlogCommentModel>> watchComments(String postId) => _comments(postId)
      .orderBy('createdAt')
      .limit(500)
      .snapshots()
      .map((s) => s.docs
          .map((d) {
            try {
              return BlogCommentModel.fromJson(_docJson(d));
            } catch (_) {
              return null;
            }
          })
          .whereType<BlogCommentModel>()
          .toList());

  Future<void> addComment({
    required String postId,
    required UserModel author,
    required String content,
  }) async {
    final batch = _db.batch();
    batch.set(_comments(postId).doc(), {
      'postId': postId,
      'authorId': author.id,
      'authorName': _displayName(author),
      'content': content.trim(),
      'likes': <String>[],
      'createdAt': FieldValue.serverTimestamp(),
    });
    batch.update(_posts.doc(postId), {'comments': FieldValue.increment(1)});
    await batch.commit();
  }

  Future<void> deleteComment(String postId, String commentId) async {
    final batch = _db.batch();
    batch.delete(_comments(postId).doc(commentId));
    batch.update(_posts.doc(postId), {'comments': FieldValue.increment(-1)});
    await batch.commit();
  }

  // --------------------------------------------------------------- chat

  /// The latest [limit] messages in a room, oldest first, updated live.
  Stream<List<ChatMessageModel>> watchMessages(String roomId, {int limit = 100}) =>
      _messages(roomId)
          .orderBy('createdAt', descending: true)
          .limit(limit)
          .snapshots()
          .map((s) => s.docs
              .map((d) {
                try {
                  return ChatMessageModel.fromJson(_docJson(d));
                } catch (_) {
                  return null;
                }
              })
              .whereType<ChatMessageModel>()
              .toList()
              .reversed
              .toList());

  Stream<ChatMessageModel?> watchLastMessage(String roomId) =>
      watchMessages(roomId, limit: 1).map((m) => m.isEmpty ? null : m.last);

  Future<void> sendMessage({
    required String roomId,
    required UserModel sender,
    required String content,
    bool flagged = false,
  }) async {
    await _messages(roomId).add({
      'roomId': roomId,
      'senderId': sender.id,
      'senderName': _displayName(sender),
      'type': MessageType.text.name,
      'content': content.trim(),
      'status': MessageStatus.sent.name,
      'moderationStatus': (flagged ? ModerationStatus.flagged : ModerationStatus.approved).name,
      'requiresReview': flagged,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteMessage(String roomId, String messageId) =>
      _messages(roomId).doc(messageId).delete();

  // ------------------------------------------------------------ reports

  /// Files a report for the admin to review in the Firebase console.
  Future<void> report({
    required String reporterId,
    required String contentPath,
    required String reason,
    String? authorId,
    String? excerpt,
  }) async {
    await _db.collection('reports').add({
      'reporterId': reporterId,
      'contentPath': contentPath,
      'authorId': authorId,
      'reason': reason,
      'excerpt': excerpt == null || excerpt.length <= 300 ? excerpt : '${excerpt.substring(0, 300)}…',
      'status': 'open',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  static String postPath(String postId) => 'posts/$postId';
  static String commentPath(String postId, String commentId) => 'posts/$postId/comments/$commentId';
  static String messagePath(String roomId, String messageId) => 'rooms/$roomId/messages/$messageId';
}
