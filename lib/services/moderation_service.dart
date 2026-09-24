import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:natural_language/natural_language.dart';

import '../models/chat_model.dart';
import '../models/user_model.dart';
import 'database_service.dart';

// Moderation Service Provider
final moderationServiceProvider = Provider<ModerationService>((ref) {
  return ModerationService(
    databaseService: ref.read(databaseServiceProvider),
  );
});

/// Moderation configuration
class ModerationConfig {
  final double toxicityThreshold;
  final double offensiveThreshold;
  final double politicalThreshold;
  final List<String> blockedWords;
  final List<String> allowedTopics;
  final bool autoDeleteFlagged;
  final bool autoWarnUser;
  final bool autoSuspendUser;

  ModerationConfig({
    this.toxicityThreshold = 0.7,
    this.offensiveThreshold = 0.8,
    this.politicalThreshold = 0.5,
    this.blockedWords = const [],
    this.allowedTopics = const [
      'jesus',
      'christ',
      'god',
      'bible',
      'scripture',
      'faith',
      'prayer',
      'gospel',
      'church',
      'salvation',
      'grace',
      'mercy',
      'love',
      'hope',
      'peace',
      'joy',
      'worship',
      'praise',
      'holy spirit',
      'trinity',
      'heaven',
      'eternal life',
      'sin',
      'redemption',
      'forgiveness',
      'repentance',
      'discipleship',
      'mission',
      'evangelism',
    ],
    this.autoDeleteFlagged = false,
    this.autoWarnUser = true,
    this.autoSuspendUser = false,
  });
}

class ModerationService {
  final DatabaseService _databaseService;
  final ModerationConfig _config;
  
  // Simple word-based classification (for demo purposes)
  // In production, you would use a proper ML model
  final _toxicWords = {
    'hate', 'kill', 'murder', 'violence', 'terror', 'war', 'bomb',
    'racist', 'racism', 'sexist', 'sexism', 'homophobic', 'bigot',
    'stupid', 'idiot', 'fool', 'dumb', 'moron', 'retard',
    'fuck', 'shit', 'asshole', 'bitch', 'whore', 'slut',
    'damn', 'hell', 'satan', 'devil', 'demon',
  };
  
  final _politicalWords = {
    'politics', 'political', 'government', 'president', 'prime minister',
    'congress', 'senate', 'parliament', 'election', 'vote', 'voting',
    'democrat', 'republican', 'liberal', 'conservative', 'socialist',
    'communist', 'fascist', 'nazi', 'leftist', 'rightist',
    'capitalism', 'socialism', 'communism', 'fascism',
    'immigration', 'border', 'wall', 'migration',
    'tax', 'taxes', 'economy', 'economic',
    'abortion', 'pro-choice', 'pro-life', 'gay marriage', 'lgbt',
    'gun control', 'second amendment', 'nra',
    'climate change', 'global warming', 'environment',
    'war', 'military', 'army', 'navy', 'air force',
  };
  
  final _offensiveWords = {
    ..._toxicWords,
    'nigger', 'nigga', 'chink', 'kike', 'spic', 'wetback',
    'fag', 'faggot', 'homo', 'dyke', 'tranny',
    'cunt', 'pussy', 'dick', 'cock', 'penis', 'vagina',
    'rape', 'molest', 'pedophile', 'child abuse',
    'suicide', 'self-harm', 'cutting',
  };

  ModerationService({
    required DatabaseService databaseService,
    ModerationConfig? config,
  })  : _databaseService = databaseService,
        _config = config ?? ModerationConfig();

  // ============ MESSAGE MODERATION ============

  /// Moderate a chat message before sending
  Future<ModerationResult> moderateMessage({
    required String message,
    required String senderId,
    required String roomId,
  }) async {
    final result = ModerationResult(
      messageId: '',
      isAllowed: true,
      isFlagged: false,
      requiresReview: false,
      toxicityScore: 0.0,
      offensiveScore: 0.0,
      politicalScore: 0.0,
      blockedWords: [],
      violations: [],
      action: ModerationAction.none,
      reason: '',
    );
    
    // Check for empty message
    if (message.trim().isEmpty) {
      return result.copyWith(
        isAllowed: false,
        violations: ['Empty message'],
        action: ModerationAction.reject,
        reason: 'Message cannot be empty',
      );
    }
    
    // Check message length
    if (message.length > 1000) {
      return result.copyWith(
        isAllowed: false,
        violations: ['Message too long'],
        action: ModerationAction.reject,
        reason: 'Message exceeds maximum length',
      );
    }
    
    // Normalize message for analysis
    final normalized = message.toLowerCase();
    
    // Check for blocked words
    final foundBlockedWords = <String>[];
    for (final word in _config.blockedWords) {
      if (normalized.contains(word.toLowerCase())) {
        foundBlockedWords.add(word);
      }
    }
    
    // Check for toxic words
    final foundToxicWords = <String>[];
    for (final word in _toxicWords) {
      if (normalized.contains(word.toLowerCase())) {
        foundToxicWords.add(word);
      }
    }
    
    // Check for offensive words
    final foundOffensiveWords = <String>[];
    for (final word in _offensiveWords) {
      if (normalized.contains(word.toLowerCase())) {
        foundOffensiveWords.add(word);
      }
    }
    
    // Check for political words
    final foundPoliticalWords = <String>[];
    for (final word in _politicalWords) {
      if (normalized.contains(word.toLowerCase())) {
        foundPoliticalWords.add(word);
      }
    }
    
    // Calculate scores
    final toxicityScore = min(
      foundToxicWords.length / _toxicWords.length,
      1.0,
    );
    final offensiveScore = min(
      foundOffensiveWords.length / _offensiveWords.length,
      1.0,
    );
    final politicalScore = min(
      foundPoliticalWords.length / _politicalWords.length,
      1.0,
    );
    
    // Check for gospel-related content
    final hasGospelContent = _hasGospelContent(message);
    
    // Determine if message should be flagged
    final isToxic = toxicityScore >= _config.toxicityThreshold;
    final isOffensive = offensiveScore >= _config.offensiveThreshold;
    final isPolitical = politicalScore >= _config.politicalThreshold;
    final hasBlockedWords = foundBlockedWords.isNotEmpty;
    
    final isFlagged = isToxic || isOffensive || isPolitical || hasBlockedWords;
    final requiresReview = isFlagged && !hasGospelContent;
    
    // Determine violations
    final violations = <String>[];
    if (isToxic) violations.add('Toxic language');
    if (isOffensive) violations.add('Offensive language');
    if (isPolitical) violations.add('Political content');
    if (hasBlockedWords) violations.add('Blocked words');
    if (!hasGospelContent && isPolitical) {
      violations.add('Non-gospel political discussion');
    }
    
    // Determine action
    ModerationAction action = ModerationAction.none;
    if (isFlagged) {
      if (isOffensive) {
        action = _config.autoDeleteFlagged 
            ? ModerationAction.delete 
            : ModerationAction.flag;
      } else if (isToxic) {
        action = ModerationAction.flag;
      } else if (isPolitical && !hasGospelContent) {
        action = ModerationAction.warn;
      }
    }
    
    // Build reason
    String reason = '';
    if (violations.isNotEmpty) {
      reason = violations.join(', ');
    }
    
    return result.copyWith(
      isAllowed: action != ModerationAction.delete && action != ModerationAction.reject,
      isFlagged: isFlagged,
      requiresReview: requiresReview,
      toxicityScore: toxicityScore,
      offensiveScore: offensiveScore,
      politicalScore: politicalScore,
      blockedWords: [...foundBlockedWords, ...foundToxicWords, ...foundOffensiveWords],
      violations: violations,
      action: action,
      reason: reason,
    );
  }

  /// Check if message contains gospel-related content
  bool _hasGospelContent(String message) {
    final normalized = message.toLowerCase();
    
    for (final topic in _config.allowedTopics) {
      if (normalized.contains(topic.toLowerCase())) {
        return true;
      }
    }
    
    // Additional gospel-related phrases
    final gospelPhrases = [
      'jesus christ',
      'lord jesus',
      'god the father',
      'holy spirit',
      'bible says',
      'scripture says',
      'word of god',
      'god\'s word',
      'heavenly father',
      'our savior',
      'christ died',
      'jesus died',
      'resurrection',
      'crucifixion',
      'salvation',
      'eternal life',
      'kingdom of god',
      'kingdom of heaven',
      'good news',
      'gospel of christ',
      'born again',
      'saved by grace',
      'faith in jesus',
      'trust in god',
      'love of christ',
      'peace of god',
      'joy of the lord',
      'fruits of the spirit',
      'armor of god',
      'prayer',
      'worship',
      'praise',
      'thank you lord',
      'thank you jesus',
      'thank you god',
      'amen',
      'hallelujah',
      'praise the lord',
    ];
    
    for (final phrase in gospelPhrases) {
      if (normalized.contains(phrase.toLowerCase())) {
        return true;
      }
    }
    
    return false;
  }

  /// Moderate a blog comment
  Future<ModerationResult> moderateBlogComment({
    required String content,
    required String authorId,
    required String postId,
  }) async {
    // Similar to message moderation but with different thresholds
    final tempConfig = ModerationConfig(
      toxicityThreshold: 0.5,
      offensiveThreshold: 0.6,
      politicalThreshold: 0.3,
      autoDeleteFlagged: false,
      autoWarnUser: true,
      autoSuspendUser: false,
    );
    
    final result = await moderateMessage(
      message: content,
      senderId: authorId,
      roomId: postId,
    );
    
    // Override with blog-specific config
    return result.copyWith(
      isAllowed: result.toxicityScore < tempConfig.toxicityThreshold &&
          result.offensiveScore < tempConfig.offensiveThreshold &&
          (result.politicalScore < tempConfig.politicalThreshold ||
           _hasGospelContent(content)),
    );
  }

  /// Moderate a blog post
  Future<ModerationResult> moderateBlogPost({
    required String title,
    required String content,
    required String authorId,
  }) async {
    final combined = '$title $content';
    
    final result = await moderateMessage(
      message: combined,
      senderId: authorId,
      roomId: '',
    );
    
    return result.copyWith(
      isAllowed: result.toxicityScore < 0.3 &&
          result.offensiveScore < 0.4,
    );
  }

  // ============ USER MODERATION ============

  /// Check if user should be warned
  Future<bool> shouldWarnUser(String userId) async {
    final user = await _databaseService.getUser(userId);
    if (user == null) return false;
    
    // Check recent violations
    final reports = await _getUserViolations(userId);
    
    // Warn if user has multiple recent violations
    return reports.length >= 3;
  }

  /// Get user violations
  Future<List<ModerationReportModel>> _getUserViolations(String userId) async {
    final snapshot = await _databaseService._firestore
        .collection('moderation_reports')
        .where('reportedBy', isNotEqualTo: userId) // Don't count reports by the user
        .where('status', isEqualTo: ModerationStatus.pending.name)
        .get();
    
    return snapshot.docs
        .map((doc) => ModerationReportModel.fromJson(doc.data()))
        .toList();
  }

  /// Warn a user
  Future<void> warnUser({
    required String userId,
    required String reason,
    required String reportedBy,
  }) async {
    // Create warning record
    await _databaseService._firestore
        .collection('user_warnings')
        .add({
      'userId': userId,
      'reason': reason,
      'reportedBy': reportedBy,
      'createdAt': FieldValue.serverTimestamp(),
      'status': 'active',
    });
    
    // Update user
    await _databaseService.updateUser(userId, {
      'warnings': FieldValue.increment(1),
    });
    
    // Send notification
    await _databaseService.createNotification(
      userId: userId,
      title: 'Warning Received',
      body: 'You have received a warning for: $reason',
      data: {'type': 'warning', 'reason': reason},
    );
  }

  /// Suspend a user
  Future<void> suspendUser({
    required String userId,
    required String reason,
    required Duration duration,
    required String suspendedBy,
  }) async {
    final endDate = DateTime.now().add(duration);
    
    // Update user
    await _databaseService.updateUser(userId, {
      'status': UserStatus.suspended.name,
      'suspendedAt': FieldValue.serverTimestamp(),
      'suspensionEndDate': endDate,
      'suspensionReason': reason,
      'suspendedBy': suspendedBy,
    });
    
    // Create suspension record
    await _databaseService._firestore
        .collection('user_suspensions')
        .add({
      'userId': userId,
      'reason': reason,
      'duration': duration.inDays,
      'startDate': FieldValue.serverTimestamp(),
      'endDate': endDate,
      'suspendedBy': suspendedBy,
      'createdAt': FieldValue.serverTimestamp(),
    });
    
    // Send notification
    await _databaseService.createNotification(
      userId: userId,
      title: 'Account Suspended',
      body: 'Your account has been suspended until ${endDate.toLocal().toString().split(' ')[0]} for: $reason',
      data: {
        'type': 'suspension',
        'reason': reason,
        'endDate': endDate.toIso8601String(),
      },
    );
  }

  /// Ban a user
  Future<void> banUser({
    required String userId,
    required String reason,
    required String bannedBy,
  }) async {
    // Update user
    await _databaseService.updateUser(userId, {
      'status': UserStatus.banned.name,
      'bannedAt': FieldValue.serverTimestamp(),
      'banReason': reason,
      'bannedBy': bannedBy,
    });
    
    // Create ban record
    await _databaseService._firestore
        .collection('user_bans')
        .add({
      'userId': userId,
      'reason': reason,
      'bannedBy': bannedBy,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// Check if user is banned or suspended
  Future<bool> isUserRestricted(String userId) async {
    final user = await _databaseService.getUser(userId);
    if (user == null) return false;
    
    if (user.status == UserStatus.banned) {
      return true;
    }
    
    if (user.status == UserStatus.suspended) {
      // Check if suspension has ended
      final suspensionEndDate = user.suspensionEndDate;
      if (suspensionEndDate != null) {
        final now = DateTime.now();
        if (now.isAfter(suspensionEndDate)) {
          // Suspension has ended, reactivate user
          await _databaseService.updateUser(userId, {
            'status': UserStatus.active.name,
          });
          return false;
        }
      }
      return true;
    }
    
    return false;
  }

  // ============ CONTENT FILTERING ============

  /// Filter out offensive content from text
  String filterContent(String text) {
    var filtered = text;
    
    for (final word in _offensiveWords) {
      filtered = filtered.replaceAll(
        RegExp('\b$word\b', caseSensitive: false),
        '*'.padLeft(word.length, '*'),
      );
    }
    
    return filtered;
  }

  /// Check if text contains gospel content
  bool containsGospelContent(String text) {
    return _hasGospelContent(text);
  }

  /// Check if text is political
  bool isPolitical(String text) {
    final normalized = text.toLowerCase();
    
    for (final word in _politicalWords) {
      if (normalized.contains(word.toLowerCase())) {
        return true;
      }
    }
    
    return false;
  }

  // ============ REPORT HANDLING ============

  /// Create a moderation report
  Future<String> createModerationReport({
    required String messageId,
    required String roomId,
    required String reportedBy,
    required String reason,
    String? additionalNotes,
  }) async {
    final report = ModerationReportModel(
      id: '',
      messageId: messageId,
      roomId: roomId,
      reportedBy: reportedBy,
      reason: reason,
      additionalNotes: additionalNotes,
      createdAt: DateTime.now(),
    );
    
    final docRef = await _databaseService._firestore
        .collection('moderation_reports')
        .add(report.toJson());
    
    return docRef.id;
  }

  /// Get pending moderation reports
  Future<List<ModerationReportModel>> getPendingReports() async {
    final snapshot = await _databaseService._firestore
        .collection('moderation_reports')
        .where('status', isEqualTo: ModerationStatus.pending.name)
        .orderBy('createdAt', descending: true)
        .get();
    
    return snapshot.docs
        .map((doc) => ModerationReportModel.fromJson(doc.data()))
        .toList();
  }

  /// Review a moderation report
  Future<void> reviewReport({
    required String reportId,
    required ModerationStatus status,
    required String reviewedBy,
    String? actionDescription,
    bool actionTaken = false,
  }) async {
    await _databaseService._firestore
        .collection('moderation_reports')
        .doc(reportId)
        .update({
      'status': status.name,
      'reviewedBy': reviewedBy,
      'reviewedAt': FieldValue.serverTimestamp(),
      'actionTaken': actionTaken,
      'actionDescription': actionDescription,
    });
  }

  // ============ AUTOMATED MODERATION ============

  /// Automatically moderate chat rooms
  Future<void> autoModerateChatRooms() async {
    final rooms = await _databaseService.getChatRooms();
    
    for (final room in rooms) {
      if (!room.autoModerate) continue;
      
      final messages = await _databaseService.getRecentChatMessages(
        room.id,
        limit: 100,
      );
      
      for (final message in messages) {
        if (message.moderationStatus != ModerationStatus.pending) continue;
        
        final result = await moderateMessage(
          message: message.content,
          senderId: message.senderId,
          roomId: room.id,
        );
        
        if (result.isFlagged) {
          // Update message moderation status
          await _databaseService._firestore
              .collection('chat_rooms/${room.id}/messages')
              .doc(message.id)
              .update({
            'moderationStatus': ModerationStatus.flagged.name,
            'toxicityScore': result.toxicityScore,
            'offensiveScore': result.offensiveScore,
            'politicalScore': result.politicalScore,
            'requiresReview': result.requiresReview,
          });
          
          // Take action based on configuration
          if (room.autoModerate) {
            if (result.action == ModerationAction.delete) {
              await _databaseService._firestore
                  .collection('chat_rooms/${room.id}/messages')
                  .doc(message.id)
                  .update({
                'isDeleted': true,
                'deletedBy': 'auto-moderator',
                'deletedAt': FieldValue.serverTimestamp(),
              });
            }
            
            if (result.action == ModerationAction.warn && _config.autoWarnUser) {
              await warnUser(
                userId: message.senderId,
                reason: result.reason,
                reportedBy: 'auto-moderator',
              );
            }
          }
        } else {
          // Mark as approved
          await _databaseService._firestore
              .collection('chat_rooms/${room.id}/messages')
              .doc(message.id)
              .update({
                'moderationStatus': ModerationStatus.approved.name,
              });
        }
      }
    }
  }
}

/// Moderation result
@immutable
class ModerationResult {
  final String messageId;
  final bool isAllowed;
  final bool isFlagged;
  final bool requiresReview;
  final double toxicityScore;
  final double offensiveScore;
  final double politicalScore;
  final List<String> blockedWords;
  final List<String> violations;
  final ModerationAction action;
  final String reason;

  const ModerationResult({
    required this.messageId,
    required this.isAllowed,
    required this.isFlagged,
    required this.requiresReview,
    required this.toxicityScore,
    required this.offensiveScore,
    required this.politicalScore,
    required this.blockedWords,
    required this.violations,
    required this.action,
    required this.reason,
  });

  ModerationResult copyWith({
    String? messageId,
    bool? isAllowed,
    bool? isFlagged,
    bool? requiresReview,
    double? toxicityScore,
    double? offensiveScore,
    double? politicalScore,
    List<String>? blockedWords,
    List<String>? violations,
    ModerationAction? action,
    String? reason,
  }) {
    return ModerationResult(
      messageId: messageId ?? this.messageId,
      isAllowed: isAllowed ?? this.isAllowed,
      isFlagged: isFlagged ?? this.isFlagged,
      requiresReview: requiresReview ?? this.requiresReview,
      toxicityScore: toxicityScore ?? this.toxicityScore,
      offensiveScore: offensiveScore ?? this.offensiveScore,
      politicalScore: politicalScore ?? this.politicalScore,
      blockedWords: blockedWords ?? this.blockedWords,
      violations: violations ?? this.violations,
      action: action ?? this.action,
      reason: reason ?? this.reason,
    );
  }
}

/// Moderation action
enum ModerationAction {
  none,
  flag,
  warn,
  delete,
  reject,
  suspend,
  ban,
}

/// Content category
enum ContentCategory {
  gospel,
  general,
  political,
  offensive,
  toxic,
  spam,
  unknown,
}
