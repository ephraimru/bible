import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../models/user_model.dart';
import '../models/verse_model.dart';
import '../models/blog_model.dart';
import '../models/chat_model.dart';
import '../models/faith_journey_model.dart';
import '../models/premium_model.dart';

// Hive box names
const String kUsersBox = 'users';
const String kVersesBox = 'verses';
const String kBlogPostsBox = 'blog_posts';
const String kChatRoomsBox = 'chat_rooms';
const String kFaithJourneysBox = 'faith_journeys';
const String kReadingHabitsBox = 'reading_habits';
const String kSubscriptionsBox = 'subscriptions';
const String kPaymentsBox = 'payments';
const String kDailyVersesBox = 'daily_verses';
const String kAppSettingsBox = 'app_settings';

// Local Storage Service Provider
final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

class LocalStorageService {
  static const Uuid _uuid = Uuid();
  
  // Initialize Hive
  Future<void> initialize() async {
    await Hive.initFlutter();
    
    // Register adapters
    _registerAdapters();
    
    // Open all boxes
    await _openBoxes();
  }

  void _registerAdapters() {
    // Register custom adapters if needed
    // Hive.registerAdapter(UserModelAdapter());
    // For now, we'll use JSON serialization
  }

  Future<void> _openBoxes() async {
    await Hive.openBox<UserModel>(kUsersBox);
    await Hive.openBox<VerseModel>(kVersesBox);
    await Hive.openBox<BlogPostModel>(kBlogPostsBox);
    await Hive.openBox<ChatRoomModel>(kChatRoomsBox);
    await Hive.openBox<FaithJourney>(kFaithJourneysBox);
    await Hive.openBox<ReadingHabit>(kReadingHabitsBox);
    await Hive.openBox<Subscription>(kSubscriptionsBox);
    await Hive.openBox<Payment>(kPaymentsBox);
    await Hive.openBox<DailyVerseModel>(kDailyVersesBox);
    await Hive.openBox(kAppSettingsBox);
  }

  // Generate unique ID
  String generateId() {
    return _uuid.v4();
  }

  // Close all boxes
  Future<void> close() async {
    await Hive.close();
  }

  // Clear all data
  Future<void> clearAll() async {
    final boxNames = [
      kUsersBox,
      kVersesBox,
      kBlogPostsBox,
      kChatRoomsBox,
      kFaithJourneysBox,
      kReadingHabitsBox,
      kSubscriptionsBox,
      kPaymentsBox,
      kDailyVersesBox,
      kAppSettingsBox,
    ];
    
    for (final boxName in boxNames) {
      final box = Hive.box(boxName);
      await box.clear();
    }
  }

  // ============ USER OPERATIONS ============

  Box<UserModel> get _usersBox => Hive.box<UserModel>(kUsersBox);

  // Create user
  Future<void> createUser(UserModel user) async {
    await _usersBox.put(user.id, user);
  }

  // Get user by ID
  Future<UserModel?> getUser(String userId) async {
    return _usersBox.get(userId);
  }

  // Update user
  Future<void> updateUser(String userId, Map<String, dynamic> updates) async {
    final user = _usersBox.get(userId);
    if (user != null) {
      final updatedUser = user.copyWith(
        displayName: updates['displayName'] as String? ?? user.displayName,
        photoUrl: updates['photoUrl'] as String? ?? user.photoUrl,
        bio: updates['bio'] as String? ?? user.bio,
        role: updates['role'] as UserRole? ?? user.role,
        premiumTier: updates['premiumTier'] as PremiumTier? ?? user.premiumTier,
        followingCount: updates['followingCount'] as int? ?? user.followingCount,
        followersCount: updates['followersCount'] as int? ?? user.followersCount,
        savedVersesCount: updates['savedVersesCount'] as int? ?? user.savedVersesCount,
        likedVersesCount: updates['likedVersesCount'] as int? ?? user.likedVersesCount,
        blogPostsCount: updates['blogPostsCount'] as int? ?? user.blogPostsCount,
        savedVerseIds: updates['savedVerseIds'] as List<String>? ?? user.savedVerseIds,
        likedVerseIds: updates['likedVerseIds'] as List<String>? ?? user.likedVerseIds,
        bookmarkedBlogPostIds: updates['bookmarkedBlogPostIds'] as List<String>? ?? user.bookmarkedBlogPostIds,
        readingStats: updates['readingStats'] as Map<String, dynamic>? ?? user.readingStats,
        consecutiveReadingDays: updates['consecutiveReadingDays'] as int? ?? user.consecutiveReadingDays,
        totalReadingDays: updates['totalReadingDays'] as int? ?? user.totalReadingDays,
        streakStartDate: updates['streakStartDate'] as int? ?? user.streakStartDate,
        badges: updates['badges'] as List<String>? ?? user.badges,
        hasPaidToSkipLadder: updates['hasPaidToSkipLadder'] as bool? ?? user.hasPaidToSkipLadder,
        lastReadingDate: updates['lastReadingDate'] as DateTime? ?? user.lastReadingDate,
        lastNotificationDate: updates['lastNotificationDate'] as DateTime? ?? user.lastNotificationDate,
        chosenTitle: updates['chosenTitle'] as String? ?? user.chosenTitle,
        blockedUserIds: updates['blockedUserIds'] as List<String>? ?? user.blockedUserIds,
        preferences: updates['preferences'] as Map<String, bool>? ?? user.preferences,
        updatedAt: DateTime.now(),
      );
      await _usersBox.put(userId, updatedUser);
    }
  }

  // Delete user
  Future<void> deleteUser(String userId) async {
    await _usersBox.delete(userId);
  }

  // Get all users
  Future<List<UserModel>> getAllUsers() async {
    return _usersBox.values.toList();
  }

  // Search users
  Future<List<UserModel>> searchUsers({String? query, int limit = 20}) async {
    final allUsers = _usersBox.values.toList();
    
    if (query == null || query.isEmpty) {
      return allUsers.take(limit).toList();
    }
    
    return allUsers
        .where((user) => 
          user.displayName.toLowerCase().contains(query.toLowerCase()) ||
          user.email.toLowerCase().contains(query.toLowerCase())
        )
        .take(limit)
        .toList();
  }

  // Increment user following count
  Future<void> incrementFollowingCount(String userId) async {
    final user = _usersBox.get(userId);
    if (user != null) {
      final updatedUser = user.copyWith(
        followingCount: user.followingCount + 1,
        updatedAt: DateTime.now(),
      );
      await _usersBox.put(userId, updatedUser);
    }
  }

  // Increment user followers count
  Future<void> incrementFollowersCount(String userId) async {
    final user = _usersBox.get(userId);
    if (user != null) {
      final updatedUser = user.copyWith(
        followersCount: user.followersCount + 1,
        updatedAt: DateTime.now(),
      );
      await _usersBox.put(userId, updatedUser);
    }
  }

  // Add saved verse to user
  Future<void> addSavedVerse(String userId, String verseId) async {
    final user = _usersBox.get(userId);
    if (user != null) {
      final savedVerseIds = List<String>.from(user.savedVerseIds);
      if (!savedVerseIds.contains(verseId)) {
        savedVerseIds.add(verseId);
      }
      final updatedUser = user.copyWith(
        savedVerseIds: savedVerseIds,
        savedVersesCount: savedVerseIds.length,
        updatedAt: DateTime.now(),
      );
      await _usersBox.put(userId, updatedUser);
    }
  }

  // Remove saved verse from user
  Future<void> removeSavedVerse(String userId, String verseId) async {
    final user = _usersBox.get(userId);
    if (user != null) {
      final savedVerseIds = List<String>.from(user.savedVerseIds);
      savedVerseIds.remove(verseId);
      final updatedUser = user.copyWith(
        savedVerseIds: savedVerseIds,
        savedVersesCount: savedVerseIds.length,
        updatedAt: DateTime.now(),
      );
      await _usersBox.put(userId, updatedUser);
    }
  }

  // Add liked verse to user
  Future<void> addLikedVerse(String userId, String verseId) async {
    final user = _usersBox.get(userId);
    if (user != null) {
      final likedVerseIds = List<String>.from(user.likedVerseIds);
      if (!likedVerseIds.contains(verseId)) {
        likedVerseIds.add(verseId);
      }
      final updatedUser = user.copyWith(
        likedVerseIds: likedVerseIds,
        likedVersesCount: likedVerseIds.length,
        updatedAt: DateTime.now(),
      );
      await _usersBox.put(userId, updatedUser);
    }
  }

  // Remove liked verse from user
  Future<void> removeLikedVerse(String userId, String verseId) async {
    final user = _usersBox.get(userId);
    if (user != null) {
      final likedVerseIds = List<String>.from(user.likedVerseIds);
      likedVerseIds.remove(verseId);
      final updatedUser = user.copyWith(
        likedVerseIds: likedVerseIds,
        likedVersesCount: likedVerseIds.length,
        updatedAt: DateTime.now(),
      );
      await _usersBox.put(userId, updatedUser);
    }
  }

  // Stream user by ID
  Stream<UserModel?> streamUser(String userId) {
    return _usersBox.watch(key: userId).map((event) => event.value);
  }

  // ============ VERSE OPERATIONS ============

  Box<VerseModel> get _versesBox => Hive.box<VerseModel>(kVersesBox);

  // Create verse
  Future<void> createVerse(VerseModel verse) async {
    await _versesBox.put(verse.id, verse);
  }

  // Get verse by ID
  Future<VerseModel?> getVerse(String verseId) async {
    return _versesBox.get(verseId);
  }

  // Update verse
  Future<void> updateVerse(String verseId, Map<String, dynamic> updates) async {
    final verse = _versesBox.get(verseId);
    if (verse != null) {
      final updatedVerse = verse.copyWith(
        reference: updates['reference'] as String? ?? verse.reference,
        text: updates['text'] as String? ?? verse.text,
        book: updates['book'] as String? ?? verse.book,
        chapter: updates['chapter'] as int? ?? verse.chapter,
        verse: updates['verse'] as int? ?? verse.verse,
        translation: updates['translation'] as String? ?? verse.translation,
        imageUrl: updates['imageUrl'] as String? ?? verse.imageUrl,
        likes: updates['likes'] as int? ?? verse.likes,
        saves: updates['saves'] as int? ?? verse.saves,
        tags: updates['tags'] as List<String>? ?? verse.tags,
        likedBy: updates['likedBy'] as List<String>? ?? verse.likedBy,
        savedBy: updates['savedBy'] as List<String>? ?? verse.savedBy,
      );
      await _versesBox.put(verseId, updatedVerse);
    }
  }

  // Get all verses
  Future<List<VerseModel>> getAllVerses() async {
    return _versesBox.values.toList();
  }

  // Get verses by book
  Future<List<VerseModel>> getVersesByBook(String book) async {
    return _versesBox.values
        .where((verse) => verse.book == book)
        .toList();
  }

  // Get verses by book and chapter
  Future<List<VerseModel>> getVersesByChapter(String book, int chapter) async {
    return _versesBox.values
        .where((verse) => verse.book == book && verse.chapter == chapter)
        .toList();
  }

  // Search verses
  Future<List<VerseModel>> searchVerses({String? query, String? book, int? chapter, int limit = 50}) async {
    var verses = _versesBox.values.toList();
    
    if (book != null) {
      verses = verses.where((v) => v.book == book).toList();
    }
    if (chapter != null) {
      verses = verses.where((v) => v.chapter == chapter).toList();
    }
    if (query != null && query.isNotEmpty) {
      verses = verses.where((v) => 
        v.text.toLowerCase().contains(query.toLowerCase())
      ).toList();
    }
    
    return verses.take(limit).toList();
  }

  // Get random verse
  Future<VerseModel?> getRandomVerse() async {
    final verses = _versesBox.values.toList();
    if (verses.isEmpty) return null;
    
    final randomIndex = DateTime.now().millisecondsSinceEpoch % verses.length;
    return verses.elementAt(randomIndex);
  }

  // Like verse
  Future<void> likeVerse(String verseId, String userId) async {
    final verse = _versesBox.get(verseId);
    if (verse != null) {
      final likedBy = List<String>.from(verse.likedBy);
      if (!likedBy.contains(userId)) {
        likedBy.add(userId);
      }
      final updatedVerse = verse.copyWith(
        likes: likedBy.length,
        likedBy: likedBy,
      );
      await _versesBox.put(verseId, updatedVerse);
    }
  }

  // Unlike verse
  Future<void> unlikeVerse(String verseId, String userId) async {
    final verse = _versesBox.get(verseId);
    if (verse != null) {
      final likedBy = List<String>.from(verse.likedBy);
      likedBy.remove(userId);
      final updatedVerse = verse.copyWith(
        likes: likedBy.length,
        likedBy: likedBy,
      );
      await _versesBox.put(verseId, updatedVerse);
    }
  }

  // Save verse
  Future<void> saveVerse(String verseId, String userId) async {
    final verse = _versesBox.get(verseId);
    if (verse != null) {
      final savedBy = List<String>.from(verse.savedBy);
      if (!savedBy.contains(userId)) {
        savedBy.add(userId);
      }
      final updatedVerse = verse.copyWith(
        saves: savedBy.length,
        savedBy: savedBy,
      );
      await _versesBox.put(verseId, updatedVerse);
    }
  }

  // Unsaved verse
  Future<void> unsaveVerse(String verseId, String userId) async {
    final verse = _versesBox.get(verseId);
    if (verse != null) {
      final savedBy = List<String>.from(verse.savedBy);
      savedBy.remove(userId);
      final updatedVerse = verse.copyWith(
        saves: savedBy.length,
        savedBy: savedBy,
      );
      await _versesBox.put(verseId, updatedVerse);
    }
  }

  // Delete verse
  Future<void> deleteVerse(String verseId) async {
    await _versesBox.delete(verseId);
  }

  // ============ DAILY VERSE OPERATIONS ============

  Box<DailyVerseModel> get _dailyVersesBox => Hive.box<DailyVerseModel>(kDailyVersesBox);

  // Create daily verse
  Future<void> createDailyVerse(DailyVerseModel dailyVerse) async {
    final dateStr = '${dailyVerse.date.year}-${dailyVerse.date.month.toString().padLeft(2, '0')}-${dailyVerse.date.day.toString().padLeft(2, '0')}';
    await _dailyVersesBox.put(dateStr, dailyVerse);
  }

  // Get daily verse
  Future<DailyVerseModel?> getDailyVerse(DateTime date) async {
    final dateStr = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    return _dailyVersesBox.get(dateStr);
  }

  // ============ BLOG OPERATIONS ============

  Box<BlogPostModel> get _blogPostsBox => Hive.box<BlogPostModel>(kBlogPostsBox);

  // Create blog post
  Future<String> createBlogPost(BlogPostModel post) async {
    final id = _uuid.v4();
    final postWithId = post.copyWith(id: id);
    await _blogPostsBox.put(id, postWithId);
    return id;
  }

  // Get blog post by ID
  Future<BlogPostModel?> getBlogPost(String postId) async {
    return _blogPostsBox.get(postId);
  }

  // Update blog post
  Future<void> updateBlogPost(String postId, Map<String, dynamic> updates) async {
    final post = _blogPostsBox.get(postId);
    if (post != null) {
      final updatedPost = post.copyWith(
        title: updates['title'] as String? ?? post.title,
        content: updates['content'] as String? ?? post.content,
        authorId: updates['authorId'] as String? ?? post.authorId,
        category: updates['category'] as BlogCategory? ?? post.category,
        status: updates['status'] as BlogPostStatus? ?? post.status,
        tags: updates['tags'] as List<String>? ?? post.tags,
        views: updates['views'] as int? ?? post.views,
        likes: updates['likes'] as int? ?? post.likes,
        comments: updates['comments'] as int? ?? post.comments,
        isFeatured: updates['isFeatured'] as bool? ?? post.isFeatured,
        publishedAt: updates['publishedAt'] as DateTime? ?? post.publishedAt,
        updatedAt: DateTime.now(),
      );
      await _blogPostsBox.put(postId, updatedPost);
    }
  }

  // Delete blog post
  Future<void> deleteBlogPost(String postId) async {
    await _blogPostsBox.delete(postId);
  }

  // Get all blog posts
  Future<List<BlogPostModel>> getBlogPosts({int limit = 20, BlogCategory? category, String? authorId, bool featuredOnly = false}) async {
    var posts = _blogPostsBox.values.toList();
    
    posts = posts.where((post) => post.status == BlogPostStatus.published).toList();
    
    if (category != null) {
      posts = posts.where((post) => post.category == category).toList();
    }
    if (authorId != null) {
      posts = posts.where((post) => post.authorId == authorId).toList();
    }
    if (featuredOnly) {
      posts = posts.where((post) => post.isFeatured).toList();
    }
    
    // Sort by publishedAt descending
    posts.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
    
    return posts.take(limit).toList();
  }

  // Get all blog posts (no filtering)
  Future<List<BlogPostModel>> getAllBlogPosts() async {
    return _blogPostsBox.values.toList();
  }

  // Get featured blog posts
  Future<List<BlogPostModel>> getFeaturedBlogPosts(int limit) async {
    return _blogPostsBox.values
        .where((post) => post.isFeatured && post.status == BlogPostStatus.published)
        .toList()
        ..sort((a, b) => b.publishedAt.compareTo(a.publishedAt))
        .take(limit)
        .toList();
  }

  // Get popular blog posts
  Future<List<BlogPostModel>> getPopularBlogPosts(int limit) async {
    return _blogPostsBox.values
        .where((post) => post.status == BlogPostStatus.published)
        .toList()
        ..sort((a, b) => b.views.compareTo(a.views))
        .take(limit)
        .toList();
  }

  // Get user blog posts
  Future<List<BlogPostModel>> getUserBlogPosts(String userId, int limit) async {
    return _blogPostsBox.values
        .where((post) => post.authorId == userId && post.status == BlogPostStatus.published)
        .toList()
        ..sort((a, b) => b.publishedAt.compareTo(a.publishedAt))
        .take(limit)
        .toList();
  }

  // Increment blog post views
  Future<void> incrementBlogPostViews(String postId) async {
    final post = _blogPostsBox.get(postId);
    if (post != null) {
      final updatedPost = post.copyWith(
        views: post.views + 1,
      );
      await _blogPostsBox.put(postId, updatedPost);
    }
  }

  // Like blog post
  Future<void> likeBlogPost(String postId, String userId) async {
    final post = _blogPostsBox.get(postId);
    if (post != null) {
      final likedBy = List<String>.from(post.likedBy);
      if (!likedBy.contains(userId)) {
        likedBy.add(userId);
      }
      final updatedPost = post.copyWith(
        likes: likedBy.length,
        likedBy: likedBy,
      );
      await _blogPostsBox.put(postId, updatedPost);
    }
  }

  // Unlike blog post
  Future<void> unlikeBlogPost(String postId, String userId) async {
    final post = _blogPostsBox.get(postId);
    if (post != null) {
      final likedBy = List<String>.from(post.likedBy);
      likedBy.remove(userId);
      final updatedPost = post.copyWith(
        likes: likedBy.length,
        likedBy: likedBy,
      );
      await _blogPostsBox.put(postId, updatedPost);
    }
  }

  // ============ CHAT OPERATIONS ============

  Box<ChatRoomModel> get _chatRoomsBox => Hive.box<ChatRoomModel>(kChatRoomsBox);

  // Create chat room
  Future<String> createChatRoom(ChatRoomModel room) async {
    final id = _uuid.v4();
    final roomWithId = room.copyWith(id: id);
    await _chatRoomsBox.put(id, roomWithId);
    return id;
  }

  // Get chat room by ID
  Future<ChatRoomModel?> getChatRoom(String roomId) async {
    return _chatRoomsBox.get(roomId);
  }

  // Get all chat rooms
  Future<List<ChatRoomModel>> getChatRooms({ChatRoomType? type, int limit = 50}) async {
    var rooms = _chatRoomsBox.values.toList();
    
    rooms = rooms.where((room) => !room.isArchived).toList();
    
    if (type != null) {
      rooms = rooms.where((room) => room.type == type).toList();
    }
    
    // Sort by lastMessageAt descending
    rooms.sort((a, b) => b.lastMessageAt.compareTo(a.lastMessageAt));
    
    return rooms.take(limit).toList();
  }

  // Get all chat rooms (no filtering)
  Future<List<ChatRoomModel>> getAllChatRooms() async {
    return _chatRoomsBox.values.toList();
  }

  // Get general chat room
  Future<ChatRoomModel?> getGeneralChatRoom() async {
    return _chatRoomsBox.values
        .firstWhere(
          (room) => room.type == ChatRoomType.general && room.name == 'Gospel Discussions',
          orElse: () => null,
        );
  }

  // Create chat message
  Future<String> createChatMessage(ChatMessageModel message) async {
    final id = _uuid.v4();
    final messageWithId = message.copyWith(id: id);
    
    // Get or create messages sub-box
    final messagesBox = Hive.box<ChatMessageModel>('${kChatRoomsBox}_messages_${message.roomId}');
    await messagesBox.put(id, messageWithId);
    
    // Update room
    final room = _chatRoomsBox.get(message.roomId);
    if (room != null) {
      final updatedRoom = room.copyWith(
        lastMessageId: id,
        lastMessageSenderId: message.senderId,
        lastMessageContent: message.content,
        lastMessageAt: DateTime.now(),
        messageCount: room.messageCount + 1,
      );
      await _chatRoomsBox.put(message.roomId, updatedRoom);
    }
    
    return id;
  }

  // Get chat messages
  Stream<List<ChatMessageModel>> streamChatMessages(String roomId) {
    final messagesBox = Hive.box<ChatMessageModel>('${kChatRoomsBox}_messages_${roomId}');
    return messagesBox.watch().map((event) => event.values.toList());
  }

  // Get recent chat messages
  Future<List<ChatMessageModel>> getRecentChatMessages(String roomId, {int limit = 50}) async {
    final messagesBox = Hive.box<ChatMessageModel>('${kChatRoomsBox}_messages_${roomId}');
    return messagesBox.values
        .toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt))
        .take(limit)
        .toList();
  }

  // Join chat room
  Future<void> joinChatRoom(String roomId, String userId) async {
    final room = _chatRoomsBox.get(roomId);
    if (room != null) {
      final memberIds = List<String>.from(room.memberIds);
      if (!memberIds.contains(userId)) {
        memberIds.add(userId);
      }
      final memberJoinDates = Map<String, DateTime>.from(room.memberJoinDates);
      memberJoinDates[userId] = DateTime.now();
      
      final updatedRoom = room.copyWith(
        memberIds: memberIds,
        memberJoinDates: memberJoinDates,
      );
      await _chatRoomsBox.put(roomId, updatedRoom);
    }
  }

  // Leave chat room
  Future<void> leaveChatRoom(String roomId, String userId) async {
    final room = _chatRoomsBox.get(roomId);
    if (room != null) {
      final memberIds = List<String>.from(room.memberIds);
      memberIds.remove(userId);
      final memberJoinDates = Map<String, DateTime>.from(room.memberJoinDates);
      memberJoinDates.remove(userId);
      
      final updatedRoom = room.copyWith(
        memberIds: memberIds,
        memberJoinDates: memberJoinDates,
      );
      await _chatRoomsBox.put(roomId, updatedRoom);
    }
  }

  // Update chat room
  Future<void> updateChatRoom(String roomId, Map<String, dynamic> updates) async {
    final room = _chatRoomsBox.get(roomId);
    if (room != null) {
      final updatedRoom = room.copyWith(
        name: updates['name'] as String? ?? room.name,
        description: updates['description'] as String? ?? room.description,
        coverImageUrl: updates['coverImageUrl'] as String? ?? room.coverImageUrl,
        memberIds: updates['memberIds'] as List<String>? ?? room.memberIds,
        adminIds: updates['adminIds'] as List<String>? ?? room.adminIds,
        moderatorIds: updates['moderatorIds'] as List<String>? ?? room.moderatorIds,
        messageCount: updates['messageCount'] as int? ?? room.messageCount,
        unreadCount: updates['unreadCount'] as int? ?? room.unreadCount,
        lastMessageAt: updates['lastMessageAt'] as DateTime? ?? room.lastMessageAt,
        lastMessageId: updates['lastMessageId'] as String? ?? room.lastMessageId,
        lastMessageSenderId: updates['lastMessageSenderId'] as String? ?? room.lastMessageSenderId,
        lastMessageContent: updates['lastMessageContent'] as String? ?? room.lastMessageContent,
        isPrivate: updates['isPrivate'] as bool? ?? room.isPrivate,
        isArchived: updates['isArchived'] as bool? ?? room.isArchived,
        tags: updates['tags'] as List<String>? ?? room.tags,
        memberJoinDates: updates['memberJoinDates'] as Map<String, DateTime>? ?? room.memberJoinDates,
      );
      await _chatRoomsBox.put(roomId, updatedRoom);
    }
  }

  // Delete chat room
  Future<void> deleteChatRoom(String roomId) async {
    await _chatRoomsBox.delete(roomId);
  }

  // ============ FAITH JOURNEY OPERATIONS ============

  Box<FaithJourney> get _faithJourneyBox => Hive.box<FaithJourney>(kFaithJourneysBox);

  // Create faith journey
  Future<void> createFaithJourney(FaithJourney journey) async {
    await _faithJourneyBox.put(journey.userId, journey);
  }

  // Get faith journey by user ID
  Future<FaithJourney?> getFaithJourney(String userId) async {
    return _faithJourneyBox.get(userId);
  }

  // Update faith journey
  Future<void> updateFaithJourney(String userId, Map<String, dynamic> updates) async {
    final journey = _faithJourneyBox.get(userId);
    if (journey != null) {
      final updatedJourney = journey.copyWith(
        userId: updates['userId'] as String? ?? journey.userId,
        currentRole: updates['currentRole'] as UserRole? ?? journey.currentRole,
        progressList: updates['progressList'] as List<FaithProgress>? ?? journey.progressList,
        milestones: updates['milestones'] as List<FaithMilestone>? ?? journey.milestones,
        startedAt: updates['startedAt'] as DateTime? ?? journey.startedAt,
        lastUpdatedAt: DateTime.now(),
      );
      await _faithJourneyBox.put(userId, updatedJourney);
    }
  }

  // Delete faith journey
  Future<void> deleteFaithJourney(String userId) async {
    await _faithJourneyBox.delete(userId);
  }

  // Stream faith journey
  Stream<FaithJourney?> streamFaithJourney(String userId) {
    return _faithJourneyBox.watch(key: userId).map((event) => event.value);
  }

  // ============ READING HABIT OPERATIONS ============

  Box<ReadingHabit> get _readingHabitBox => Hive.box<ReadingHabit>(kReadingHabitsBox);

  // Get reading habit
  Future<ReadingHabit?> getReadingHabit(String userId) async {
    return _readingHabitBox.get(userId);
  }

  // Update reading habit
  Future<void> updateReadingHabit(String userId, Map<String, dynamic> updates) async {
    final habit = _readingHabitBox.get(userId);
    if (habit != null) {
      final updatedHabit = habit.copyWith(
        userId: updates['userId'] as String? ?? habit.userId,
        preferredHours: updates['preferredHours'] as List<int>? ?? habit.preferredHours,
        preferredDays: updates['preferredDays'] as List<int>? ?? habit.preferredDays,
        notificationsEnabled: updates['notificationsEnabled'] as bool? ?? habit.notificationsEnabled,
        recentSessions: updates['recentSessions'] as List<ReadingSession>? ?? habit.recentSessions,
        averageReadsPerDay: updates['averageReadsPerDay'] as double? ?? habit.averageReadsPerDay,
        averageDurationMinutes: updates['averageDurationMinutes'] as int? ?? habit.averageDurationMinutes,
        updatedAt: DateTime.now(),
      );
      await _readingHabitBox.put(userId, updatedHabit);
    }
  }

  // Create reading habit
  Future<void> createReadingHabit(ReadingHabit habit) async {
    await _readingHabitBox.put(habit.userId, habit);
  }

  // Delete reading habit
  Future<void> deleteReadingHabit(String userId) async {
    await _readingHabitBox.delete(userId);
  }

  // Stream reading habit
  Stream<ReadingHabit?> streamReadingHabit(String userId) {
    return _readingHabitBox.watch(key: userId).map((event) => event.value);
  }

  // Record reading session
  Future<void> recordReadingSession(ReadingSession session) async {
    final sessionsBox = Hive.box<ReadingSession>('${kReadingHabitsBox}_sessions_${session.userId}');
    await sessionsBox.put(session.id, session);
  }

  // ============ SUBSCRIPTION OPERATIONS ============

  Box<Subscription> get _subscriptionsBox => Hive.box<Subscription>(kSubscriptionsBox);

  // Create subscription
  Future<String> createSubscription(Subscription subscription) async {
    final id = _uuid.v4();
    final subscriptionWithId = subscription.copyWith(id: id);
    await _subscriptionsBox.put(id, subscriptionWithId);
    return id;
  }

  // Get active subscription
  Future<Subscription?> getActiveSubscription(String userId) async {
    return _subscriptionsBox.values
        .where((sub) => sub.userId == userId && sub.isActive)
        .toList()
        ..sort((a, b) => b.endDate.compareTo(a.endDate))
        .firstOrNull;
  }

  // Get user subscriptions
  Future<List<Subscription>> getUserSubscriptions(String userId) async {
    return _subscriptionsBox.values
        .where((sub) => sub.userId == userId)
        .toList()
        ..sort((a, b) => b.startDate.compareTo(a.startDate));
  }

  // Get subscription by ID
  Future<Subscription?> getSubscription(String subscriptionId) async {
    return _subscriptionsBox.get(subscriptionId);
  }

  // Update subscription
  Future<void> updateSubscription(String subscriptionId, Map<String, dynamic> updates) async {
    final sub = _subscriptionsBox.get(subscriptionId);
    if (sub != null) {
      final updatedSub = sub.copyWith(
        userId: updates['userId'] as String? ?? sub.userId,
        plan: updates['plan'] as SubscriptionPlan? ?? sub.plan,
        startDate: updates['startDate'] as DateTime? ?? sub.startDate,
        endDate: updates['endDate'] as DateTime? ?? sub.endDate,
        status: updates['status'] as PaymentStatus? ?? sub.status,
        paymentMethod: updates['paymentMethod'] as PaymentMethod? ?? sub.paymentMethod,
        amount: updates['amount'] as double? ?? sub.amount,
        transactionId: updates['transactionId'] as String? ?? sub.transactionId,
        autoRenew: updates['autoRenew'] as bool? ?? sub.autoRenew,
        isActive: updates['isActive'] as bool? ?? sub.isActive,
        isCancelled: updates['isCancelled'] as bool? ?? sub.isCancelled,
      );
      await _subscriptionsBox.put(subscriptionId, updatedSub);
    }
  }

  // Delete subscription
  Future<void> deleteSubscription(String subscriptionId) async {
    await _subscriptionsBox.delete(subscriptionId);
  }

  // ============ PAYMENT OPERATIONS ============

  Box<Payment> get _paymentsBox => Hive.box<Payment>(kPaymentsBox);

  // Create payment
  Future<String> createPayment(Payment payment) async {
    final id = _uuid.v4();
    final paymentWithId = payment.copyWith(id: id);
    await _paymentsBox.put(id, paymentWithId);
    return id;
  }

  // Get payment by ID
  Future<Payment?> getPayment(String paymentId) async {
    return _paymentsBox.get(paymentId);
  }

  // Get user payments
  Future<List<Payment>> getUserPayments(String userId) async {
    return _paymentsBox.values
        .where((p) => p.userId == userId)
        .toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  // Update payment
  Future<void> updatePayment(String paymentId, Map<String, dynamic> updates) async {
    final payment = _paymentsBox.get(paymentId);
    if (payment != null) {
      final updatedPayment = payment.copyWith(
        userId: updates['userId'] as String? ?? payment.userId,
        amount: updates['amount'] as double? ?? payment.amount,
        currency: updates['currency'] as String? ?? payment.currency,
        method: updates['method'] as PaymentMethod? ?? payment.method,
        status: updates['status'] as PaymentStatus? ?? payment.status,
        transactionId: updates['transactionId'] as String? ?? payment.transactionId,
        reference: updates['reference'] as String? ?? payment.reference,
        description: updates['description'] as String? ?? payment.description,
        completedAt: updates['completedAt'] as DateTime? ?? payment.completedAt,
      );
      await _paymentsBox.put(paymentId, updatedPayment);
    }
  }

  // Delete payment
  Future<void> deletePayment(String paymentId) async {
    await _paymentsBox.delete(paymentId);
  }

  // ============ APP SETTINGS ============

  Box get _appSettingsBox => Hive.box(kAppSettingsBox);

  // Get app setting
  T? getAppSetting<T>(String key) {
    return _appSettingsBox.get(key);
  }

  // Set app setting
  Future<void> setAppSetting(String key, dynamic value) async {
    await _appSettingsBox.put(key, value);
  }

  // ============ MODERATION OPERATIONS ============

  Box<ModerationReportModel> get _moderationReportsBox => Hive.box<ModerationReportModel>('moderation_reports');

  // Create moderation report
  Future<void> createModerationReport(ModerationReportModel report) async {
    await _moderationReportsBox.put(report.id, report);
  }

  // Get moderation report
  Future<ModerationReportModel?> getModerationReport(String reportId) async {
    return _moderationReportsBox.get(reportId);
  }

  // Get moderation reports
  Future<List<ModerationReportModel>> getModerationReports({ModerationStatus? status, int limit = 50}) async {
    var reports = _moderationReportsBox.values.toList();
    if (status != null) {
      reports = reports.where((r) => r.status == status).toList();
    }
    return reports.take(limit).toList();
  }

  // Update moderation report
  Future<void> updateModerationReport(String reportId, Map<String, dynamic> updates) async {
    final report = _moderationReportsBox.get(reportId);
    if (report != null) {
      final updatedReport = report.copyWith(
        status: updates['status'] as ModerationStatus? ?? report.status,
        reviewedBy: updates['reviewedBy'] as String? ?? report.reviewedBy,
        reviewedAt: updates['reviewedAt'] as DateTime? ?? report.reviewedAt,
        actionTaken: updates['actionTaken'] as bool? ?? report.actionTaken,
        actionDescription: updates['actionDescription'] as String? ?? report.actionDescription,
      );
      await _moderationReportsBox.put(reportId, updatedReport);
    }
  }

  // Delete moderation report
  Future<void> deleteModerationReport(String reportId) async {
    await _moderationReportsBox.delete(reportId);
  }

  // ============ BATCH OPERATIONS ============

  // Batch write
  Future<void> batchWrite(List<Function> operations) async {
    for (final operation in operations) {
      await operation();
    }
  }
}
