import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../models/blog_model.dart';
import '../models/chat_model.dart';
import '../models/faith_journey_model.dart';
import '../models/premium_model.dart';
import '../models/user_model.dart';
import '../models/verse_model.dart';

// Hive box names
const String kUsersBox = 'users';
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

// Local Storage Service Provider
final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

/// Converts a value into something `jsonEncode` accepts, so that partial
/// updates (which may contain enums, dates or models) can be merged into a
/// model's stored JSON.
Object? toJsonValue(Object? value) {
  if (value == null || value is String || value is num || value is bool) {
    return value;
  }
  if (value is DateTime) return value.toIso8601String();
  if (value is Duration) return value.inMicroseconds;
  if (value is Enum) return value.name;
  if (value is Map) {
    return value.map((k, v) => MapEntry(k.toString(), toJsonValue(v)));
  }
  if (value is Iterable) return value.map(toJsonValue).toList();
  return toJsonValue((value as dynamic).toJson());
}

/// Newest-first comparison for nullable dates (nulls sort last).
int compareNewestFirst(DateTime? a, DateTime? b) {
  if (a == null && b == null) return 0;
  if (a == null) return 1;
  if (b == null) return -1;
  return b.compareTo(a);
}

/// A Hive box that stores models as JSON strings, so no Hive type adapters
/// are needed for the freezed models.
class JsonBox<T> {
  JsonBox(this.name, this._fromJson, this._toJson);

  final String name;
  final T Function(Map<String, dynamic> json) _fromJson;
  final Map<String, dynamic> Function(T value) _toJson;

  Box<String> get _box => Hive.box<String>(name);

  Future<void> open() => Hive.openBox<String>(name);

  T? _decode(String? raw) =>
      raw == null ? null : _fromJson(jsonDecode(raw) as Map<String, dynamic>);

  T? get(String key) => _decode(_box.get(key));

  Iterable<T> get values => _box.values.map((raw) => _decode(raw) as T);

  Future<void> put(String key, T value) =>
      _box.put(key, jsonEncode(_toJson(value)));

  Future<void> delete(String key) => _box.delete(key);

  Future<void> clear() => _box.clear();

  /// Merges [updates] (field name -> new value) into the stored model.
  /// Returns the updated model, or null if [key] does not exist.
  Future<T?> update(String key, Map<String, dynamic> updates) async {
    final raw = _box.get(key);
    if (raw == null) return null;
    final merged = jsonDecode(raw) as Map<String, dynamic>
      ..addAll(toJsonValue(updates) as Map<String, dynamic>);
    final value = _fromJson(merged);
    await put(key, value);
    return value;
  }

  /// Emits the current value of [key], then every later change to it.
  Stream<T?> watchKey(String key) async* {
    yield get(key);
    yield* _box
        .watch(key: key)
        .map((event) => event.deleted ? null : _decode(event.value as String?));
  }

  /// Emits whenever anything in the box changes.
  Stream<void> watchAll() => _box.watch().map((_) {});
}

class LocalStorageService {
  static const Uuid _uuid = Uuid();

  final _users = JsonBox<UserModel>(
      kUsersBox, UserModel.fromJson, (v) => v.toJson());
  final _verses = JsonBox<VerseModel>(
      kVersesBox, VerseModel.fromJson, (v) => v.toJson());
  final _dailyVerses = JsonBox<DailyVerseModel>(
      kDailyVersesBox, DailyVerseModel.fromJson, (v) => v.toJson());
  final _blogPosts = JsonBox<BlogPostModel>(
      kBlogPostsBox, BlogPostModel.fromJson, (v) => v.toJson());
  final _blogComments = JsonBox<BlogCommentModel>(
      kBlogCommentsBox, BlogCommentModel.fromJson, (v) => v.toJson());
  final _chatRooms = JsonBox<ChatRoomModel>(
      kChatRoomsBox, ChatRoomModel.fromJson, (v) => v.toJson());
  final _chatMessages = JsonBox<ChatMessageModel>(
      kChatMessagesBox, ChatMessageModel.fromJson, (v) => v.toJson());
  final _faithJourneys = JsonBox<FaithJourney>(
      kFaithJourneysBox, FaithJourney.fromJson, (v) => v.toJson());
  final _readingHabits = JsonBox<ReadingHabit>(
      kReadingHabitsBox, ReadingHabit.fromJson, (v) => v.toJson());
  final _readingSessions = JsonBox<ReadingSession>(
      kReadingSessionsBox, ReadingSession.fromJson, (v) => v.toJson());
  final _subscriptions = JsonBox<Subscription>(
      kSubscriptionsBox, Subscription.fromJson, (v) => v.toJson());
  final _payments = JsonBox<Payment>(
      kPaymentsBox, Payment.fromJson, (v) => v.toJson());
  final _moderationReports = JsonBox<ModerationReportModel>(
      kModerationReportsBox, ModerationReportModel.fromJson, (v) => v.toJson());

  List<JsonBox<dynamic>> get _allBoxes => [
        _users,
        _verses,
        _dailyVerses,
        _blogPosts,
        _blogComments,
        _chatRooms,
        _chatMessages,
        _faithJourneys,
        _readingHabits,
        _readingSessions,
        _subscriptions,
        _payments,
        _moderationReports,
      ];

  // Initialize Hive and open all boxes
  Future<void> initialize() async {
    await Hive.initFlutter();
    for (final box in _allBoxes) {
      await box.open();
    }
    await Hive.openBox(kAppSettingsBox);
  }

  // Generate unique ID
  String generateId() => _uuid.v4();

  String _idOrNew(String id) => id.isEmpty ? generateId() : id;

  // Close all boxes
  Future<void> close() async {
    await Hive.close();
  }

  // Clear all data
  Future<void> clearAll() async {
    for (final box in _allBoxes) {
      await box.clear();
    }
    await _appSettingsBox.clear();
  }

  // ============ USER OPERATIONS ============

  Future<void> createUser(UserModel user) => _users.put(user.id, user);

  Future<UserModel?> getUser(String userId) async => _users.get(userId);

  /// [updates] maps UserModel field names to new values.
  Future<void> updateUser(String userId, Map<String, dynamic> updates) async {
    await _users.update(userId, {'updatedAt': DateTime.now(), ...updates});
  }

  Future<void> deleteUser(String userId) => _users.delete(userId);

  Future<List<UserModel>> getAllUsers() async => _users.values.toList();

  Future<List<UserModel>> searchUsers({String? query, int limit = 20}) async {
    final allUsers = _users.values;
    if (query == null || query.isEmpty) {
      return allUsers.take(limit).toList();
    }
    final q = query.toLowerCase();
    return allUsers
        .where((user) =>
            user.displayName.toLowerCase().contains(q) ||
            user.email.toLowerCase().contains(q))
        .take(limit)
        .toList();
  }

  Future<void> incrementFollowingCount(String userId) async {
    final user = _users.get(userId);
    if (user != null) {
      await updateUser(userId, {'followingCount': user.followingCount + 1});
    }
  }

  Future<void> incrementFollowersCount(String userId) async {
    final user = _users.get(userId);
    if (user != null) {
      await updateUser(userId, {'followersCount': user.followersCount + 1});
    }
  }

  Future<void> addSavedVerse(String userId, String verseId) async {
    final user = _users.get(userId);
    if (user == null) return;
    final ids = {...user.savedVerseIds, verseId}.toList();
    await updateUser(userId, {'savedVerseIds': ids, 'savedVersesCount': ids.length});
  }

  Future<void> removeSavedVerse(String userId, String verseId) async {
    final user = _users.get(userId);
    if (user == null) return;
    final ids = user.savedVerseIds.where((id) => id != verseId).toList();
    await updateUser(userId, {'savedVerseIds': ids, 'savedVersesCount': ids.length});
  }

  Future<void> addLikedVerse(String userId, String verseId) async {
    final user = _users.get(userId);
    if (user == null) return;
    final ids = {...user.likedVerseIds, verseId}.toList();
    await updateUser(userId, {'likedVerseIds': ids, 'likedVersesCount': ids.length});
  }

  Future<void> removeLikedVerse(String userId, String verseId) async {
    final user = _users.get(userId);
    if (user == null) return;
    final ids = user.likedVerseIds.where((id) => id != verseId).toList();
    await updateUser(userId, {'likedVerseIds': ids, 'likedVersesCount': ids.length});
  }

  Stream<UserModel?> streamUser(String userId) => _users.watchKey(userId);

  // ============ VERSE OPERATIONS ============

  Future<void> createVerse(VerseModel verse) => _verses.put(verse.id, verse);

  Future<VerseModel?> getVerse(String verseId) async => _verses.get(verseId);

  Future<void> updateVerse(String verseId, Map<String, dynamic> updates) async {
    await _verses.update(verseId, updates);
  }

  Future<List<VerseModel>> getAllVerses() async => _verses.values.toList();

  Future<List<VerseModel>> getVersesByBook(String book) async =>
      _verses.values.where((verse) => verse.book == book).toList();

  Future<List<VerseModel>> getVersesByChapter(String book, int chapter) async =>
      _verses.values
          .where((verse) => verse.book == book && verse.chapter == chapter)
          .sortedBy<num>((verse) => verse.verse);

  Future<List<VerseModel>> searchVerses({
    String? query,
    String? book,
    int? chapter,
    int limit = 50,
  }) async {
    Iterable<VerseModel> verses = _verses.values;
    if (book != null) verses = verses.where((v) => v.book == book);
    if (chapter != null) verses = verses.where((v) => v.chapter == chapter);
    if (query != null && query.isNotEmpty) {
      final q = query.toLowerCase();
      verses = verses.where((v) =>
          v.text.toLowerCase().contains(q) ||
          v.reference.toLowerCase().contains(q));
    }
    return verses.take(limit).toList();
  }

  Future<VerseModel?> getRandomVerse() async {
    final verses = _verses.values.toList();
    if (verses.isEmpty) return null;
    final randomIndex = DateTime.now().millisecondsSinceEpoch % verses.length;
    return verses[randomIndex];
  }

  Future<void> likeVerse(String verseId, String userId) async {
    final verse = _verses.get(verseId);
    if (verse == null) return;
    final likedBy = {...verse.likedBy, userId}.toList();
    await updateVerse(verseId, {'likes': likedBy.length, 'likedBy': likedBy});
  }

  Future<void> unlikeVerse(String verseId, String userId) async {
    final verse = _verses.get(verseId);
    if (verse == null) return;
    final likedBy = verse.likedBy.where((id) => id != userId).toList();
    await updateVerse(verseId, {'likes': likedBy.length, 'likedBy': likedBy});
  }

  Future<void> saveVerse(String verseId, String userId) async {
    final verse = _verses.get(verseId);
    if (verse == null) return;
    final savedBy = {...verse.savedBy, userId}.toList();
    await updateVerse(verseId, {'saves': savedBy.length, 'savedBy': savedBy});
  }

  Future<void> unsaveVerse(String verseId, String userId) async {
    final verse = _verses.get(verseId);
    if (verse == null) return;
    final savedBy = verse.savedBy.where((id) => id != userId).toList();
    await updateVerse(verseId, {'saves': savedBy.length, 'savedBy': savedBy});
  }

  Future<void> deleteVerse(String verseId) => _verses.delete(verseId);

  // ============ DAILY VERSE OPERATIONS ============

  String _dateKey(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

  Future<void> createDailyVerse(DailyVerseModel dailyVerse) =>
      _dailyVerses.put(_dateKey(dailyVerse.date), dailyVerse);

  Future<DailyVerseModel?> getDailyVerse(DateTime date) async =>
      _dailyVerses.get(_dateKey(date));

  // ============ BLOG OPERATIONS ============

  /// Stores [post] and returns its ID (a new one if `post.id` is empty).
  Future<String> createBlogPost(BlogPostModel post) async {
    final id = _idOrNew(post.id);
    await _blogPosts.put(id, post.copyWith(id: id));
    return id;
  }

  Future<BlogPostModel?> getBlogPost(String postId) async => _blogPosts.get(postId);

  Future<void> updateBlogPost(String postId, Map<String, dynamic> updates) async {
    await _blogPosts.update(postId, {'updatedAt': DateTime.now(), ...updates});
  }

  Future<void> deleteBlogPost(String postId) async {
    await _blogPosts.delete(postId);
    for (final comment in _blogComments.values.where((c) => c.postId == postId).toList()) {
      await _blogComments.delete(comment.id);
    }
  }

  Iterable<BlogPostModel> get _publishedPosts =>
      _blogPosts.values.where((post) => post.status == BlogPostStatus.published);

  Future<List<BlogPostModel>> getBlogPosts({
    int limit = 20,
    BlogCategory? category,
    String? authorId,
    bool featuredOnly = false,
  }) async {
    var posts = _publishedPosts;
    if (category != null) posts = posts.where((p) => p.category == category);
    if (authorId != null) posts = posts.where((p) => p.authorId == authorId);
    if (featuredOnly) posts = posts.where((p) => p.isFeatured);
    return posts
        .sorted((a, b) => compareNewestFirst(a.publishedAt, b.publishedAt))
        .take(limit)
        .toList();
  }

  Future<List<BlogPostModel>> getAllBlogPosts() async => _blogPosts.values.toList();

  Future<List<BlogPostModel>> getFeaturedBlogPosts(int limit) =>
      getBlogPosts(limit: limit, featuredOnly: true);

  Future<List<BlogPostModel>> getPopularBlogPosts(int limit) async =>
      _publishedPosts.sorted((a, b) => b.views.compareTo(a.views)).take(limit).toList();

  Future<List<BlogPostModel>> getUserBlogPosts(String userId, int limit) =>
      getBlogPosts(limit: limit, authorId: userId);

  Future<void> incrementBlogPostViews(String postId) async {
    final post = _blogPosts.get(postId);
    if (post != null) {
      await _blogPosts.update(postId, {'views': post.views + 1});
    }
  }

  Future<void> likeBlogPost(String postId, String userId) async {
    final post = _blogPosts.get(postId);
    if (post == null) return;
    final likedBy = {...post.likedBy, userId}.toList();
    await _blogPosts.update(postId, {'likes': likedBy.length, 'likedBy': likedBy});
  }

  Future<void> unlikeBlogPost(String postId, String userId) async {
    final post = _blogPosts.get(postId);
    if (post == null) return;
    final likedBy = post.likedBy.where((id) => id != userId).toList();
    await _blogPosts.update(postId, {'likes': likedBy.length, 'likedBy': likedBy});
  }

  Future<void> bookmarkBlogPost(String postId, String userId) async {
    final post = _blogPosts.get(postId);
    if (post != null) {
      await _blogPosts.update(postId, {
        'bookmarkedBy': {...post.bookmarkedBy, userId}.toList(),
      });
    }
    final user = _users.get(userId);
    if (user != null) {
      await updateUser(userId, {
        'bookmarkedBlogPostIds': {...user.bookmarkedBlogPostIds, postId}.toList(),
      });
    }
  }

  Future<void> removeBookmarkBlogPost(String postId, String userId) async {
    final post = _blogPosts.get(postId);
    if (post != null) {
      await _blogPosts.update(postId, {
        'bookmarkedBy': post.bookmarkedBy.where((id) => id != userId).toList(),
      });
    }
    final user = _users.get(userId);
    if (user != null) {
      await updateUser(userId, {
        'bookmarkedBlogPostIds':
            user.bookmarkedBlogPostIds.where((id) => id != postId).toList(),
      });
    }
  }

  // ============ BLOG COMMENT OPERATIONS ============

  /// Stores [comment], bumps the post's comment count and returns the ID.
  Future<String> createBlogComment(BlogCommentModel comment) async {
    final id = _idOrNew(comment.id);
    await _blogComments.put(
      id,
      comment.copyWith(id: id, createdAt: comment.createdAt ?? DateTime.now()),
    );
    final post = _blogPosts.get(comment.postId);
    if (post != null) {
      await _blogPosts.update(comment.postId, {'comments': post.comments + 1});
    }
    return id;
  }

  /// Comments for [postId], oldest first.
  Future<List<BlogCommentModel>> getBlogComments(String postId) async => _blogComments
      .values
      .where((c) => c.postId == postId && !c.isDeleted)
      .sorted((a, b) => compareNewestFirst(b.createdAt, a.createdAt));

  Future<void> likeBlogComment(String postId, String commentId, String userId) async {
    final comment = _blogComments.get(commentId);
    if (comment == null) return;
    await _blogComments.update(commentId, {
      'likes': {...comment.likes, userId}.toList(),
    });
  }

  Future<void> unlikeBlogComment(String postId, String commentId, String userId) async {
    final comment = _blogComments.get(commentId);
    if (comment == null) return;
    await _blogComments.update(commentId, {
      'likes': comment.likes.where((id) => id != userId).toList(),
    });
  }

  // ============ CHAT OPERATIONS ============

  /// Stores [room] and returns its ID (a new one if `room.id` is empty).
  Future<String> createChatRoom(ChatRoomModel room) async {
    final id = _idOrNew(room.id);
    await _chatRooms.put(id, room.copyWith(id: id));
    return id;
  }

  Future<ChatRoomModel?> getChatRoom(String roomId) async => _chatRooms.get(roomId);

  Future<List<ChatRoomModel>> getChatRooms({ChatRoomType? type, int limit = 50}) async {
    var rooms = _chatRooms.values.where((room) => !room.isArchived);
    if (type != null) rooms = rooms.where((room) => room.type == type);
    return rooms
        .sorted((a, b) => compareNewestFirst(a.lastMessageAt, b.lastMessageAt))
        .take(limit)
        .toList();
  }

  Future<List<ChatRoomModel>> getAllChatRooms() async => _chatRooms.values.toList();

  Future<ChatRoomModel?> getGeneralChatRoom() async => _chatRooms.values.firstWhereOrNull(
      (room) => room.type == ChatRoomType.general && room.name == 'Gospel Discussions');

  /// Stores [message], updates the room's last-message info and returns the ID.
  Future<String> createChatMessage(ChatMessageModel message) async {
    final id = _idOrNew(message.id);
    final now = DateTime.now();
    await _chatMessages.put(
      id,
      message.copyWith(id: id, createdAt: message.createdAt ?? now),
    );

    final room = _chatRooms.get(message.roomId);
    if (room != null) {
      await _chatRooms.update(message.roomId, {
        'lastMessageId': id,
        'lastMessageSenderId': message.senderId,
        'lastMessageContent': message.content,
        'lastMessageAt': now,
        'messageCount': room.messageCount + 1,
      });
    }
    return id;
  }

  List<ChatMessageModel> _roomMessages(String roomId) => _chatMessages.values
      .where((m) => m.roomId == roomId)
      .sorted((a, b) => compareNewestFirst(b.createdAt, a.createdAt));

  /// Messages in [roomId], oldest first; emits again on every change.
  Stream<List<ChatMessageModel>> streamChatMessages(String roomId) async* {
    yield _roomMessages(roomId);
    yield* _chatMessages.watchAll().map((_) => _roomMessages(roomId));
  }

  /// The most recent [limit] messages in [roomId], oldest first.
  Future<List<ChatMessageModel>> getChatMessages(String roomId, {int limit = 50}) async {
    final messages = _roomMessages(roomId);
    return messages.sublist(messages.length > limit ? messages.length - limit : 0);
  }

  Future<List<ChatMessageModel>> getRecentChatMessages(String roomId, {int limit = 50}) =>
      getChatMessages(roomId, limit: limit);

  Future<void> updateChatMessage(
      String roomId, String messageId, Map<String, dynamic> updates) async {
    await _chatMessages.update(messageId, {'updatedAt': DateTime.now(), ...updates});
  }

  Future<void> likeChatMessage(String roomId, String messageId, String userId) async {
    final message = _chatMessages.get(messageId);
    if (message == null) return;
    final likedBy = {...message.likedBy, userId}.toList();
    await _chatMessages.update(messageId, {'likedBy': likedBy, 'likes': likedBy.length});
  }

  Future<void> joinChatRoom(String roomId, String userId) async {
    final room = _chatRooms.get(roomId);
    if (room == null) return;
    await _chatRooms.update(roomId, {
      'memberIds': {...room.memberIds, userId}.toList(),
      'memberJoinDates': {...room.memberJoinDates, userId: DateTime.now()},
    });
  }

  Future<void> leaveChatRoom(String roomId, String userId) async {
    final room = _chatRooms.get(roomId);
    if (room == null) return;
    await _chatRooms.update(roomId, {
      'memberIds': room.memberIds.where((id) => id != userId).toList(),
      'memberJoinDates': Map.of(room.memberJoinDates)..remove(userId),
    });
  }

  Future<void> updateChatRoom(String roomId, Map<String, dynamic> updates) async {
    await _chatRooms.update(roomId, {'updatedAt': DateTime.now(), ...updates});
  }

  Future<void> deleteChatRoom(String roomId) async {
    await _chatRooms.delete(roomId);
    for (final message in _roomMessages(roomId)) {
      await _chatMessages.delete(message.id);
    }
  }

  // ============ FAITH JOURNEY OPERATIONS ============

  Future<void> createFaithJourney(FaithJourney journey) =>
      _faithJourneys.put(journey.userId, journey);

  Future<FaithJourney?> getFaithJourney(String userId) async => _faithJourneys.get(userId);

  Future<void> updateFaithJourney(String userId, Map<String, dynamic> updates) async {
    await _faithJourneys.update(userId, {'lastUpdatedAt': DateTime.now(), ...updates});
  }

  Future<void> deleteFaithJourney(String userId) => _faithJourneys.delete(userId);

  Stream<FaithJourney?> streamFaithJourney(String userId) => _faithJourneys.watchKey(userId);

  // ============ READING HABIT OPERATIONS ============

  Future<ReadingHabit?> getReadingHabit(String userId) async => _readingHabits.get(userId);

  Future<void> updateReadingHabit(String userId, Map<String, dynamic> updates) async {
    await _readingHabits.update(userId, updates);
  }

  Future<void> createReadingHabit(ReadingHabit habit) =>
      _readingHabits.put(habit.userId, habit);

  Future<void> deleteReadingHabit(String userId) => _readingHabits.delete(userId);

  Stream<ReadingHabit?> streamReadingHabit(String userId) => _readingHabits.watchKey(userId);

  Future<void> recordReadingSession(ReadingSession session) =>
      _readingSessions.put(session.id, session);

  Future<List<ReadingSession>> getReadingSessions(String userId) async => _readingSessions
      .values
      .where((s) => s.userId == userId)
      .sorted((a, b) => b.startedAt.compareTo(a.startedAt));

  // ============ SUBSCRIPTION OPERATIONS ============

  /// Stores [subscription] and returns its ID (a new one if its ID is empty).
  Future<String> createSubscription(Subscription subscription) async {
    final id = _idOrNew(subscription.id);
    await _subscriptions.put(id, subscription.copyWith(id: id));
    return id;
  }

  /// The active subscription for [userId] that ends last, if any.
  Future<Subscription?> getActiveSubscription(String userId) async => _subscriptions.values
      .where((sub) => sub.userId == userId && sub.isActive)
      .sorted((a, b) => b.endDate.compareTo(a.endDate))
      .firstOrNull;

  Future<List<Subscription>> getUserSubscriptions(String userId) async => _subscriptions
      .values
      .where((sub) => sub.userId == userId)
      .sorted((a, b) => b.startDate.compareTo(a.startDate));

  Future<Subscription?> getSubscription(String subscriptionId) async =>
      _subscriptions.get(subscriptionId);

  Future<void> updateSubscription(String subscriptionId, Map<String, dynamic> updates) async {
    await _subscriptions.update(subscriptionId, {'updatedAt': DateTime.now(), ...updates});
  }

  Future<void> deleteSubscription(String subscriptionId) =>
      _subscriptions.delete(subscriptionId);

  // ============ PAYMENT OPERATIONS ============

  /// Stores [payment] and returns its ID (a new one if its ID is empty).
  Future<String> createPayment(Payment payment) async {
    final id = _idOrNew(payment.id);
    await _payments.put(id, payment.copyWith(id: id));
    return id;
  }

  Future<Payment?> getPayment(String paymentId) async => _payments.get(paymentId);

  Future<List<Payment>> getUserPayments(String userId) async => _payments.values
      .where((p) => p.userId == userId)
      .sorted((a, b) => compareNewestFirst(a.createdAt, b.createdAt));

  Future<void> updatePayment(String paymentId, Map<String, dynamic> updates) async {
    await _payments.update(paymentId, updates);
  }

  Future<void> deletePayment(String paymentId) => _payments.delete(paymentId);

  // ============ APP SETTINGS ============

  Box get _appSettingsBox => Hive.box(kAppSettingsBox);

  T? getAppSetting<T>(String key) => _appSettingsBox.get(key) as T?;

  Future<void> setAppSetting(String key, dynamic value) async {
    await _appSettingsBox.put(key, value);
  }

  // ============ MODERATION OPERATIONS ============

  Future<void> createModerationReport(ModerationReportModel report) =>
      _moderationReports.put(report.id, report);

  Future<ModerationReportModel?> getModerationReport(String reportId) async =>
      _moderationReports.get(reportId);

  Future<List<ModerationReportModel>> getModerationReports({
    ModerationStatus? status,
    int limit = 50,
  }) async {
    var reports = _moderationReports.values;
    if (status != null) reports = reports.where((r) => r.status == status);
    return reports.take(limit).toList();
  }

  Future<void> updateModerationReport(String reportId, Map<String, dynamic> updates) async {
    await _moderationReports.update(reportId, updates);
  }

  Future<void> deleteModerationReport(String reportId) =>
      _moderationReports.delete(reportId);

  // ============ BATCH OPERATIONS ============

  // Hive has no batch API, so operations run one after another.
  Future<void> batchWrite(List<Future<void> Function()> operations) async {
    for (final operation in operations) {
      await operation();
    }
  }
}
