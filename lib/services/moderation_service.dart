import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/chat_model.dart';
import '../models/user_model.dart';
import 'local_storage_service.dart';

// Moderation Service Provider
final moderationServiceProvider = Provider<ModerationService>((ref) {
  return ModerationService(
    storage: ref.read(localStorageServiceProvider),
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
  final LocalStorageService _storage;
  final ModerationConfig _config;
  
  // Keyword-based classification, matched on whole words / phrases only
  // (so "hello" never matches "hell" and "toward" never matches "war").
  //
  // Words that appear in the KJV itself (devil, hell, kill, whore, ass,
  // cock, liberal, government, war, ...) are deliberately NOT listed, so
  // members can quote Scripture freely.

  /// Insults and hostile language: allowed but flagged for review.
  static const Set<String> _toxicWords = {
    'stupid', 'idiot', 'idiots', 'dumb', 'moron', 'morons', 'retard',
    'retarded', 'loser', 'shut up', 'hate you', 'kill yourself', 'kys',
    'racist', 'bigot', 'sexist', 'homophobic', 'scum', 'trash',
  };

  /// Profanity and slurs: always rejected.
  static const Set<String> _offensiveWords = {
    'fuck', 'fucking', 'fucker', 'motherfucker', 'shit', 'bullshit',
    'asshole', 'bitch', 'bastards', 'slut', 'cunt', 'pussy', 'dick',
    'wtf', 'stfu',
    'nigger', 'nigga', 'chink', 'kike', 'spic', 'wetback',
    'fag', 'faggot', 'dyke', 'tranny',
  };

  /// Clearly partisan / political terms. One mention is fine; a message
  /// needs two or more to count as political discussion.
  static const Set<String> _politicalWords = {
    'politics', 'political', 'politician', 'politicians', 'election',
    'elections', 'ballot', 'democrat', 'democrats', 'republican',
    'republicans', 'gop', 'left wing', 'right wing', 'leftist', 'rightist',
    'socialist', 'communist', 'fascist', 'capitalism', 'socialism',
    'communism', 'fascism', 'congress', 'senate', 'parliament',
    'president', 'prime minister', 'immigration', 'abortion', 'pro-choice',
    'pro-life', 'gun control', 'second amendment', 'nra', 'climate change',
    'global warming', 'trump', 'biden', 'maga', 'woke',
  };

  static final Map<String, RegExp> _patternCache = {};

  static RegExp _pattern(String term) => _patternCache.putIfAbsent(
        term,
        () => RegExp(
          r'(?<![a-z0-9])' + RegExp.escape(term).replaceAll(' ', r'\s+') + r'(?![a-z0-9])',
          caseSensitive: false,
        ),
      );

  static List<String> _findTerms(String text, Iterable<String> terms) =>
      [for (final t in terms) if (_pattern(t).hasMatch(text)) t];

  ModerationService({
    required LocalStorageService storage,
    ModerationConfig? config,
  })  : _storage = storage,
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
    
    final foundBlockedWords = _findTerms(message, _config.blockedWords);
    final foundToxicWords = _findTerms(message, _toxicWords);
    final foundOffensiveWords = _findTerms(message, _offensiveWords);
    final foundPoliticalWords = _findTerms(message, _politicalWords);

    // Scores are 0..1 and compared against the configured thresholds.
    final toxicityScore = foundToxicWords.isEmpty
        ? 0.0
        : min(0.5 + 0.25 * foundToxicWords.length, 1.0);
    final offensiveScore = foundOffensiveWords.isEmpty ? 0.0 : 1.0;
    final politicalScore = min(foundPoliticalWords.length * 0.4, 1.0);

    // Check for gospel-related content
    final hasGospelContent = _hasGospelContent(message);
    
    // Determine if message should be flagged
    final isToxic = toxicityScore >= _config.toxicityThreshold;
    final isOffensive = offensiveScore >= _config.offensiveThreshold;
    final isPolitical = politicalScore >= _config.politicalThreshold;
    final hasBlockedWords = foundBlockedWords.isNotEmpty;
    
    final isFlagged = isToxic || isOffensive || isPolitical || hasBlockedWords;
    final requiresReview = isFlagged;
    
    // Determine violations
    final violations = <String>[];
    if (isToxic) violations.add('Toxic language');
    if (isOffensive) violations.add('Offensive language');
    if (isPolitical) violations.add('Political content');
    if (hasBlockedWords) violations.add('Blocked words');
    if (!hasGospelContent && isPolitical) {
      violations.add('Please keep discussions focused on the Gospel');
    }
    
    // Determine action
    ModerationAction action = ModerationAction.none;
    if (isOffensive || hasBlockedWords) {
      action = ModerationAction.reject;
    } else if (isPolitical && !hasGospelContent) {
      action = ModerationAction.reject;
    } else if (isToxic) {
      action = ModerationAction.flag;
    } else if (isPolitical) {
      action = ModerationAction.warn;
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
      blockedWords: [...foundBlockedWords, ...foundOffensiveWords],
      violations: violations,
      action: action,
      reason: reason,
    );
  }

  /// Check if message contains gospel-related content
  bool _hasGospelContent(String message) {
    final normalized = message.toLowerCase();
    
    if (_findTerms(normalized, _config.allowedTopics).isNotEmpty) {
      return true;
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
    final user = await _storage.getUser(userId);
    if (user == null) return false;
    
    // Check recent violations - simplified for local storage
    // In production, you would track violations in a separate collection
    return false;
  }

  /// Check if user is banned or suspended
  Future<bool> isUserRestricted(String userId) async {
    final user = await _storage.getUser(userId);
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
          await _storage.updateUser(userId, {
            'status': UserStatus.active,
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
      filtered = filtered.replaceAllMapped(
        _pattern(word),
        (m) => '*' * m.group(0)!.length,
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
    return _findTerms(text, _politicalWords).length >= 2;
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
      status: ModerationStatus.pending,
    );
    
    final id = _storage.generateId();
    await _storage.createModerationReport(report.copyWith(id: id));
    return id;
  }

  /// Get pending moderation reports
  Future<List<ModerationReportModel>> getPendingReports() async {
    return _storage.getModerationReports(status: ModerationStatus.pending);
  }

  /// Review a moderation report
  Future<void> reviewReport({
    required String reportId,
    required ModerationStatus status,
    required String reviewedBy,
    String? actionDescription,
    bool actionTaken = false,
  }) async {
    await _storage.updateModerationReport(reportId, {
      'status': status,
      'reviewedBy': reviewedBy,
      'reviewedAt': DateTime.now(),
      'actionTaken': actionTaken,
      'actionDescription': actionDescription,
    });
  }

}

/// Moderation result
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

  ModerationResult({
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

/// Moderation action types
enum ModerationAction {
  none,
  flag,
  warn,
  delete,
  reject,
  suspend,
  ban,
}

