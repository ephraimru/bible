import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/blog_model.dart';
import '../models/chat_model.dart';
import '../models/faith_journey_model.dart';
import '../models/premium_model.dart';
import '../models/user_model.dart';
import '../models/verse_model.dart';
import 'local_storage_service.dart';

// Database Service Provider - uses LocalStorageService (Hive)
final databaseServiceProvider = Provider<DatabaseService>((ref) {
  return DatabaseService(
    localStorageService: ref.read(localStorageServiceProvider),
  );
});

/// Premium tier granted by a subscription plan.
PremiumTier premiumTierForPlan(SubscriptionPlan plan) {
  switch (plan) {
    case SubscriptionPlan.free:
      return PremiumTier.free;
    case SubscriptionPlan.basicMonthly:
    case SubscriptionPlan.basicYearly:
      return PremiumTier.basic;
    case SubscriptionPlan.proMonthly:
    case SubscriptionPlan.proYearly:
      return PremiumTier.pro;
    case SubscriptionPlan.bishop:
      return PremiumTier.bishop;
  }
}

/// App-level data access. Delegates storage to [LocalStorageService] and adds
/// operations that span several records.
class DatabaseService {
  final LocalStorageService localStorageService;

  DatabaseService({required this.localStorageService});

  LocalStorageService get _s => localStorageService;

  // ============ USER OPERATIONS ============

  Future<void> createUser(UserModel user) => _s.createUser(user);
  Future<UserModel?> getUser(String userId) => _s.getUser(userId);
  Future<void> updateUser(String userId, Map<String, dynamic> updates) =>
      _s.updateUser(userId, updates);
  Future<void> deleteUser(String userId) => _s.deleteUser(userId);
  Stream<UserModel?> streamUser(String userId) => _s.streamUser(userId);
  Future<List<UserModel>> getAllUsers() => _s.getAllUsers();

  Future<List<UserModel>> searchUsers({String? query, int limit = 20}) =>
      _s.searchUsers(query: query, limit: limit);

  Future<List<UserModel>> getUsersByRole(UserRole role) async =>
      (await getAllUsers()).where((user) => user.role == role).toList();

  Future<void> incrementFollowingCount(String userId) => _s.incrementFollowingCount(userId);
  Future<void> incrementFollowersCount(String userId) => _s.incrementFollowersCount(userId);
  Future<void> addSavedVerse(String userId, String verseId) => _s.addSavedVerse(userId, verseId);
  Future<void> removeSavedVerse(String userId, String verseId) =>
      _s.removeSavedVerse(userId, verseId);
  Future<void> addLikedVerse(String userId, String verseId) => _s.addLikedVerse(userId, verseId);
  Future<void> removeLikedVerse(String userId, String verseId) =>
      _s.removeLikedVerse(userId, verseId);

  Future<void> followUser(String currentUserId, String targetUserId) async {
    final currentUser = await getUser(currentUserId);
    if (currentUser == null || currentUser.followingUserIds.contains(targetUserId)) return;
    final following = [...currentUser.followingUserIds, targetUserId];
    await updateUser(currentUserId, {
      'followingUserIds': following,
      'followingCount': following.length,
    });
    await incrementFollowersCount(targetUserId);
  }

  Future<void> unfollowUser(String currentUserId, String targetUserId) async {
    final currentUser = await getUser(currentUserId);
    if (currentUser == null || !currentUser.followingUserIds.contains(targetUserId)) return;
    final following =
        currentUser.followingUserIds.where((id) => id != targetUserId).toList();
    await updateUser(currentUserId, {
      'followingUserIds': following,
      'followingCount': following.length,
    });
    final targetUser = await getUser(targetUserId);
    if (targetUser != null && targetUser.followersCount > 0) {
      await updateUser(targetUserId, {'followersCount': targetUser.followersCount - 1});
    }
  }

  // ============ VERSE OPERATIONS ============

  Future<void> createVerse(VerseModel verse) => _s.createVerse(verse);
  Future<VerseModel?> getVerse(String verseId) => _s.getVerse(verseId);
  Future<void> updateVerse(String verseId, Map<String, dynamic> updates) =>
      _s.updateVerse(verseId, updates);
  Future<void> deleteVerse(String verseId) => _s.deleteVerse(verseId);
  Future<List<VerseModel>> getAllVerses() => _s.getAllVerses();
  Future<List<VerseModel>> getVersesByBook(String book) => _s.getVersesByBook(book);
  Future<List<VerseModel>> getVersesByChapter(String book, int chapter) =>
      _s.getVersesByChapter(book, chapter);

  Future<List<VerseModel>> searchVerses({
    String? query,
    String? book,
    int? chapter,
    int limit = 50,
  }) =>
      _s.searchVerses(query: query, book: book, chapter: chapter, limit: limit);

  Future<VerseModel?> getRandomVerse() => _s.getRandomVerse();
  Future<DailyVerseModel?> getDailyVerse(DateTime date) => _s.getDailyVerse(date);

  /// Likes the verse and records it on the user.
  Future<void> likeVerse(String verseId, String userId) async {
    await _s.likeVerse(verseId, userId);
    await _s.addLikedVerse(userId, verseId);
  }

  Future<void> unlikeVerse(String verseId, String userId) async {
    await _s.unlikeVerse(verseId, userId);
    await _s.removeLikedVerse(userId, verseId);
  }

  /// Saves the verse and records it on the user.
  Future<void> saveVerse(String verseId, String userId) async {
    await _s.saveVerse(verseId, userId);
    await _s.addSavedVerse(userId, verseId);
  }

  Future<void> unsaveVerse(String verseId, String userId) async {
    await _s.unsaveVerse(verseId, userId);
    await _s.removeSavedVerse(userId, verseId);
  }

  // ============ BLOG OPERATIONS ============

  Future<String> createBlogPost(BlogPostModel post) => _s.createBlogPost(post);
  Future<BlogPostModel?> getBlogPost(String postId) => _s.getBlogPost(postId);
  Future<void> updateBlogPost(String postId, Map<String, dynamic> updates) =>
      _s.updateBlogPost(postId, updates);
  Future<void> deleteBlogPost(String postId) => _s.deleteBlogPost(postId);

  Future<List<BlogPostModel>> getBlogPosts({
    int limit = 20,
    BlogCategory? category,
    String? authorId,
    bool featuredOnly = false,
  }) =>
      _s.getBlogPosts(
        limit: limit,
        category: category,
        authorId: authorId,
        featuredOnly: featuredOnly,
      );

  Future<List<BlogPostModel>> getFeaturedBlogPosts(int limit) => _s.getFeaturedBlogPosts(limit);
  Future<List<BlogPostModel>> getPopularBlogPosts(int limit) => _s.getPopularBlogPosts(limit);
  Future<List<BlogPostModel>> getUserBlogPosts(String userId, int limit) =>
      _s.getUserBlogPosts(userId, limit);
  Future<void> incrementBlogPostViews(String postId) => _s.incrementBlogPostViews(postId);
  Future<void> likeBlogPost(String postId, String userId) => _s.likeBlogPost(postId, userId);
  Future<void> unlikeBlogPost(String postId, String userId) => _s.unlikeBlogPost(postId, userId);
  Future<void> bookmarkBlogPost(String postId, String userId) =>
      _s.bookmarkBlogPost(postId, userId);
  Future<void> removeBookmarkBlogPost(String postId, String userId) =>
      _s.removeBookmarkBlogPost(postId, userId);

  // ============ BLOG COMMENT OPERATIONS ============

  Future<String> createBlogComment(BlogCommentModel comment) => _s.createBlogComment(comment);
  Future<List<BlogCommentModel>> getBlogComments(String postId) => _s.getBlogComments(postId);
  Future<void> likeBlogComment(String postId, String commentId, String userId) =>
      _s.likeBlogComment(postId, commentId, userId);
  Future<void> unlikeBlogComment(String postId, String commentId, String userId) =>
      _s.unlikeBlogComment(postId, commentId, userId);

  // ============ CHAT OPERATIONS ============

  Future<String> createChatRoom(ChatRoomModel room) => _s.createChatRoom(room);
  Future<ChatRoomModel?> getChatRoom(String roomId) => _s.getChatRoom(roomId);
  Future<void> updateChatRoom(String roomId, Map<String, dynamic> updates) =>
      _s.updateChatRoom(roomId, updates);
  Future<void> deleteChatRoom(String roomId) => _s.deleteChatRoom(roomId);
  Future<List<ChatRoomModel>> getChatRooms({ChatRoomType? type, int limit = 50}) =>
      _s.getChatRooms(type: type, limit: limit);
  Future<ChatRoomModel?> getGeneralChatRoom() => _s.getGeneralChatRoom();
  Future<String> createChatMessage(ChatMessageModel message) => _s.createChatMessage(message);
  Future<List<ChatMessageModel>> getChatMessages(String roomId, {int limit = 50}) =>
      _s.getChatMessages(roomId, limit: limit);
  Stream<List<ChatMessageModel>> streamChatMessages(String roomId) =>
      _s.streamChatMessages(roomId);
  Future<void> likeChatMessage(String roomId, String messageId, String userId) =>
      _s.likeChatMessage(roomId, messageId, userId);
  Future<void> updateChatMessage(
          String roomId, String messageId, Map<String, dynamic> updates) =>
      _s.updateChatMessage(roomId, messageId, updates);
  Future<void> joinChatRoom(String roomId, String userId) => _s.joinChatRoom(roomId, userId);
  Future<void> leaveChatRoom(String roomId, String userId) => _s.leaveChatRoom(roomId, userId);

  // ============ FAITH JOURNEY OPERATIONS ============

  Future<void> createFaithJourney(FaithJourney journey) => _s.createFaithJourney(journey);
  Future<FaithJourney?> getFaithJourney(String userId) => _s.getFaithJourney(userId);
  Future<void> updateFaithJourney(String userId, Map<String, dynamic> updates) =>
      _s.updateFaithJourney(userId, updates);
  Future<void> deleteFaithJourney(String userId) => _s.deleteFaithJourney(userId);
  Stream<FaithJourney?> streamFaithJourney(String userId) => _s.streamFaithJourney(userId);

  // ============ READING HABIT OPERATIONS ============

  Future<void> createReadingHabit(ReadingHabit habit) => _s.createReadingHabit(habit);
  Future<ReadingHabit?> getReadingHabit(String userId) => _s.getReadingHabit(userId);
  Future<void> updateReadingHabit(String userId, Map<String, dynamic> updates) =>
      _s.updateReadingHabit(userId, updates);
  Future<void> deleteReadingHabit(String userId) => _s.deleteReadingHabit(userId);
  Stream<ReadingHabit?> streamReadingHabit(String userId) => _s.streamReadingHabit(userId);

  // ============ SUBSCRIPTION OPERATIONS ============

  /// Stores the subscription and upgrades the user's premium tier to match.
  Future<String> createSubscription(Subscription subscription) async {
    final subscriptionId = await _s.createSubscription(subscription);
    await updateUser(subscription.userId, {
      'premiumTier': premiumTierForPlan(subscription.plan),
    });
    return subscriptionId;
  }

  Future<Subscription?> getSubscription(String subscriptionId) =>
      _s.getSubscription(subscriptionId);
  Future<Subscription?> getActiveSubscription(String userId) => _s.getActiveSubscription(userId);
  Future<List<Subscription>> getUserSubscriptions(String userId) =>
      _s.getUserSubscriptions(userId);
  Future<void> updateSubscription(String subscriptionId, Map<String, dynamic> updates) =>
      _s.updateSubscription(subscriptionId, updates);
  Future<void> deleteSubscription(String subscriptionId) => _s.deleteSubscription(subscriptionId);

  Future<bool> hasActivePremium(String userId) async {
    final subscription = await getActiveSubscription(userId);
    return subscription != null && subscription.endDate.isAfter(DateTime.now());
  }

  // ============ PAYMENT OPERATIONS ============

  Future<String> createPayment(Payment payment) => _s.createPayment(payment);
  Future<Payment?> getPayment(String paymentId) => _s.getPayment(paymentId);
  Future<List<Payment>> getUserPayments(String userId) => _s.getUserPayments(userId);
  Future<void> updatePayment(String paymentId, Map<String, dynamic> updates) =>
      _s.updatePayment(paymentId, updates);
  Future<void> deletePayment(String paymentId) => _s.deletePayment(paymentId);

  // ============ MODERATION OPERATIONS ============

  Future<String> createModerationReport(ModerationReportModel report) async {
    final reportWithId = report.id.isEmpty ? report.copyWith(id: _s.generateId()) : report;
    await _s.createModerationReport(reportWithId);
    return reportWithId.id;
  }

  Future<ModerationReportModel?> getModerationReport(String reportId) =>
      _s.getModerationReport(reportId);
  Future<List<ModerationReportModel>> getModerationReports({
    ModerationStatus? status,
    int limit = 50,
  }) =>
      _s.getModerationReports(status: status, limit: limit);
  Future<void> updateModerationReport(String reportId, Map<String, dynamic> updates) =>
      _s.updateModerationReport(reportId, updates);
  Future<void> deleteModerationReport(String reportId) => _s.deleteModerationReport(reportId);

  // ============ STATISTICS ============

  Future<Map<String, int>> getAppStatistics() async {
    final allUsers = await getAllUsers();
    return {
      'totalUsers': allUsers.length,
      'totalBlogPosts': (await _s.getAllBlogPosts()).length,
      'totalChatRooms': (await _s.getAllChatRooms()).length,
      'premiumUsers': allUsers.where((u) => u.premiumTier != PremiumTier.free).length,
    };
  }
}
