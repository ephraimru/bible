import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../models/blog_model.dart';
import '../models/chat_model.dart';
import '../models/faith_journey_model.dart';
import '../models/premium_model.dart';
import '../models/user_model.dart';
import '../models/verse_model.dart';
import 'json_box.dart';

// Hive box names
const String kUsersBox = 'users';
const String kCredentialsBox = 'credentials';
const String kVersesBox = 'verses';
const String kBlogPostsBox = 'blog_posts';
const String kBlogCommentsBox = 'blog_comments';
const String kChatRoomsBox = 'chat_rooms';
const String kChatMessagesBox = 'chat_messages';
const String kFaithJourneysBox = 'faith_journeys';
const String kReadingHabitsBox = 'reading_habits';
const String kReadingSessionsBox = 'reading_sessions';
const String kSubscriptionsBox = 'subscriptions';
const String kPaymentsBox = 'payments';
const String kDailyVersesBox = 'daily_verses';
const String kModerationReportsBox = 'moderation_reports';
const String kAppSettingsBox = 'app_settings';

const List<String> _allBoxes = [
  kUsersBox,
  kCredentialsBox,
  kVersesBox,
  kBlogPostsBox,
  kBlogCommentsBox,
  kChatRoomsBox,
  kChatMessagesBox,
  kFaithJourneysBox,
  kReadingHabitsBox,
  kReadingSessionsBox,
  kSubscriptionsBox,
  kPaymentsBox,
  kDailyVersesBox,
  kModerationReportsBox,
  kAppSettingsBox,
];

/// Overridden in `main.dart` with an already-initialized instance.
final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

/// Offline persistence for the whole app, backed by Hive.
///
/// Every model is stored as JSON (see [JsonBox]), so no Hive type adapters
/// are required. `update*` methods accept a partial map of field names to new
/// values; any field of the model can be updated this way.
class LocalStorageService {
  static const Uuid _uuid = Uuid();
  bool _initialized = false;

  /// False when the device refused persistent storage and data is kept in
  /// memory only (it will be lost when the app closes).
  bool isPersistent = true;

  /// Opens all boxes. Pass [path] to store data in a specific directory
  /// (used by tests, which have no platform path provider).
  Future<void> initialize({String? path}) async {
    if (_initialized) return;
    if (path != null) {
      Hive.init(path);
    } else {
      await Hive.initFlutter();
    }
    for (final name in _allBoxes) {
      if (Hive.isBoxOpen(name)) continue;
      if (!isPersistent) {
        await Hive.openBox(name, bytes: Uint8List(0));
        continue;
      }
      try {
        await Hive.openBox(name);
      } catch (e) {
        // Persistent storage can be unavailable (e.g. some private-browsing
        // modes or sandboxed web frames). Keep the app usable with an
        // in-memory box; data then lasts only for this session.
        debugPrint('Storage "$name" unavailable, using memory instead: $e');
        isPersistent = false;
        await Hive.openBox(name, bytes: Uint8List(0));
      }
    }
    _initialized = true;
  }

  String generateId() => _uuid.v4();

  Future<void> close() => Hive.close();

  Future<void> clearAll() async {
    for (final name in _allBoxes) {
      await Hive.box(name).clear();
    }
  }

  // ============ HELPERS ============

  /// Converts a value into something `jsonEncode` understands, matching the
  /// format json_serializable produces (enums by name, dates as ISO strings).
  static dynamic _toJsonValue(dynamic value) {
    if (value == null || value is num || value is bool || value is String) {
      return value;
    }
    if (value is Enum) return value.name;
    if (value is DateTime) return value.toIso8601String();
    if (value is Duration) return value.inMicroseconds;
    if (value is Iterable) return value.map(_toJsonValue).toList();
    if (value is Map) {
      return value.map((k, v) => MapEntry(k.toString(), _toJsonValue(v)));
    }
    try {
      // Freezed models expose toJson().
      return _toJsonValue((value as dynamic).toJson());
    } catch (_) {
      return value.toString();
    }
  }

  /// Applies [updates] on top of [current] by merging JSON representations.
  static T _merge<T>(
    T current,
    Map<String, dynamic> updates,
    Map<String, dynamic> Function(T) toJson,
    T Function(Map<String, dynamic>) fromJson, {
    bool touchUpdatedAt = true,
  }) {
    final json = toJson(current);
    updates.forEach((key, value) => json[key] = _toJsonValue(value));
    if (touchUpdatedAt && json.containsKey('updatedAt')) {
      json['updatedAt'] = DateTime.now().toIso8601String();
    }
    return fromJson(json);
  }

  static int _byDateDesc(DateTime? a, DateTime? b) {
    final ad = a ?? DateTime.fromMillisecondsSinceEpoch(0);
    final bd = b ?? DateTime.fromMillisecondsSinceEpoch(0);
    return bd.compareTo(ad);
  }

  static List<String> _toggle(List<String> list, String id, bool add) {
    final copy = List<String>.from(list);
    if (add) {
      if (!copy.contains(id)) copy.add(id);
    } else {
      copy.remove(id);
    }
    return copy;
  }

  // ============ USER OPERATIONS ============

  final JsonBox<UserModel> _usersBox =
      JsonBox(kUsersBox, UserModel.fromJson, (u) => u.toJson());

  Future<void> createUser(UserModel user) => _usersBox.put(user.id, user);

  Future<UserModel?> getUser(String userId) async => _usersBox.get(userId);

  /// Synchronous lookup, used to restore the session before the first frame.
  UserModel? getUserSync(String userId) => _usersBox.get(userId);

  Future<UserModel?> getUserByEmail(String email) async {
    final normalized = email.trim().toLowerCase();
    for (final user in _usersBox.values) {
      if (user.email.toLowerCase() == normalized) return user;
    }
    return null;
  }

  Future<void> updateUser(String userId, Map<String, dynamic> updates) async {
    final user = _usersBox.get(userId);
    if (user == null) return;
    await _usersBox.put(
      userId,
      _merge(user, updates, (u) => u.toJson(), UserModel.fromJson),
    );
  }

  Future<void> deleteUser(String userId) => _usersBox.delete(userId);

  Future<List<UserModel>> getAllUsers() async => _usersBox.values.toList();

  Future<List<UserModel>> searchUsers({String? query, int limit = 20}) async {
    final all = _usersBox.values;
    if (query == null || query.isEmpty) return all.take(limit).toList();
    final q = query.toLowerCase();
    return all
        .where((u) =>
            u.displayName.toLowerCase().contains(q) ||
            u.email.toLowerCase().contains(q))
        .take(limit)
        .toList();
  }

  Future<void> incrementFollowingCount(String userId) async {
    final user = _usersBox.get(userId);
    if (user == null) return;
    await updateUser(userId, {'followingCount': user.followingCount + 1});
  }

  Future<void> incrementFollowersCount(String userId) async {
    final user = _usersBox.get(userId);
    if (user == null) return;
    await updateUser(userId, {'followersCount': user.followersCount + 1});
  }

  Future<void> addSavedVerse(String userId, String verseId) =>
      _setSavedVerse(userId, verseId, true);

  Future<void> removeSavedVerse(String userId, String verseId) =>
      _setSavedVerse(userId, verseId, false);

  Future<void> _setSavedVerse(String userId, String verseId, bool add) async {
    final user = _usersBox.get(userId);
    if (user == null) return;
    final ids = _toggle(user.savedVerseIds, verseId, add);
    await updateUser(userId, {'savedVerseIds': ids, 'savedVersesCount': ids.length});
  }

  Future<void> addLikedVerse(String userId, String verseId) =>
      _setLikedVerse(userId, verseId, true);

  Future<void> removeLikedVerse(String userId, String verseId) =>
      _setLikedVerse(userId, verseId, false);

  Future<void> _setLikedVerse(String userId, String verseId, bool add) async {
    final user = _usersBox.get(userId);
    if (user == null) return;
    final ids = _toggle(user.likedVerseIds, verseId, add);
    await updateUser(userId, {'likedVerseIds': ids, 'likedVersesCount': ids.length});
  }

  Stream<UserModel?> streamUser(String userId) async* {
    yield _usersBox.get(userId);
    yield* _usersBox.watchKey(userId);
  }

  // ============ CREDENTIALS ============
  // Stored separately from the user profile so the hash never ends up in
  // places that display or copy user data.

  Box get _credentialsBox => Hive.box(kCredentialsBox);

  Map<String, String>? getCredentials(String userId) {
    final raw = _credentialsBox.get(userId);
    return raw == null ? null : Map<String, String>.from(raw as Map);
  }

  Future<void> setCredentials(String userId, {required String salt, required String hash}) =>
      _credentialsBox.put(userId, {'salt': salt, 'hash': hash});

  Future<void> deleteCredentials(String userId) => _credentialsBox.delete(userId);

  // ============ VERSE OPERATIONS ============
  // Bible text comes from the bundled KJV asset (see BibleService). This box
  // only keeps verses users have interacted with (likes / saves).

  final JsonBox<VerseModel> _versesBox =
      JsonBox(kVersesBox, VerseModel.fromJson, (v) => v.toJson());

  Future<void> createVerse(VerseModel verse) => _versesBox.put(verse.id, verse);

  Future<VerseModel?> getVerse(String verseId) async => _versesBox.get(verseId);

  Future<void> updateVerse(String verseId, Map<String, dynamic> updates) async {
    final verse = _versesBox.get(verseId);
    if (verse == null) return;
    await _versesBox.put(
      verseId,
      _merge(verse, updates, (v) => v.toJson(), VerseModel.fromJson),
    );
  }

  Future<List<VerseModel>> getAllVerses() async => _versesBox.values.toList();

  Future<List<VerseModel>> getVersesByBook(String book) async =>
      _versesBox.values.where((v) => v.book == book).toList();

  Future<void> deleteVerse(String verseId) => _versesBox.delete(verseId);

  /// Records verse-level like/save counts. The per-user lists on [UserModel]
  /// (see [addLikedVerse] / [addSavedVerse]) are the source of truth for the UI.
  Future<void> likeVerse(String verseId, String userId) =>
      _setVerseFlag(verseId, userId, like: true, add: true);
  Future<void> unlikeVerse(String verseId, String userId) =>
      _setVerseFlag(verseId, userId, like: true, add: false);
  Future<void> saveVerse(String verseId, String userId) =>
      _setVerseFlag(verseId, userId, like: false, add: true);
  Future<void> unsaveVerse(String verseId, String userId) =>
      _setVerseFlag(verseId, userId, like: false, add: false);

  Future<void> _setVerseFlag(String verseId, String userId,
      {required bool like, required bool add}) async {
    final verse = _versesBox.get(verseId);
    if (verse == null) return;
    if (like) {
      final likedBy = _toggle(verse.likedBy, userId, add);
      await _versesBox.put(verseId, verse.copyWith(likedBy: likedBy, likes: likedBy.length));
    } else {
      final savedBy = _toggle(verse.savedBy, userId, add);
      await _versesBox.put(verseId, verse.copyWith(savedBy: savedBy, saves: savedBy.length));
    }
  }

  // ============ DAILY VERSE OPERATIONS ============

  final JsonBox<DailyVerseModel> _dailyVersesBox =
      JsonBox(kDailyVersesBox, DailyVerseModel.fromJson, (v) => v.toJson());

  static String _dateKey(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  Future<void> createDailyVerse(DailyVerseModel dailyVerse) =>
      _dailyVersesBox.put(_dateKey(dailyVerse.date), dailyVerse);

  Future<DailyVerseModel?> getDailyVerse(DateTime date) async =>
      _dailyVersesBox.get(_dateKey(date));

  // ============ BLOG OPERATIONS ============

  final JsonBox<BlogPostModel> _blogPostsBox =
      JsonBox(kBlogPostsBox, BlogPostModel.fromJson, (p) => p.toJson());

  Future<String> createBlogPost(BlogPostModel post) async {
    final id = post.id.isNotEmpty ? post.id : _uuid.v4();
    await _blogPostsBox.put(id, post.copyWith(id: id));
    return id;
  }

  Future<BlogPostModel?> getBlogPost(String postId) async => _blogPostsBox.get(postId);

  Future<void> updateBlogPost(String postId, Map<String, dynamic> updates) async {
    final post = _blogPostsBox.get(postId);
    if (post == null) return;
    await _blogPostsBox.put(
      postId,
      _merge(post, updates, (p) => p.toJson(), BlogPostModel.fromJson),
    );
  }

  Future<void> deleteBlogPost(String postId) => _blogPostsBox.delete(postId);

  Iterable<BlogPostModel> get _publishedPosts =>
      _blogPostsBox.values.where((p) => p.status == BlogPostStatus.published);

  Future<List<BlogPostModel>> getBlogPosts({
    int limit = 20,
    BlogCategory? category,
    String? authorId,
    bool featuredOnly = false,
  }) async {
    final posts = _publishedPosts
        .where((p) => category == null || p.category == category)
        .where((p) => authorId == null || p.authorId == authorId)
        .where((p) => !featuredOnly || p.isFeatured)
        .toList()
      ..sort((a, b) => _byDateDesc(a.publishedAt, b.publishedAt));
    return posts.take(limit).toList();
  }

  Future<List<BlogPostModel>> getAllBlogPosts() async => _blogPostsBox.values.toList();

  Future<List<BlogPostModel>> getFeaturedBlogPosts(int limit) =>
      getBlogPosts(limit: limit, featuredOnly: true);

  Future<List<BlogPostModel>> getPopularBlogPosts(int limit) async {
    final posts = _publishedPosts.toList()..sort((a, b) => b.views.compareTo(a.views));
    return posts.take(limit).toList();
  }

  Future<List<BlogPostModel>> getUserBlogPosts(String userId, int limit) =>
      getBlogPosts(limit: limit, authorId: userId);

  Future<void> incrementBlogPostViews(String postId) async {
    final post = _blogPostsBox.get(postId);
    if (post == null) return;
    await _blogPostsBox.put(postId, post.copyWith(views: post.views + 1));
  }

  Future<void> likeBlogPost(String postId, String userId) =>
      _setBlogPostLike(postId, userId, true);

  Future<void> unlikeBlogPost(String postId, String userId) =>
      _setBlogPostLike(postId, userId, false);

  Future<void> _setBlogPostLike(String postId, String userId, bool like) async {
    final post = _blogPostsBox.get(postId);
    if (post == null) return;
    final likedBy = _toggle(post.likedBy, userId, like);
    await _blogPostsBox.put(postId, post.copyWith(likedBy: likedBy, likes: likedBy.length));
  }

  /// Bookmarks are kept on both the post and the user's profile.
  Future<void> bookmarkBlogPost(String postId, String userId) =>
      _setBookmark(postId, userId, true);

  Future<void> removeBookmarkBlogPost(String postId, String userId) =>
      _setBookmark(postId, userId, false);

  Future<void> _setBookmark(String postId, String userId, bool add) async {
    final post = _blogPostsBox.get(postId);
    if (post != null) {
      await _blogPostsBox.put(
        postId,
        post.copyWith(bookmarkedBy: _toggle(post.bookmarkedBy, userId, add)),
      );
    }
    final user = _usersBox.get(userId);
    if (user != null) {
      await updateUser(userId, {
        'bookmarkedBlogPostIds': _toggle(user.bookmarkedBlogPostIds, postId, add),
      });
    }
  }

  // ============ BLOG COMMENTS ============

  final JsonBox<BlogCommentModel> _blogCommentsBox =
      JsonBox(kBlogCommentsBox, BlogCommentModel.fromJson, (c) => c.toJson());

  Future<String> createBlogComment(BlogCommentModel comment) async {
    final id = comment.id.isNotEmpty ? comment.id : _uuid.v4();
    await _blogCommentsBox.put(id, comment.copyWith(id: id));
    final post = _blogPostsBox.get(comment.postId);
    if (post != null) {
      await _blogPostsBox.put(post.id, post.copyWith(comments: post.comments + 1));
    }
    return id;
  }

  Future<List<BlogCommentModel>> getBlogComments(String postId, {int limit = 100}) async {
    final comments = _blogCommentsBox.values
        .where((c) => c.postId == postId && !c.isDeleted)
        .toList()
      ..sort((a, b) => _byDateDesc(b.createdAt, a.createdAt)); // oldest first
    return comments.take(limit).toList();
  }

  Future<void> likeBlogComment(String commentId, String userId) =>
      _setCommentLike(commentId, userId, true);

  Future<void> unlikeBlogComment(String commentId, String userId) =>
      _setCommentLike(commentId, userId, false);

  Future<void> _setCommentLike(String commentId, String userId, bool like) async {
    final comment = _blogCommentsBox.get(commentId);
    if (comment == null) return;
    await _blogCommentsBox.put(
      commentId,
      comment.copyWith(likes: _toggle(comment.likes, userId, like)),
    );
  }

  // ============ CHAT OPERATIONS ============

  final JsonBox<ChatRoomModel> _chatRoomsBox =
      JsonBox(kChatRoomsBox, ChatRoomModel.fromJson, (r) => r.toJson());

  final JsonBox<ChatMessageModel> _chatMessagesBox =
      JsonBox(kChatMessagesBox, ChatMessageModel.fromJson, (m) => m.toJson());

  Future<String> createChatRoom(ChatRoomModel room) async {
    final id = room.id.isNotEmpty ? room.id : _uuid.v4();
    await _chatRoomsBox.put(id, room.copyWith(id: id));
    return id;
  }

  Future<ChatRoomModel?> getChatRoom(String roomId) async => _chatRoomsBox.get(roomId);

  Future<List<ChatRoomModel>> getChatRooms({ChatRoomType? type, int limit = 50}) async {
    final rooms = _chatRoomsBox.values
        .where((r) => !r.isArchived)
        .where((r) => type == null || r.type == type)
        .toList()
      ..sort((a, b) => _byDateDesc(a.lastMessageAt ?? a.createdAt, b.lastMessageAt ?? b.createdAt));
    return rooms.take(limit).toList();
  }

  Future<List<ChatRoomModel>> getAllChatRooms() async => _chatRoomsBox.values.toList();

  Future<ChatRoomModel?> getGeneralChatRoom() async {
    for (final room in _chatRoomsBox.values) {
      if (room.type == ChatRoomType.general) return room;
    }
    return null;
  }

  Future<String> createChatMessage(ChatMessageModel message) async {
    final id = message.id.isNotEmpty ? message.id : _uuid.v4();
    final now = DateTime.now();
    await _chatMessagesBox.put(
      id,
      message.copyWith(id: id, createdAt: message.createdAt ?? now),
    );

    final room = _chatRoomsBox.get(message.roomId);
    if (room != null) {
      await _chatRoomsBox.put(
        room.id,
        room.copyWith(
          lastMessageId: id,
          lastMessageSenderId: message.senderId,
          lastMessageContent: message.content,
          lastMessageAt: now,
          messageCount: room.messageCount + 1,
        ),
      );
    }
    return id;
  }

  List<ChatMessageModel> _messagesFor(String roomId) => _chatMessagesBox.values
      .where((m) => m.roomId == roomId && !m.isDeleted)
      .toList()
    ..sort((a, b) => _byDateDesc(b.createdAt, a.createdAt)); // oldest first

  /// All messages in a room, oldest first.
  Future<List<ChatMessageModel>> getChatMessages(String roomId) async => _messagesFor(roomId);

  /// The most recent [limit] messages in a room, oldest first.
  Future<List<ChatMessageModel>> getRecentChatMessages(String roomId, {int limit = 50}) async {
    final all = _messagesFor(roomId);
    return all.length <= limit ? all : all.sublist(all.length - limit);
  }

  /// Emits the room's messages now and again whenever a message changes.
  Stream<List<ChatMessageModel>> streamChatMessages(String roomId) async* {
    yield _messagesFor(roomId);
    yield* _chatMessagesBox.watch().map((_) => _messagesFor(roomId));
  }

  Future<void> likeChatMessage(String messageId, String userId) async {
    final message = _chatMessagesBox.get(messageId);
    if (message == null) return;
    final liked = message.likedBy.contains(userId);
    final likedBy = _toggle(message.likedBy, userId, !liked);
    await _chatMessagesBox.put(
      messageId,
      message.copyWith(likedBy: likedBy, likes: likedBy.length),
    );
  }

  Future<void> updateChatMessage(String messageId, Map<String, dynamic> updates) async {
    final message = _chatMessagesBox.get(messageId);
    if (message == null) return;
    await _chatMessagesBox.put(
      messageId,
      _merge(message, updates, (m) => m.toJson(), ChatMessageModel.fromJson),
    );
  }

  Future<void> joinChatRoom(String roomId, String userId) async {
    final room = _chatRoomsBox.get(roomId);
    if (room == null || room.memberIds.contains(userId)) return;
    await _chatRoomsBox.put(
      roomId,
      room.copyWith(
        memberIds: [...room.memberIds, userId],
        memberJoinDates: {...room.memberJoinDates, userId: DateTime.now()},
      ),
    );
  }

  Future<void> leaveChatRoom(String roomId, String userId) async {
    final room = _chatRoomsBox.get(roomId);
    if (room == null) return;
    await _chatRoomsBox.put(
      roomId,
      room.copyWith(
        memberIds: _toggle(room.memberIds, userId, false),
        memberJoinDates: Map.of(room.memberJoinDates)..remove(userId),
      ),
    );
  }

  Future<void> updateChatRoom(String roomId, Map<String, dynamic> updates) async {
    final room = _chatRoomsBox.get(roomId);
    if (room == null) return;
    await _chatRoomsBox.put(
      roomId,
      _merge(room, updates, (r) => r.toJson(), ChatRoomModel.fromJson),
    );
  }

  Future<void> deleteChatRoom(String roomId) async {
    await _chatRoomsBox.delete(roomId);
    final messageIds = _chatMessagesBox.values
        .where((m) => m.roomId == roomId)
        .map((m) => m.id)
        .toList();
    for (final id in messageIds) {
      await _chatMessagesBox.delete(id);
    }
  }

  // ============ FAITH JOURNEY OPERATIONS ============

  final JsonBox<FaithJourney> _faithJourneyBox =
      JsonBox(kFaithJourneysBox, FaithJourney.fromJson, (j) => j.toJson());

  Future<void> createFaithJourney(FaithJourney journey) =>
      _faithJourneyBox.put(journey.userId, journey);

  Future<FaithJourney?> getFaithJourney(String userId) async => _faithJourneyBox.get(userId);

  Future<void> updateFaithJourney(String userId, Map<String, dynamic> updates) async {
    final journey = _faithJourneyBox.get(userId);
    if (journey == null) return;
    final merged = _merge(
      journey,
      {...updates, 'lastUpdatedAt': DateTime.now()},
      (j) => j.toJson(),
      FaithJourney.fromJson,
    );
    await _faithJourneyBox.put(userId, merged);
  }

  Future<void> deleteFaithJourney(String userId) => _faithJourneyBox.delete(userId);

  Stream<FaithJourney?> streamFaithJourney(String userId) async* {
    yield _faithJourneyBox.get(userId);
    yield* _faithJourneyBox.watchKey(userId);
  }

  // ============ READING HABIT OPERATIONS ============

  final JsonBox<ReadingHabit> _readingHabitBox =
      JsonBox(kReadingHabitsBox, ReadingHabit.fromJson, (h) => h.toJson());

  final JsonBox<ReadingSession> _readingSessionsBox =
      JsonBox(kReadingSessionsBox, ReadingSession.fromJson, (s) => s.toJson());

  Future<ReadingHabit?> getReadingHabit(String userId) async => _readingHabitBox.get(userId);

  Future<void> updateReadingHabit(String userId, Map<String, dynamic> updates) async {
    final habit = _readingHabitBox.get(userId) ?? ReadingHabit(userId: userId);
    await _readingHabitBox.put(
      userId,
      _merge(habit, updates, (h) => h.toJson(), ReadingHabit.fromJson),
    );
  }

  Future<void> createReadingHabit(ReadingHabit habit) =>
      _readingHabitBox.put(habit.userId, habit);

  Future<void> deleteReadingHabit(String userId) => _readingHabitBox.delete(userId);

  Stream<ReadingHabit?> streamReadingHabit(String userId) async* {
    yield _readingHabitBox.get(userId);
    yield* _readingHabitBox.watchKey(userId);
  }

  Future<void> recordReadingSession(ReadingSession session) =>
      _readingSessionsBox.put(session.id, session);

  Future<List<ReadingSession>> getReadingSessions(String userId) async =>
      _readingSessionsBox.values.where((s) => s.userId == userId).toList()
        ..sort((a, b) => _byDateDesc(a.startedAt, b.startedAt));

  // ============ SUBSCRIPTION OPERATIONS ============

  final JsonBox<Subscription> _subscriptionsBox =
      JsonBox(kSubscriptionsBox, Subscription.fromJson, (s) => s.toJson());

  Future<String> createSubscription(Subscription subscription) async {
    final id = subscription.id.isNotEmpty ? subscription.id : _uuid.v4();
    await _subscriptionsBox.put(id, subscription.copyWith(id: id));
    return id;
  }

  Future<Subscription?> getActiveSubscription(String userId) async {
    final now = DateTime.now();
    final active = _subscriptionsBox.values
        .where((s) => s.userId == userId && s.isActive && !s.isCancelled)
        .where((s) => s.endDate.isAfter(now))
        .toList()
      ..sort((a, b) => b.endDate.compareTo(a.endDate));
    return active.isEmpty ? null : active.first;
  }

  Future<List<Subscription>> getUserSubscriptions(String userId) async =>
      _subscriptionsBox.values.where((s) => s.userId == userId).toList()
        ..sort((a, b) => b.startDate.compareTo(a.startDate));

  Future<Subscription?> getSubscription(String subscriptionId) async =>
      _subscriptionsBox.get(subscriptionId);

  Future<void> updateSubscription(String subscriptionId, Map<String, dynamic> updates) async {
    final sub = _subscriptionsBox.get(subscriptionId);
    if (sub == null) return;
    await _subscriptionsBox.put(
      subscriptionId,
      _merge(sub, updates, (s) => s.toJson(), Subscription.fromJson),
    );
  }

  Future<void> deleteSubscription(String subscriptionId) =>
      _subscriptionsBox.delete(subscriptionId);

  // ============ PAYMENT OPERATIONS ============

  final JsonBox<Payment> _paymentsBox =
      JsonBox(kPaymentsBox, Payment.fromJson, (p) => p.toJson());

  Future<String> createPayment(Payment payment) async {
    final id = payment.id.isNotEmpty ? payment.id : _uuid.v4();
    await _paymentsBox.put(id, payment.copyWith(id: id));
    return id;
  }

  Future<Payment?> getPayment(String paymentId) async => _paymentsBox.get(paymentId);

  Future<List<Payment>> getUserPayments(String userId) async =>
      _paymentsBox.values.where((p) => p.userId == userId).toList()
        ..sort((a, b) => _byDateDesc(a.createdAt, b.createdAt));

  Future<void> updatePayment(String paymentId, Map<String, dynamic> updates) async {
    final payment = _paymentsBox.get(paymentId);
    if (payment == null) return;
    await _paymentsBox.put(
      paymentId,
      _merge(payment, updates, (p) => p.toJson(), Payment.fromJson),
    );
  }

  Future<void> deletePayment(String paymentId) => _paymentsBox.delete(paymentId);

  // ============ APP SETTINGS ============

  Box get _appSettingsBox => Hive.box(kAppSettingsBox);

  T? getAppSetting<T>(String key) {
    final value = _appSettingsBox.get(key);
    return value is T ? value : null;
  }

  Future<void> setAppSetting(String key, dynamic value) async {
    if (value == null) {
      await _appSettingsBox.delete(key);
    } else {
      await _appSettingsBox.put(key, value);
    }
  }

  // ============ MODERATION OPERATIONS ============

  final JsonBox<ModerationReportModel> _moderationReportsBox = JsonBox(
      kModerationReportsBox, ModerationReportModel.fromJson, (r) => r.toJson());

  Future<void> createModerationReport(ModerationReportModel report) =>
      _moderationReportsBox.put(report.id, report);

  Future<ModerationReportModel?> getModerationReport(String reportId) async =>
      _moderationReportsBox.get(reportId);

  Future<List<ModerationReportModel>> getModerationReports({
    ModerationStatus? status,
    int limit = 50,
  }) async {
    final reports = _moderationReportsBox.values
        .where((r) => status == null || r.status == status)
        .toList()
      ..sort((a, b) => _byDateDesc(a.createdAt, b.createdAt));
    return reports.take(limit).toList();
  }

  Future<void> updateModerationReport(String reportId, Map<String, dynamic> updates) async {
    final report = _moderationReportsBox.get(reportId);
    if (report == null) return;
    await _moderationReportsBox.put(
      reportId,
      _merge(report, updates, (r) => r.toJson(), ModerationReportModel.fromJson),
    );
  }

  Future<void> deleteModerationReport(String reportId) =>
      _moderationReportsBox.delete(reportId);
}
