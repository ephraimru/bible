import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';
import '../models/verse_model.dart';
import '../models/blog_model.dart';
import '../models/chat_model.dart';
import '../models/faith_journey_model.dart';
import '../models/premium_model.dart';

// Database Service Provider
final databaseServiceProvider = Provider<DatabaseService>((ref) {
  return DatabaseService(
    firestore: FirebaseFirestore.instance,
  );
});

class DatabaseService {
  final FirebaseFirestore _firestore;

  DatabaseService({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  // ============ USER OPERATIONS ============

  // Users collection reference
  CollectionReference<UserModel> get usersCollection =>
      _firestore.collection('users').withConverter(
            fromFirestore: (doc, _) => UserModel.fromFirestore(doc),
            toFirestore: (user, _) => user.toJson(),
          );

  // Create user
  Future<void> createUser(UserModel user) async {
    await usersCollection.doc(user.id).set(user);
  }

  // Get user by ID
  Future<UserModel?> getUser(String userId) async {
    final doc = await usersCollection.doc(userId).get();
    return doc.exists ? doc.data() : null;
  }

  // Update user
  Future<void> updateUser(String userId, Map<String, dynamic> updates) async {
    await usersCollection.doc(userId).update(updates);
  }

  // Delete user
  Future<void> deleteUser(String userId) async {
    await usersCollection.doc(userId).delete();
  }

  // Stream user by ID
  Stream<UserModel?> streamUser(String userId) {
    return usersCollection.doc(userId).snapshots().map(
          (doc) => doc.exists ? doc.data() : null,
        );
  }

  // Search users
  Future<List<UserModel>> searchUsers({
    String? query,
    int limit = 20,
    String? roleFilter,
  }) async {
    Query<UserModel> queryBuilder = usersCollection;
    
    if (query != null && query.isNotEmpty) {
      queryBuilder = queryBuilder
          .where('displayName', isGreaterThanOrEqualTo: query)
          .where('displayName', isLessThanOrEqualTo: '$query\uf8ff');
    }
    
    if (roleFilter != null) {
      queryBuilder = queryBuilder.where('role', isEqualTo: roleFilter);
    }
    
    final snapshot = await queryBuilder.limit(limit).get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  // Get users by role
  Future<List<UserModel>> getUsersByRole(UserRole role) async {
    final snapshot = await usersCollection
        .where('role', isEqualTo: role.name)
        .get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  // Increment user following count
  Future<void> incrementFollowingCount(String userId) async {
    await usersCollection.doc(userId).update({
      'followingCount': FieldValue.increment(1),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // Increment user followers count
  Future<void> incrementFollowersCount(String userId) async {
    await usersCollection.doc(userId).update({
      'followersCount': FieldValue.increment(1),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // Add saved verse to user
  Future<void> addSavedVerse(String userId, String verseId) async {
    await usersCollection.doc(userId).update({
      'savedVerseIds': FieldValue.arrayUnion([verseId]),
      'savedVersesCount': FieldValue.increment(1),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // Remove saved verse from user
  Future<void> removeSavedVerse(String userId, String verseId) async {
    await usersCollection.doc(userId).update({
      'savedVerseIds': FieldValue.arrayRemove([verseId]),
      'savedVersesCount': FieldValue.increment(-1),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // Add liked verse to user
  Future<void> addLikedVerse(String userId, String verseId) async {
    await usersCollection.doc(userId).update({
      'likedVerseIds': FieldValue.arrayUnion([verseId]),
      'likedVersesCount': FieldValue.increment(1),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // Remove liked verse from user
  Future<void> removeLikedVerse(String userId, String verseId) async {
    await usersCollection.doc(userId).update({
      'likedVerseIds': FieldValue.arrayRemove([verseId]),
      'likedVersesCount': FieldValue.increment(-1),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // ============ VERSE OPERATIONS ============

  // Verses collection reference
  CollectionReference<VerseModel> get versesCollection =>
      _firestore.collection('verses').withConverter(
            fromFirestore: (doc, _) => VerseModel.fromFirestore(doc),
            toFirestore: (verse, _) => verse.toJson(),
          );

  // Create verse
  Future<void> createVerse(VerseModel verse) async {
    await versesCollection.doc(verse.id).set(verse);
  }

  // Get verse by ID
  Future<VerseModel?> getVerse(String verseId) async {
    final doc = await versesCollection.doc(verseId).get();
    return doc.exists ? doc.data() : null;
  }

  // Update verse
  Future<void> updateVerse(String verseId, Map<String, dynamic> updates) async {
    await versesCollection.doc(verseId).update(updates);
  }

  // Get daily verse
  Future<DailyVerseModel?> getDailyVerse(DateTime date) async {
    final dateStr = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    
    final doc = await _firestore
        .collection('daily_verses')
        .doc(dateStr)
        .get();
    
    if (doc.exists) {
      return DailyVerseModel.fromJson(doc.data()!);
    }
    return null;
  }

  // Get verses by book
  Future<List<VerseModel>> getVersesByBook(String book) async {
    final snapshot = await versesCollection
        .where('book', isEqualTo: book)
        .orderBy('chapter')
        .orderBy('verse')
        .get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  // Get verses by book and chapter
  Future<List<VerseModel>> getVersesByChapter(String book, int chapter) async {
    final snapshot = await versesCollection
        .where('book', isEqualTo: book)
        .where('chapter', isEqualTo: chapter)
        .orderBy('verse')
        .get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  // Search verses
  Future<List<VerseModel>> searchVerses({
    String? query,
    String? book,
    int? chapter,
    int limit = 50,
  }) async {
    Query<VerseModel> queryBuilder = versesCollection;
    
    if (book != null) {
      queryBuilder = queryBuilder.where('book', isEqualTo: book);
    }
    if (chapter != null) {
      queryBuilder = queryBuilder.where('chapter', isEqualTo: chapter);
    }
    if (query != null && query.isNotEmpty) {
      queryBuilder = queryBuilder
          .where('text', isGreaterThanOrEqualTo: query)
          .where('text', isLessThanOrEqualTo: '$query\uf8ff');
    }
    
    final snapshot = await queryBuilder.limit(limit).get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  // Get random verse
  Future<VerseModel?> getRandomVerse() async {
    final snapshot = await versesCollection
        .orderBy('book', descending: false)
        .orderBy('chapter', descending: false)
        .orderBy('verse', descending: false)
        .limit(1)
        .get();
    
    if (snapshot.docs.isNotEmpty) {
      final allDocs = await versesCollection.get();
      final randomIndex = DateTime.now().millisecondsSinceEpoch % allDocs.docs.length;
      return allDocs.docs.elementAt(randomIndex).data();
    }
    return null;
  }

  // Like verse
  Future<void> likeVerse(String verseId, String userId) async {
    await versesCollection.doc(verseId).update({
      'likes': FieldValue.increment(1),
      'likedBy': FieldValue.arrayUnion([userId]),
    });
  }

  // Unlike verse
  Future<void> unlikeVerse(String verseId, String userId) async {
    await versesCollection.doc(verseId).update({
      'likes': FieldValue.increment(-1),
      'likedBy': FieldValue.arrayRemove([userId]),
    });
  }

  // Save verse
  Future<void> saveVerse(String verseId, String userId) async {
    await versesCollection.doc(verseId).update({
      'saves': FieldValue.increment(1),
      'savedBy': FieldValue.arrayUnion([userId]),
    });
  }

  // Unsaved verse
  Future<void> unsaveVerse(String verseId, String userId) async {
    await versesCollection.doc(verseId).update({
      'saves': FieldValue.increment(-1),
      'savedBy': FieldValue.arrayRemove([userId]),
    });
  }

  // ============ BLOG OPERATIONS ============

  // Blog posts collection reference
  CollectionReference<BlogPostModel> get blogPostsCollection =>
      _firestore.collection('blog_posts').withConverter(
            fromFirestore: (doc, _) => BlogPostModel.fromFirestore(doc),
            toFirestore: (post, _) => post.toJson(),
          );

  // Create blog post
  Future<String> createBlogPost(BlogPostModel post) async {
    final docRef = blogPostsCollection.doc();
    post = post.copyWith(id: docRef.id);
    await docRef.set(post);
    return docRef.id;
  }

  // Get blog post by ID
  Future<BlogPostModel?> getBlogPost(String postId) async {
    final doc = await blogPostsCollection.doc(postId).get();
    return doc.exists ? doc.data() : null;
  }

  // Update blog post
  Future<void> updateBlogPost(String postId, Map<String, dynamic> updates) async {
    await blogPostsCollection.doc(postId).update(updates);
  }

  // Delete blog post
  Future<void> deleteBlogPost(String postId) async {
    await blogPostsCollection.doc(postId).delete();
  }

  // Get all blog posts
  Future<List<BlogPostModel>> getBlogPosts({
    int limit = 20,
    BlogCategory? category,
    String? authorId,
    bool featuredOnly = false,
  }) async {
    Query<BlogPostModel> queryBuilder = blogPostsCollection
        .where('status', isEqualTo: BlogPostStatus.published.name)
        .orderBy('publishedAt', descending: true);
    
    if (category != null) {
      queryBuilder = queryBuilder.where('category', isEqualTo: category.name);
    }
    if (authorId != null) {
      queryBuilder = queryBuilder.where('authorId', isEqualTo: authorId);
    }
    if (featuredOnly) {
      queryBuilder = queryBuilder.where('isFeatured', isEqualTo: true);
    }
    
    final snapshot = await queryBuilder.limit(limit).get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  // Get featured blog posts
  Future<List<BlogPostModel>> getFeaturedBlogPosts(int limit) async {
    final snapshot = await blogPostsCollection
        .where('isFeatured', isEqualTo: true)
        .where('status', isEqualTo: BlogPostStatus.published.name)
        .orderBy('publishedAt', descending: true)
        .limit(limit)
        .get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  // Get popular blog posts
  Future<List<BlogPostModel>> getPopularBlogPosts(int limit) async {
    final snapshot = await blogPostsCollection
        .where('status', isEqualTo: BlogPostStatus.published.name)
        .orderBy('views', descending: true)
        .limit(limit)
        .get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  // Get recent blog posts by user
  Future<List<BlogPostModel>> getUserBlogPosts(String userId, int limit) async {
    final snapshot = await blogPostsCollection
        .where('authorId', isEqualTo: userId)
        .where('status', isEqualTo: BlogPostStatus.published.name)
        .orderBy('publishedAt', descending: true)
        .limit(limit)
        .get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  // Increment blog post views
  Future<void> incrementBlogPostViews(String postId) async {
    await blogPostsCollection.doc(postId).update({
      'views': FieldValue.increment(1),
    });
  }

  // Like blog post
  Future<void> likeBlogPost(String postId, String userId) async {
    await blogPostsCollection.doc(postId).update({
      'likes': FieldValue.increment(1),
      'likedBy': FieldValue.arrayUnion([userId]),
    });
  }

  // Unlike blog post
  Future<void> unlikeBlogPost(String postId, String userId) async {
    await blogPostsCollection.doc(postId).update({
      'likes': FieldValue.increment(-1),
      'likedBy': FieldValue.arrayRemove([userId]),
    });
  }

  // Bookmark blog post
  Future<void> bookmarkBlogPost(String postId, String userId) async {
    await usersCollection.doc(userId).update({
      'bookmarkedBlogPostIds': FieldValue.arrayUnion([postId]),
    });
  }

  // Remove bookmark from blog post
  Future<void> removeBookmarkBlogPost(String postId, String userId) async {
    await usersCollection.doc(userId).update({
      'bookmarkedBlogPostIds': FieldValue.arrayRemove([postId]),
    });
  }

  // ============ BLOG COMMENT OPERATIONS ============

  // Create blog comment
  Future<String> createBlogComment(BlogCommentModel comment) async {
    final postRef = blogPostsCollection.doc(comment.postId);
    final docRef = postRef.collection('comments').doc();
    comment = comment.copyWith(id: docRef.id);
    await docRef.set(comment);
    
    // Increment comment count
    await postRef.update({
      'comments': FieldValue.increment(1),
    });
    
    return docRef.id;
  }

  // Get blog comments
  Future<List<BlogCommentModel>> getBlogComments(String postId) async {
    final snapshot = await blogPostsCollection
        .doc(postId)
        .collection('comments')
        .orderBy('createdAt', descending: false)
        .get();
    
    return snapshot.docs
        .map((doc) => BlogCommentModel.fromJson(doc.data()))
        .toList();
  }

  // Like blog comment
  Future<void> likeBlogComment(String postId, String commentId, String userId) async {
    await blogPostsCollection
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .update({
      'likes': FieldValue.arrayUnion([userId]),
    });
  }

  // Unlike blog comment
  Future<void> unlikeBlogComment(String postId, String commentId, String userId) async {
    await blogPostsCollection
        .doc(postId)
        .collection('comments')
        .doc(commentId)
        .update({
      'likes': FieldValue.arrayRemove([userId]),
    });
  }

  // ============ CHAT OPERATIONS ============

  // Chat rooms collection reference
  CollectionReference<ChatRoomModel> get chatRoomsCollection =>
      _firestore.collection('chat_rooms').withConverter(
            fromFirestore: (doc, _) => ChatRoomModel.fromFirestore(doc),
            toFirestore: (room, _) => room.toJson(),
          );

  // Create chat room
  Future<String> createChatRoom(ChatRoomModel room) async {
    final docRef = chatRoomsCollection.doc();
    room = room.copyWith(id: docRef.id);
    await docRef.set(room);
    return docRef.id;
  }

  // Get chat room by ID
  Future<ChatRoomModel?> getChatRoom(String roomId) async {
    final doc = await chatRoomsCollection.doc(roomId).get();
    return doc.exists ? doc.data() : null;
  }

  // Get all chat rooms
  Future<List<ChatRoomModel>> getChatRooms({
    ChatRoomType? type,
    int limit = 50,
  }) async {
    Query<ChatRoomModel> queryBuilder = chatRoomsCollection
        .where('isArchived', isEqualTo: false);
    
    if (type != null) {
      queryBuilder = queryBuilder.where('type', isEqualTo: type.name);
    }
    
    final snapshot = await queryBuilder
        .orderBy('lastMessageAt', descending: true)
        .limit(limit)
        .get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  // Get general chat room (default room for gospel discussions)
  Future<ChatRoomModel?> getGeneralChatRoom() async {
    final snapshot = await chatRoomsCollection
        .where('type', isEqualTo: ChatRoomType.general.name)
        .where('name', isEqualTo: 'Gospel Discussions')
        .limit(1)
        .get();
    
    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.data();
    }
    return null;
  }

  // Create chat message
  Future<String> createChatMessage(ChatMessageModel message) async {
    final roomRef = chatRoomsCollection.doc(message.roomId);
    final docRef = roomRef.collection('messages').doc();
    message = message.copyWith(id: docRef.id);
    await docRef.set(message);
    
    // Update room last message
    await roomRef.update({
      'lastMessageId': docRef.id,
      'lastMessageSenderId': message.senderId,
      'lastMessageContent': message.content,
      'lastMessageAt': FieldValue.serverTimestamp(),
      'messageCount': FieldValue.increment(1),
    });
    
    return docRef.id;
  }

  // Get chat messages
  Stream<List<ChatMessageModel>> streamChatMessages(String roomId) {
    return chatRoomsCollection
        .doc(roomId)
        .collection('messages')
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChatMessageModel.fromJson(doc.data()))
            .toList());
  }

  // Get recent chat messages
  Future<List<ChatMessageModel>> getRecentChatMessages(
    String roomId, {
    int limit = 50,
  }) async {
    final snapshot = await chatRoomsCollection
        .doc(roomId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .get();
    
    return snapshot.docs
        .map((doc) => ChatMessageModel.fromJson(doc.data()))
        .toList();
  }

  // Like chat message
  Future<void> likeChatMessage(String roomId, String messageId, String userId) async {
    await chatRoomsCollection
        .doc(roomId)
        .collection('messages')
        .doc(messageId)
        .update({
      'likes': FieldValue.increment(1),
      'likedBy': FieldValue.arrayUnion([userId]),
    });
  }

  // Unlike chat message
  Future<void> unlikeChatMessage(String roomId, String messageId, String userId) async {
    await chatRoomsCollection
        .doc(roomId)
        .collection('messages')
        .doc(messageId)
        .update({
      'likes': FieldValue.increment(-1),
      'likedBy': FieldValue.arrayRemove([userId]),
    });
  }

  // Flag chat message for moderation
  Future<void> flagChatMessage({
    required String roomId,
    required String messageId,
    required String reportedBy,
    required String reason,
  }) async {
    await chatRoomsCollection
        .doc(roomId)
        .collection('messages')
        .doc(messageId)
        .update({
      'flaggedBy': FieldValue.arrayUnion([reportedBy]),
      'requiresReview': true,
    });
    
    // Create moderation report
    final report = ModerationReportModel(
      id: '',
      messageId: messageId,
      roomId: roomId,
      reportedBy: reportedBy,
      reason: reason,
      createdAt: DateTime.now(),
    );
    
    await _firestore
        .collection('moderation_reports')
        .add(report.toJson());
  }

  // Join chat room
  Future<void> joinChatRoom(String roomId, String userId) async {
    await chatRoomsCollection.doc(roomId).update({
      'memberIds': FieldValue.arrayUnion([userId]),
      'memberJoinDates.$userId': FieldValue.serverTimestamp(),
    });
  }

  // Leave chat room
  Future<void> leaveChatRoom(String roomId, String userId) async {
    await chatRoomsCollection.doc(roomId).update({
      'memberIds': FieldValue.arrayRemove([userId]),
      'memberJoinDates.$userId': FieldValue.delete(),
    });
  }

  // ============ FAITH JOURNEY OPERATIONS ============

  // Faith journey collection reference
  CollectionReference<FaithJourney> get faithJourneyCollection =>
      _firestore.collection('faith_journeys').withConverter(
            fromFirestore: (doc, _) => FaithJourney.fromFirestore(doc),
            toFirestore: (journey, _) => journey.toJson(),
          );

  // Create faith journey
  Future<void> createFaithJourney(FaithJourney journey) async {
    await faithJourneyCollection.doc(journey.userId).set(journey);
  }

  // Get faith journey by user ID
  Future<FaithJourney?> getFaithJourney(String userId) async {
    final doc = await faithJourneyCollection.doc(userId).get();
    return doc.exists ? doc.data() : null;
  }

  // Update faith journey
  Future<void> updateFaithJourney(String userId, Map<String, dynamic> updates) async {
    await faithJourneyCollection.doc(userId).update(updates);
  }

  // Stream faith journey
  Stream<FaithJourney?> streamFaithJourney(String userId) {
    return faithJourneyCollection.doc(userId).snapshots().map(
          (doc) => doc.exists ? doc.data() : null,
        );
  }

  // Update reading stats
  Future<void> updateReadingStats({
    required String userId,
    required String book,
    required int chapter,
    required int verse,
    required int versesCount,
  }) async {
    final journeyRef = faithJourneyCollection.doc(userId);
    final today = DateTime.now();
    final todayStr = '${today.year}-${today.month}-${today.day}';
    
    await _firestore.runTransaction((transaction) async {
      final journeyDoc = await transaction.get(journeyRef);
      final journey = journeyDoc.exists 
          ? FaithJourney.fromJson(journeyDoc.data()!)
          : null;
      
      final updates = <String, dynamic>{};
      
      // Update book progress
      updates['bookProgress.$book'] = FieldValue.increment(versesCount);
      
      // Update last read
      updates['lastRead.$book'] = FieldValue.serverTimestamp();
      
      // Update reading history
      updates['readingHistory'] = FieldValue.arrayUnion([today]);
      
      // Update counters
      updates['versesRead'] = FieldValue.increment(versesCount);
      updates['chaptersRead'] = FieldValue.increment(1);
      updates['totalDaysRead'] = FieldValue.increment(1);
      updates['lastUpdatedAt'] = FieldValue.serverTimestamp();
      
      // Check for consecutive days
      if (journey != null) {
        final lastReadingDate = journey.lastReadingDate;
        
        if (lastReadingDate != null) {
          final lastDate = DateTime(
            lastReadingDate.year,
            lastReadingDate.month,
            lastReadingDate.day,
          );
          final todayDate = DateTime(today.year, today.month, today.day);
          final diff = todayDate.difference(lastDate).inDays;
          
          if (diff == 1) {
            // Consecutive day
            updates['consecutiveDays'] = FieldValue.increment(1);
            
            // Check if this extends the longest streak
            if (journey.consecutiveDays + 1 > journey.longestStreak) {
              updates['longestStreak'] = journey.consecutiveDays + 1;
            }
          } else if (diff > 1) {
            // Streak broken
            updates['consecutiveDays'] = 1;
          } else {
            // Same day, don't increment
            updates.remove('consecutiveDays');
          }
        } else {
          // First reading
          updates['consecutiveDays'] = 1;
          updates['streakStartDate'] = today.millisecondsSinceEpoch;
        }
      } else {
        // First reading ever
        updates['consecutiveDays'] = 1;
        updates['streakStartDate'] = today.millisecondsSinceEpoch;
        updates['startedAt'] = FieldValue.serverTimestamp();
      }
      
      updates['lastReadingDate'] = today;
      
      transaction.update(journeyRef, updates);
    });
    
    // Also update user's reading stats
    await usersCollection.doc(userId).update({
      'readingStats.bookProgress.$book': FieldValue.increment(versesCount),
      'readingStats.lastRead.$book': FieldValue.serverTimestamp(),
      'readingStats.totalVersesRead': FieldValue.increment(versesCount),
      'readingStats.totalChaptersRead': FieldValue.increment(1),
      'lastReadingDate': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // Check and update role progression
  Future<void> checkRoleProgression(String userId) async {
    final journey = await getFaithJourney(userId);
    final user = await getUser(userId);
    
    if (journey == null || user == null) return;
    
    final currentRole = journey.currentRole;
    UserRole? nextRole;
    bool shouldPromote = false;
    
    switch (currentRole) {
      case UserRole.believer:
        if (journey.consecutiveDays >= 7) {
          nextRole = UserRole.preacher;
          shouldPromote = true;
        }
        break;
      case UserRole.preacher:
        if (journey.consecutiveDays >= 30) {
          nextRole = UserRole.shepherd;
          shouldPromote = true;
        }
        break;
      case UserRole.shepherd:
        if (journey.consecutiveDays >= 365) {
          nextRole = UserRole.bishop;
          shouldPromote = true;
        }
        break;
      case UserRole.bishop:
        // Bishop is the highest role
        break;
    }
    
    if (shouldPromote && nextRole != null) {
      // Update user role
      await usersCollection.doc(userId).update({
        'role': nextRole.name,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      
      // Update faith journey
      await updateFaithJourney(userId, {
        'currentRole': nextRole.name,
        'hasReached${nextRole.name.capitalize()}': true,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      
      // Create milestone
      final milestone = FaithMilestone(
        id: '',
        userId: userId,
        type: FaithMilestoneType.rolePromotion,
        title: 'Promoted to ${nextRole.displayName}' ,
        description: 'You have achieved the ${nextRole.displayName} role through consistent Bible reading!',
        achievedAt: DateTime.now(),
        isAchieved: true,
        createdAt: DateTime.now(),
      );
      
      await _firestore
          .collection('users/$userId/faith_milestones')
          .add(milestone.toJson());
    }
  }

  // Update follower count and check bishop eligibility
  Future<void> updateFollowerCount(String userId) async {
    final user = await getUser(userId);
    final journey = await getFaithJourney(userId);
    
    if (user == null) return;
    
    // Check if user has reached bishop requirements
    if (user.followersCount >= 1000 && 
        user.role != UserRole.bishop &&
        !user.hasPaidToSkipLadder) {
      
      // Promote to bishop
      await usersCollection.doc(userId).update({
        'role': UserRole.bishop.name,
        'canPostOnBlog': true,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      
      if (journey != null) {
        await updateFaithJourney(userId, {
          'currentRole': UserRole.bishop.name,
          'hasReachedBishop': true,
          'canPostOnBlog': true,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
    }
  }

  // ============ READING HABIT OPERATIONS ============

  // Reading habit collection reference
  CollectionReference<ReadingHabit> get readingHabitCollection =>
      _firestore.collection('reading_habits').withConverter(
            fromFirestore: (doc, _) => ReadingHabit.fromFirestore(doc),
            toFirestore: (habit, _) => habit.toJson(),
          );

  // Get reading habit
  Future<ReadingHabit?> getReadingHabit(String userId) async {
    final doc = await readingHabitCollection.doc(userId).get();
    return doc.exists ? doc.data() : null;
  }

  // Update reading habit
  Future<void> updateReadingHabit(String userId, Map<String, dynamic> updates) async {
    await readingHabitCollection.doc(userId).update(updates);
  }

  // Record reading session
  Future<void> recordReadingSession(ReadingSession session) async {
    final habitRef = readingHabitCollection.doc(session.userId);
    
    await _firestore.runTransaction((transaction) async {
      final habitDoc = await transaction.get(habitRef);
      final habit = habitDoc.exists 
          ? ReadingHabit.fromJson(habitDoc.data()!)
          : ReadingHabit(userId: session.userId);
      
      // Add session to recent sessions (keep last 10)
      final recentSessions = [...habit.recentSessions, session];
      if (recentSessions.length > 10) {
        recentSessions.removeAt(0);
      }
      
      // Update preferred hours and days
      final hour = session.startedAt.hour;
      final day = session.startedAt.weekday - 1; // Convert to 0-6 (Sunday=0)
      
      final preferredHours = [...habit.preferredHours];
      if (!preferredHours.contains(hour)) {
        preferredHours.add(hour);
      }
      
      final preferredDays = [...habit.preferredDays];
      if (!preferredDays.contains(day)) {
        preferredDays.add(day);
      }
      
      final updates = <String, dynamic>{}
        ..['recentSessions'] = recentSessions.map((s) => s.toJson()).toList()
        ..['preferredHours'] = preferredHours
        ..['preferredDays'] = preferredDays
        ..['averageReadsPerDay'] = (habit.averageReadsPerDay + 1)
        ..['updatedAt'] = FieldValue.serverTimestamp();
      
      if (session.endedAt != null) {
        final duration = session.endedAt!.difference(session.startedAt).inMinutes;
        updates['averageDurationMinutes'] = (
          (habit.averageDurationMinutes * habit.recentSessions.length + duration) /
          (habit.recentSessions.length + 1)
        ).round();
      }
      
      transaction.update(habitRef, updates);
    });
    
    // Save session
    await _firestore
        .collection('reading_sessions')
        .doc(session.id)
        .set(session.toJson());
  }

  // ============ PREMIUM OPERATIONS ============

  // Subscriptions collection reference
  CollectionReference<Subscription> get subscriptionsCollection =>
      _firestore.collection('subscriptions').withConverter(
            fromFirestore: (doc, _) => Subscription.fromFirestore(doc),
            toFirestore: (sub, _) => sub.toJson(),
          );

  // Payments collection reference
  CollectionReference<Payment> get paymentsCollection =>
      _firestore.collection('payments').withConverter(
            fromFirestore: (doc, _) => Payment.fromFirestore(doc),
            toFirestore: (payment, _) => payment.toJson(),
          );

  // Create subscription
  Future<String> createSubscription(Subscription subscription) async {
    final docRef = subscriptionsCollection.doc();
    subscription = subscription.copyWith(id: docRef.id);
    await docRef.set(subscription);
    return docRef.id;
  }

  // Get subscription by user ID
  Future<Subscription?> getActiveSubscription(String userId) async {
    final snapshot = await subscriptionsCollection
        .where('userId', isEqualTo: userId)
        .where('isActive', isEqualTo: true)
        .orderBy('endDate', descending: true)
        .limit(1)
        .get();
    
    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.data();
    }
    return null;
  }

  // Get all subscriptions by user
  Future<List<Subscription>> getUserSubscriptions(String userId) async {
    final snapshot = await subscriptionsCollection
        .where('userId', isEqualTo: userId)
        .orderBy('startDate', descending: true)
        .get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  // Create payment
  Future<String> createPayment(Payment payment) async {
    final docRef = paymentsCollection.doc();
    payment = payment.copyWith(id: docRef.id);
    await docRef.set(payment);
    return docRef.id;
  }

  // Process ladder skip payment
  Future<void> processLadderSkipPayment({
    required String userId,
    required double amount,
    required String transactionId,
    required UserRole fromRole,
    required UserRole toRole,
  }) async {
    // Create payment record
    final payment = Payment(
      id: '',
      userId: userId,
      amount: amount,
      currency: 'USD',
      method: PaymentMethod.creditCard,
      status: PaymentStatus.completed,
      transactionId: transactionId,
      description: 'Ladder skip from ${fromRole.displayName} to ${toRole.displayName}',
      isForLadderSkip: true,
      ladderSkipFromRole: fromRole.name,
      ladderSkipToRole: toRole.name,
      createdAt: DateTime.now(),
      completedAt: DateTime.now(),
    );
    
    await createPayment(payment);
    
    // Update user
    await usersCollection.doc(userId).update({
      'role': toRole.name,
      'hasPaidToSkipLadder': true,
      'canPostOnBlog': true,
      'updatedAt': FieldValue.serverTimestamp(),
    });
    
    // Update faith journey
    final journey = await getFaithJourney(userId);
    if (journey != null) {
      await updateFaithJourney(userId, {
        'currentRole': toRole.name,
        'hasReached${toRole.name.capitalize()}': true,
        'hasPaidToSkip': true,
        'canPostOnBlog': true,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  // Update premium tier
  Future<void> updatePremiumTier(String userId, PremiumTier tier) async {
    await usersCollection.doc(userId).update({
      'premiumTier': tier.name,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // ============ NOTIFICATION OPERATIONS ============

  // Notifications collection reference
  CollectionReference get notificationsCollection =>
      _firestore.collection('notifications');

  // Create notification
  Future<void> createNotification({
    required String userId,
    required String title,
    required String body,
    required Map<String, dynamic> data,
  }) async {
    await notificationsCollection.add({
      'userId': userId,
      'title': title,
      'body': body,
      'data': data,
      'isRead': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Get user notifications
  Future<List<DocumentSnapshot>> getUserNotifications(String userId) async {
    final snapshot = await notificationsCollection
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .limit(50)
        .get();
    return snapshot.docs;
  }

  // Mark notification as read
  Future<void> markNotificationAsRead(String notificationId) async {
    await notificationsCollection.doc(notificationId).update({
      'isRead': true,
    });
  }

  // Mark all notifications as read
  Future<void> markAllNotificationsAsRead(String userId) async {
    final snapshot = await notificationsCollection
        .where('userId', isEqualTo: userId)
        .where('isRead', isEqualTo: false)
        .get();
    
    for (final doc in snapshot.docs) {
      await doc.reference.update({'isRead': true});
    }
  }

  // ============ STATISTICS OPERATIONS ============

  // Get app statistics
  Future<Map<String, dynamic>> getAppStatistics() async {
    final usersSnapshot = await usersCollection.count().get();
    final postsSnapshot = await blogPostsCollection.count().get();
    final roomsSnapshot = await chatRoomsCollection.count().get();
    
    return {
      'totalUsers': usersSnapshot.count,
      'totalBlogPosts': postsSnapshot.count,
      'totalChatRooms': roomsSnapshot.count,
      'activeUsers': 0, // Can be calculated from presence
      'premiumUsers': 0, // Can be calculated from subscriptions
    };
  }

  // ============ HELPER METHODS ============

  // Batch write
  Future<void> batchWrite(List<Function> operations) async {
    final batch = _firestore.batch();
    
    for (final operation in operations) {
      operation(batch);
    }
    
    await batch.commit();
  }

  // Run transaction
  Future<T> runTransaction<T>(Future<T> Function(Transaction) transactionHandler) async {
    return _firestore.runTransaction<T>(transactionHandler);
  }
}

extension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}
