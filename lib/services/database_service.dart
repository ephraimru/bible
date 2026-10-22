import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';
import '../models/verse_model.dart';
import '../models/blog_model.dart';
import '../models/chat_model.dart';
import '../models/faith_journey_model.dart';
import '../models/premium_model.dart';
import 'local_storage_service.dart';

// Database Service Provider - uses LocalStorageService (Hive)
final databaseServiceProvider = Provider<DatabaseService>((ref) {
  return DatabaseService(
    localStorageService: ref.read(localStorageServiceProvider),
  );
});

class DatabaseService {
  final LocalStorageService _localStorageService;

  DatabaseService({
    required LocalStorageService localStorageService,
  }) : _localStorageService = localStorageService;

  // ============ USER OPERATIONS ============

  // Create user
  Future<void> createUser(UserModel user) async {
    await _localStorageService.createUser(user);
  }

  // Get user by ID
  Future<UserModel?> getUser(String userId) async {
    return _localStorageService.getUser(userId);
  }

  // Update user
  Future<void> updateUser(String userId, Map<String, dynamic> updates) async {
    await _localStorageService.updateUser(userId, updates);
  }

  // Delete user
  Future<void> deleteUser(String userId) async {
    await _localStorageService.deleteUser(userId);
  }

  // Stream user by ID
  Stream<UserModel?> streamUser(String userId) {
    return _localStorageService.streamUser(userId);
  }

  // Get all users
  Future<List<UserModel>> getAllUsers() async {
    return _localStorageService.getAllUsers();
  }

  // Search users
  Future<List<UserModel>> searchUsers({
    String? query,
    int limit = 20,
    String? roleFilter,
  }) async {
    return _localStorageService.searchUsers(query: query, limit: limit);
  }

  // Get users by role
  Future<List<UserModel>> getUsersByRole(UserRole role) async {
    final allUsers = await getAllUsers();
    return allUsers.where((user) => user.role == role).toList();
  }

  // Increment user following count
  Future<void> incrementFollowingCount(String userId) async {
    final user = await getUser(userId);
    if (user != null) {
      await updateUser(userId, {
        'followingCount': user.followingCount + 1,
        'updatedAt': DateTime.now(),
      });
    }
  }

  // Increment user followers count
  Future<void> incrementFollowersCount(String userId) async {
    final user = await getUser(userId);
    if (user != null) {
      await updateUser(userId, {
        'followersCount': user.followersCount + 1,
        'updatedAt': DateTime.now(),
      });
    }
  }

  // Add saved verse to user
  Future<void> addSavedVerse(String userId, String verseId) async {
    final user = await getUser(userId);
    if (user != null) {
      final savedVerseIds = List<String>.from(user.savedVerseIds);
      if (!savedVerseIds.contains(verseId)) {
        savedVerseIds.add(verseId);
      }
      await updateUser(userId, {
        'savedVerseIds': savedVerseIds,
        'savedVersesCount': savedVerseIds.length,
        'updatedAt': DateTime.now(),
      });
    }
  }

  // Remove saved verse from user
  Future<void> removeSavedVerse(String userId, String verseId) async {
    final user = await getUser(userId);
    if (user != null) {
      final savedVerseIds = List<String>.from(user.savedVerseIds);
      savedVerseIds.remove(verseId);
      await updateUser(userId, {
        'savedVerseIds': savedVerseIds,
        'savedVersesCount': savedVerseIds.length,
        'updatedAt': DateTime.now(),
      });
    }
  }

  // Add liked verse to user
  Future<void> addLikedVerse(String userId, String verseId) async {
    final user = await getUser(userId);
    if (user != null) {
      final likedVerseIds = List<String>.from(user.likedVerseIds);
      if (!likedVerseIds.contains(verseId)) {
        likedVerseIds.add(verseId);
      }
      await updateUser(userId, {
        'likedVerseIds': likedVerseIds,
        'likedVersesCount': likedVerseIds.length,
        'updatedAt': DateTime.now(),
      });
    }
  }

  // Remove liked verse from user
  Future<void> removeLikedVerse(String userId, String verseId) async {
    final user = await getUser(userId);
    if (user != null) {
      final likedVerseIds = List<String>.from(user.likedVerseIds);
      likedVerseIds.remove(verseId);
      await updateUser(userId, {
        'likedVerseIds': likedVerseIds,
        'likedVersesCount': likedVerseIds.length,
        'updatedAt': DateTime.now(),
      });
    }
  }

  // Follow user
  Future<void> followUser(String currentUserId, String targetUserId) async {
    final currentUser = await getUser(currentUserId);
    if (currentUser != null) {
      final following = List<String>.from(currentUser.followingUserIds);
      if (!following.contains(targetUserId)) {
        following.add(targetUserId);
      }
      await updateUser(currentUserId, {
        'followingUserIds': following,
        'followingCount': following.length,
        'updatedAt': DateTime.now(),
      });
      
      // Increment target user's followers count
      await incrementFollowersCount(targetUserId);
    }
  }

  // Unfollow user
  Future<void> unfollowUser(String currentUserId, String targetUserId) async {
    final currentUser = await getUser(currentUserId);
    if (currentUser != null) {
      final following = List<String>.from(currentUser.followingUserIds);
      following.remove(targetUserId);
      await updateUser(currentUserId, {
        'followingUserIds': following,
        'followingCount': following.length,
        'updatedAt': DateTime.now(),
      });
      
      // Decrement target user's followers count
      final targetUser = await getUser(targetUserId);
      if (targetUser != null) {
        await updateUser(targetUserId, {
          'followersCount': targetUser.followersCount - 1,
          'updatedAt': DateTime.now(),
        });
      }
    }
  }

  // ============ VERSE OPERATIONS ============

  // Create verse
  Future<void> createVerse(VerseModel verse) async {
    await _localStorageService.createVerse(verse);
  }

  // Get verse by ID
  Future<VerseModel?> getVerse(String verseId) async {
    return _localStorageService.getVerse(verseId);
  }

  // Update verse
  Future<void> updateVerse(String verseId, Map<String, dynamic> updates) async {
    await _localStorageService.updateVerse(verseId, updates);
  }

  // Delete verse
  Future<void> deleteVerse(String verseId) async {
    await _localStorageService.deleteVerse(verseId);
  }

  // Get all verses
  Future<List<VerseModel>> getAllVerses() async {
    return _localStorageService.getAllVerses();
  }

  // Get verses by book
  Future<List<VerseModel>> getVersesByBook(String book) async {
    final allVerses = await getAllVerses();
    return allVerses.where((verse) => verse.book == book).toList();
  }

  // Get verses by book and chapter
  Future<List<VerseModel>> getVersesByChapter(String book, int chapter) async {
    final allVerses = await getAllVerses();
    return allVerses
        .where((verse) => verse.book == book && verse.chapter == chapter)
        .toList();
  }

  // Search verses
  Future<List<VerseModel>> searchVerses({
    String? query,
    String? book,
    int? chapter,
    int limit = 50,
  }) async {
    final allVerses = await getAllVerses();
    
    var results = allVerses;
    
    if (book != null) {
      results = results.where((verse) => verse.book == book);
    }
    if (chapter != null) {
      results = results.where((verse) => verse.chapter == chapter);
    }
    if (query != null && query.isNotEmpty) {
      results = results.where((verse) => 
        verse.text.toLowerCase().contains(query.toLowerCase()) ||
        verse.reference.toLowerCase().contains(query.toLowerCase())
      );
    }
    
    return results.take(limit).toList();
  }

  // Get random verse
  Future<VerseModel?> getRandomVerse() async {
    final allVerses = await getAllVerses();
    if (allVerses.isEmpty) return null;
    
    final randomIndex = DateTime.now().millisecondsSinceEpoch % allVerses.length;
    return allVerses.elementAt(randomIndex);
  }

  // Get daily verse
  Future<DailyVerseModel?> getDailyVerse(DateTime date) async {
    return _localStorageService.getDailyVerse(date);
  }

  // Like verse
  Future<void> likeVerse(String verseId, String userId) async {
    final verse = await getVerse(verseId);
    if (verse != null) {
      final likedBy = List<String>.from(verse.likedBy);
      if (!likedBy.contains(userId)) {
        likedBy.add(userId);
      }
      await updateVerse(verseId, {
        'likes': likedBy.length,
        'likedBy': likedBy,
      });
    }
    await addLikedVerse(userId, verseId);
  }

  // Unlike verse
  Future<void> unlikeVerse(String verseId, String userId) async {
    final verse = await getVerse(verseId);
    if (verse != null) {
      final likedBy = List<String>.from(verse.likedBy);
      likedBy.remove(userId);
      await updateVerse(verseId, {
        'likes': likedBy.length,
        'likedBy': likedBy,
      });
    }
    await removeLikedVerse(userId, verseId);
  }

  // Save verse
  Future<void> saveVerse(String verseId, String userId) async {
    final verse = await getVerse(verseId);
    if (verse != null) {
      final savedBy = List<String>.from(verse.savedBy);
      if (!savedBy.contains(userId)) {
        savedBy.add(userId);
      }
      await updateVerse(verseId, {
        'saves': savedBy.length,
        'savedBy': savedBy,
      });
    }
    await addSavedVerse(userId, verseId);
  }

  // Unsaved verse
  Future<void> unsaveVerse(String verseId, String userId) async {
    final verse = await getVerse(verseId);
    if (verse != null) {
      final savedBy = List<String>.from(verse.savedBy);
      savedBy.remove(userId);
      await updateVerse(verseId, {
        'saves': savedBy.length,
        'savedBy': savedBy,
      });
    }
    await removeSavedVerse(userId, verseId);
  }

  // ============ BLOG OPERATIONS ============

  // Create blog post
  Future<String> createBlogPost(BlogPostModel post) async {
    final postId = _localStorageService.generateId();
    final postWithId = post.copyWith(id: postId);
    await _localStorageService.createBlogPost(postWithId);
    return postId;
  }

  // Get blog post by ID
  Future<BlogPostModel?> getBlogPost(String postId) async {
    return _localStorageService.getBlogPost(postId);
  }

  // Update blog post
  Future<void> updateBlogPost(String postId, Map<String, dynamic> updates) async {
    await _localStorageService.updateBlogPost(postId, updates);
  }

  // Delete blog post
  Future<void> deleteBlogPost(String postId) async {
    await _localStorageService.deleteBlogPost(postId);
  }

  // Get all blog posts
  Future<List<BlogPostModel>> getBlogPosts({
    int limit = 20,
    BlogCategory? category,
    String? authorId,
    bool featuredOnly = false,
  }) async {
    final allPosts = await _localStorageService.getAllBlogPosts();
    
    var results = allPosts
        .where((post) => post.status == BlogPostStatus.published)
        .toList();
    
    if (category != null) {
      results = results.where((post) => post.category == category).toList();
    }
    if (authorId != null) {
      results = results.where((post) => post.authorId == authorId).toList();
    }
    if (featuredOnly) {
      results = results.where((post) => post.isFeatured).toList();
    }
    
    results.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
    return results.take(limit).toList();
  }

  // Get featured blog posts
  Future<List<BlogPostModel>> getFeaturedBlogPosts(int limit) async {
    final allPosts = await getBlogPosts(limit: limit, featuredOnly: true);
    return allPosts.take(limit).toList();
  }

  // Get popular blog posts
  Future<List<BlogPostModel>> getPopularBlogPosts(int limit) async {
    final allPosts = await getBlogPosts(limit: limit);
    allPosts.sort((a, b) => b.views.compareTo(a.views));
    return allPosts.take(limit).toList();
  }

  // Get recent blog posts by user
  Future<List<BlogPostModel>> getUserBlogPosts(String userId, int limit) async {
    final allPosts = await getBlogPosts(authorId: userId, limit: limit);
    allPosts.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
    return allPosts.take(limit).toList();
  }

  // Increment blog post views
  Future<void> incrementBlogPostViews(String postId) async {
    final post = await getBlogPost(postId);
    if (post != null) {
      await updateBlogPost(postId, {
        'views': post.views + 1,
      });
    }
  }

  // Like blog post
  Future<void> likeBlogPost(String postId, String userId) async {
    final post = await getBlogPost(postId);
    if (post != null) {
      final likedBy = List<String>.from(post.likedBy);
      if (!likedBy.contains(userId)) {
        likedBy.add(userId);
      }
      await updateBlogPost(postId, {
        'likes': likedBy.length,
        'likedBy': likedBy,
      });
    }
  }

  // Unlike blog post
  Future<void> unlikeBlogPost(String postId, String userId) async {
    final post = await getBlogPost(postId);
    if (post != null) {
      final likedBy = List<String>.from(post.likedBy);
      likedBy.remove(userId);
      await updateBlogPost(postId, {
        'likes': likedBy.length,
        'likedBy': likedBy,
      });
    }
  }

  // Bookmark blog post
  Future<void> bookmarkBlogPost(String postId, String userId) async {
    final user = await getUser(userId);
    if (user != null) {
      final bookmarked = List<String>.from(user.bookmarkedBlogPostIds);
      if (!bookmarked.contains(postId)) {
        bookmarked.add(postId);
      }
      await updateUser(userId, {
        'bookmarkedBlogPostIds': bookmarked,
      });
    }
  }

  // Remove bookmark from blog post
  Future<void> removeBookmarkBlogPost(String postId, String userId) async {
    final user = await getUser(userId);
    if (user != null) {
      final bookmarked = List<String>.from(user.bookmarkedBlogPostIds);
      bookmarked.remove(postId);
      await updateUser(userId, {
        'bookmarkedBlogPostIds': bookmarked,
      });
    }
  }

  // ============ BLOG COMMENT OPERATIONS ============

  // Create blog comment
  Future<String> createBlogComment(BlogCommentModel comment) async {
    final commentId = _localStorageService.generateId();
    final commentWithId = comment.copyWith(id: commentId);
    await _localStorageService.createBlogComment(commentWithId);
    
    // Increment comment count on post
    final post = await getBlogPost(comment.postId);
    if (post != null) {
      await updateBlogPost(comment.postId, {
        'comments': post.comments + 1,
      });
    }
    
    return commentId;
  }

  // Get blog comments
  Future<List<BlogCommentModel>> getBlogComments(String postId) async {
    return _localStorageService.getBlogComments(postId);
  }

  // Like blog comment
  Future<void> likeBlogComment(String postId, String commentId, String userId) async {
    await _localStorageService.likeBlogComment(postId, commentId, userId);
  }

  // Unlike blog comment
  Future<void> unlikeBlogComment(String postId, String commentId, String userId) async {
    await _localStorageService.unlikeBlogComment(postId, commentId, userId);
  }

  // ============ CHAT OPERATIONS ============

  // Create chat room
  Future<String> createChatRoom(ChatRoomModel room) async {
    final roomId = _localStorageService.generateId();
    final roomWithId = room.copyWith(id: roomId);
    await _localStorageService.createChatRoom(roomWithId);
    return roomId;
  }

  // Get chat room by ID
  Future<ChatRoomModel?> getChatRoom(String roomId) async {
    return _localStorageService.getChatRoom(roomId);
  }

  // Update chat room
  Future<void> updateChatRoom(String roomId, Map<String, dynamic> updates) async {
    await _localStorageService.updateChatRoom(roomId, updates);
  }

  // Delete chat room
  Future<void> deleteChatRoom(String roomId) async {
    await _localStorageService.deleteChatRoom(roomId);
  }

  // Get all chat rooms
  Future<List<ChatRoomModel>> getChatRooms({
    ChatRoomType? type,
    int limit = 50,
  }) async {
    final allRooms = await _localStorageService.getAllChatRooms();
    
    var results = allRooms.where((room) => !room.isArchived).toList();
    
    if (type != null) {
      results = results.where((room) => room.type == type).toList();
    }
    
    results.sort((a, b) => b.lastMessageAt.compareTo(a.lastMessageAt));
    return results.take(limit).toList();
  }

  // Get general chat room
  Future<ChatRoomModel?> getGeneralChatRoom() async {
    final allRooms = await getChatRooms();
    return allRooms.firstWhere(
      (room) => room.name.toLowerCase() == 'general' || room.type == ChatRoomType.general,
      orElse: () => null,
    );
  }

  // Create chat message
  Future<String> createChatMessage(ChatMessageModel message) async {
    final messageId = _localStorageService.generateId();
    final messageWithId = message.copyWith(id: messageId);
    await _localStorageService.createChatMessage(messageWithId);
    
    // Update room's last message info
    final room = await getChatRoom(message.roomId);
    if (room != null) {
      await updateChatRoom(message.roomId, {
        'lastMessageId': messageId,
        'lastMessageContent': message.content,
        'lastMessageSenderId': message.senderId,
        'lastMessageAt': DateTime.now(),
        'messageCount': room.messageCount + 1,
      });
    }
    
    return messageId;
  }

  // Get chat messages
  Future<List<ChatMessageModel>> getChatMessages(String roomId, {int limit = 50}) async {
    return _localStorageService.getChatMessages(roomId, limit: limit);
  }

  // Get chat messages stream
  Stream<List<ChatMessageModel>> streamChatMessages(String roomId) {
    return _localStorageService.streamChatMessages(roomId);
  }

  // Like chat message
  Future<void> likeChatMessage(String roomId, String messageId, String userId) async {
    await _localStorageService.likeChatMessage(roomId, messageId, userId);
  }

  // Join chat room
  Future<void> joinChatRoom(String roomId, String userId) async {
    final room = await getChatRoom(roomId);
    if (room != null) {
      final memberIds = List<String>.from(room.memberIds);
      if (!memberIds.contains(userId)) {
        memberIds.add(userId);
      }
      await updateChatRoom(roomId, {
        'memberIds': memberIds,
        'memberCount': memberIds.length,
      });
    }
  }

  // Leave chat room
  Future<void> leaveChatRoom(String roomId, String userId) async {
    final room = await getChatRoom(roomId);
    if (room != null) {
      final memberIds = List<String>.from(room.memberIds);
      memberIds.remove(userId);
      await updateChatRoom(roomId, {
        'memberIds': memberIds,
        'memberCount': memberIds.length,
      });
    }
  }

  // ============ FAITH JOURNEY OPERATIONS ============

  // Create faith journey
  Future<void> createFaithJourney(FaithJourney journey) async {
    await _localStorageService.createFaithJourney(journey);
  }

  // Get faith journey
  Future<FaithJourney?> getFaithJourney(String userId) async {
    return _localStorageService.getFaithJourney(userId);
  }

  // Update faith journey
  Future<void> updateFaithJourney(String userId, Map<String, dynamic> updates) async {
    await _localStorageService.updateFaithJourney(userId, updates);
  }

  // Delete faith journey
  Future<void> deleteFaithJourney(String userId) async {
    await _localStorageService.deleteFaithJourney(userId);
  }

  // Stream faith journey
  Stream<FaithJourney?> streamFaithJourney(String userId) {
    return _localStorageService.streamFaithJourney(userId);
  }

  // Record reading session
  Future<void> recordReadingSession(ReadingSession session) async {
    await _localStorageService.recordReadingSession(session);
    
    // Update faith journey statistics
    final journey = await getFaithJourney(session.userId);
    if (journey != null) {
      final updates = <String, dynamic>{};
      
      // Update book progress
      if (session.book != null) {
        final bookKey = 'bookProgress.${session.book}';
        final currentProgress = journey.bookProgress[session.book] ?? 0;
        updates[bookKey] = currentProgress + session.versesCount;
      }
      
      // Update total stats
      updates['versesRead'] = journey.versesRead + session.versesCount;
      updates['chaptersRead'] = journey.chaptersRead + 1;
      updates['totalDaysRead'] = journey.totalDaysRead + 1;
      updates['lastReadingDate'] = DateTime.now();
      
      // Update streak
      final now = DateTime.now();
      final lastReading = journey.lastReadingDate;
      
      if (lastReading != null) {
        final diff = now.difference(lastReading).inDays;
        if (diff == 1) {
          updates['consecutiveDays'] = journey.consecutiveDays + 1;
        } else if (diff > 1) {
          updates['consecutiveDays'] = 1;
        }
      } else {
        updates['consecutiveDays'] = 1;
      }
      
      // Check for role advancement
      final newConsecutiveDays = updates['consecutiveDays'] ?? journey.consecutiveDays;
      final user = await getUser(session.userId);
      
      if (user != null && newConsecutiveDays >= 7 && user.role.index < UserRole.preacher.index) {
        await updateUser(session.userId, {'role': UserRole.preacher.name});
      } else if (user != null && newConsecutiveDays >= 30 && user.role.index < UserRole.shepherd.index) {
        await updateUser(session.userId, {'role': UserRole.shepherd.name});
      } else if (user != null && newConsecutiveDays >= 365 && user.role.index < UserRole.bishop.index) {
        await updateUser(session.userId, {'role': UserRole.bishop.name});
      }
      
      await updateFaithJourney(session.userId, updates);
    }
  }

  // Get faith journey stats
  Future<Map<String, dynamic>> getFaithJourneyStats(String userId) async {
    final journey = await getFaithJourney(userId);
    if (journey == null) return {};
    
    return {
      'currentRole': journey.currentRole.name,
      'consecutiveDays': journey.consecutiveDays,
      'totalDaysRead': journey.totalDaysRead,
      'versesRead': journey.versesRead,
      'chaptersRead': journey.chaptersRead,
      'bookProgress': journey.bookProgress,
    };
  }

  // ============ READING HABIT OPERATIONS ============

  // Create reading habit
  Future<void> createReadingHabit(ReadingHabit habit) async {
    await _localStorageService.createReadingHabit(habit);
  }

  // Get reading habit
  Future<ReadingHabit?> getReadingHabit(String userId) async {
    return _localStorageService.getReadingHabit(userId);
  }

  // Update reading habit
  Future<void> updateReadingHabit(String userId, Map<String, dynamic> updates) async {
    await _localStorageService.updateReadingHabit(userId, updates);
  }

  // Delete reading habit
  Future<void> deleteReadingHabit(String userId) async {
    await _localStorageService.deleteReadingHabit(userId);
  }

  // Stream reading habit
  Stream<ReadingHabit?> streamReadingHabit(String userId) {
    return _localStorageService.streamReadingHabit(userId);
  }

  // ============ SUBSCRIPTION OPERATIONS ============

  // Create subscription
  Future<String> createSubscription(Subscription subscription) async {
    final subscriptionId = _localStorageService.generateId();
    final subscriptionWithId = subscription.copyWith(id: subscriptionId);
    await _localStorageService.createSubscription(subscriptionWithId);
    
    // Update user's premium tier
    final user = await getUser(subscription.userId);
    if (user != null) {
      await updateUser(subscription.userId, {
        'premiumTier': subscription.plan,
        'premiumExpiry': subscription.endDate,
      });
    }
    
    return subscriptionId;
  }

  // Get subscription by ID
  Future<Subscription?> getSubscription(String subscriptionId) async {
    return _localStorageService.getSubscription(subscriptionId);
  }

  // Get active subscription for user
  Future<Subscription?> getActiveSubscription(String userId) async {
    return _localStorageService.getActiveSubscription(userId);
  }

  // Get all subscriptions for user
  Future<List<Subscription>> getUserSubscriptions(String userId) async {
    return _localStorageService.getUserSubscriptions(userId);
  }

  // Update subscription
  Future<void> updateSubscription(String subscriptionId, Map<String, dynamic> updates) async {
    await _localStorageService.updateSubscription(subscriptionId, updates);
  }

  // Delete subscription
  Future<void> deleteSubscription(String subscriptionId) async {
    await _localStorageService.deleteSubscription(subscriptionId);
  }

  // Check if user has active premium
  Future<bool> hasActivePremium(String userId) async {
    final subscription = await getActiveSubscription(userId);
    if (subscription == null) return false;
    return subscription.endDate.isAfter(DateTime.now());
  }

  // Get premium features for user
  Future<Map<String, bool>> getPremiumFeatures(String userId) async {
    final user = await getUser(userId);
    if (user == null) return {};
    
    return {
      'adFree': user.premiumTier != PremiumTier.free,
      'offlineMode': user.premiumTier.index >= PremiumTier.basic.index,
      'advancedSearch': user.premiumTier.index >= PremiumTier.basic.index,
      'readingPlans': user.premiumTier.index >= PremiumTier.pro.index,
      'commentaries': user.premiumTier.index >= PremiumTier.pro.index,
      'devotionals': user.premiumTier.index >= PremiumTier.pro.index,
      'customThemes': user.premiumTier.index >= PremiumTier.basic.index,
      'canPostOnBlog': user.role == UserRole.bishop || user.canPostOnBlog,
      'hasPaidToSkipLadder': user.hasPaidToSkipLadder,
    };
  }

  // ============ PAYMENT OPERATIONS ============

  // Create payment
  Future<String> createPayment(Payment payment) async {
    final paymentId = _localStorageService.generateId();
    final paymentWithId = payment.copyWith(id: paymentId);
    await _localStorageService.createPayment(paymentWithId);
    return paymentId;
  }

  // Get payment by ID
  Future<Payment?> getPayment(String paymentId) async {
    return _localStorageService.getPayment(paymentId);
  }

  // Get user payments
  Future<List<Payment>> getUserPayments(String userId) async {
    return _localStorageService.getUserPayments(userId);
  }

  // Update payment
  Future<void> updatePayment(String paymentId, Map<String, dynamic> updates) async {
    await _localStorageService.updatePayment(paymentId, updates);
  }

  // Delete payment
  Future<void> deletePayment(String paymentId) async {
    await _localStorageService.deletePayment(paymentId);
  }

  // ============ MODERATION OPERATIONS ============

  // Create moderation report
  Future<String> createModerationReport(ModerationReportModel report) async {
    final reportId = _localStorageService.generateId();
    final reportWithId = report.copyWith(id: reportId);
    await _localStorageService.createModerationReport(reportWithId);
    return reportId;
  }

  // Get moderation report
  Future<ModerationReportModel?> getModerationReport(String reportId) async {
    return _localStorageService.getModerationReport(reportId);
  }

  // Get all moderation reports
  Future<List<ModerationReportModel>> getModerationReports({
    ModerationStatus? status,
    int limit = 50,
  }) async {
    return _localStorageService.getModerationReports(status: status, limit: limit);
  }

  // Update moderation report
  Future<void> updateModerationReport(String reportId, Map<String, dynamic> updates) async {
    await _localStorageService.updateModerationReport(reportId, updates);
  }

  // Delete moderation report
  Future<void> deleteModerationReport(String reportId) async {
    await _localStorageService.deleteModerationReport(reportId);
  }

  // ============ STATISTICS ============

  // Get app statistics
  Future<Map<String, int>> getAppStatistics() async {
    final allUsers = await getAllUsers();
    final allBlogPosts = await _localStorageService.getAllBlogPosts();
    final allChatRooms = await _localStorageService.getAllChatRooms();
    
    return {
      'totalUsers': allUsers.length,
      'totalBlogPosts': allBlogPosts.length,
      'totalChatRooms': allChatRooms.length,
      'activeUsers': 0,
      'premiumUsers': allUsers.where((u) => u.premiumTier != PremiumTier.free).length,
    };
  }

  // ============ HELPER METHODS ============

  // Batch write
  Future<void> batchWrite(List<Function> operations) async {
    // Hive doesn't support batch operations, execute sequentially
    for (final operation in operations) {
      await operation();
    }
  }

  // Run transaction
  Future<T> runTransaction<T>(Future<T> Function() transactionHandler) async {
    return await transactionHandler();
  }
}
