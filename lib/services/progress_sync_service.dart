import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/faith_journey_model.dart';
import '../models/user_model.dart';
import 'local_storage_service.dart';

/// Keeps a member's reading progress the same on all their devices.
///
/// The device copy (Hive) stays the working copy, so reading works offline.
/// It is mirrored to `users/{uid}/private/progress` in Firestore, which only
/// the member can read (see firestore.rules), and changes from other devices
/// are merged in live.
class ProgressSyncService {
  ProgressSyncService(this._db, this._storage);

  final FirebaseFirestore _db;
  final LocalStorageService _storage;

  static const Duration pushDelay = Duration(seconds: 2);

  /// Fields of the user record that follow the member between devices.
  static const List<String> personalFields = [
    'savedVerseIds',
    'likedVerseIds',
    'bookmarkedBlogPostIds',
    'blockedUserIds',
    'preferences',
  ];

  String? _uid;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _remoteSub;
  StreamSubscription<FaithJourney?>? _journeySub;
  StreamSubscription<UserModel?>? _userSub;
  Timer? _pushTimer;
  String? _lastSynced; // JSON of the last state known to match Firestore

  DocumentReference<Map<String, dynamic>> _doc(String uid) =>
      _db.collection('users').doc(uid).collection('private').doc('progress');

  Future<void> start(String uid) async {
    await stop();
    _uid = uid;
    try {
      await _initialSync(uid);
    } catch (e) {
      debugPrint('Progress sync unavailable for now: $e');
    }
    if (_uid != uid) return; // signed out meanwhile
    _remoteSub = _doc(uid).snapshots().listen(_onRemote, onError: (Object e) {
      debugPrint('Progress sync error: $e');
    });
    _journeySub = _storage.streamFaithJourney(uid).skip(1).listen((_) => _schedulePush());
    _userSub = _storage.streamUser(uid).skip(1).listen((_) => _schedulePush());
  }

  Future<void> stop() async {
    _pushTimer?.cancel();
    await _remoteSub?.cancel();
    await _journeySub?.cancel();
    await _userSub?.cancel();
    _remoteSub = null;
    _journeySub = null;
    _userSub = null;
    _uid = null;
    _lastSynced = null;
  }

  /// Pushes any pending local change now (e.g. before signing out).
  Future<void> flush() async {
    if (_pushTimer?.isActive ?? false) {
      _pushTimer!.cancel();
      await _push();
    }
  }

  /// Deletes the online copy (used when deleting the account).
  Future<void> deleteRemote(String uid) => _doc(uid).delete();

  // ------------------------------------------------------------ syncing

  Future<Map<String, dynamic>?> _localState(String uid) async {
    final user = await _storage.getUser(uid);
    if (user == null) return null;
    final journey = await _storage.getFaithJourney(uid);
    final userJson = user.toJson();
    return {
      if (journey != null) 'journey': _syncedJourneyJson(journey),
      for (final f in personalFields) f: userJson[f],
    };
  }

  /// Bishop status and follower counts come from the public profile, so
  /// they are not part of the synced progress.
  static Map<String, dynamic> _syncedJourneyJson(FaithJourney j) {
    final json = j.toJson()
      ..remove('followerCount')
      ..remove('lastUpdatedAt');
    if (j.currentRole == UserRole.bishop) json['currentRole'] = UserRole.shepherd.name;
    return json;
  }

  Future<void> _initialSync(String uid) async {
    final snap = await _doc(uid).get();
    final remote = snap.data();
    if (remote != null) {
      await _apply(uid, remote, unionLists: true);
    }
    await _push();
  }

  void _schedulePush() {
    _pushTimer?.cancel();
    _pushTimer = Timer(pushDelay, () => _push());
  }

  Future<void> _push() async {
    final uid = _uid;
    if (uid == null) return;
    final state = await _localState(uid);
    if (state == null) return;
    final encoded = jsonEncode(state);
    if (encoded == _lastSynced) return;
    try {
      await _doc(uid).set({...state, 'updatedAt': FieldValue.serverTimestamp()});
      _lastSynced = encoded;
    } catch (e) {
      debugPrint('Progress upload failed (will retry on next change): $e');
    }
  }

  Future<void> _onRemote(DocumentSnapshot<Map<String, dynamic>> snap) async {
    final uid = _uid;
    final data = snap.data();
    if (uid == null || data == null || snap.metadata.hasPendingWrites) return;
    await _apply(uid, data, unionLists: false);
  }

  /// Merges remote progress into the device copy.
  Future<void> _apply(String uid, Map<String, dynamic> remote, {required bool unionLists}) async {
    final user = await _storage.getUser(uid);
    if (user == null) return;

    // Reading progress: merged, so nothing read on either device is lost.
    final remoteJourneyJson = remote['journey'];
    if (remoteJourneyJson is Map) {
      FaithJourney? remoteJourney;
      try {
        remoteJourney = FaithJourney.fromJson(Map<String, dynamic>.from(remoteJourneyJson));
      } catch (_) {}
      if (remoteJourney != null) {
        final local = await _storage.getFaithJourney(uid);
        final merged = local == null
            ? remoteJourney.copyWith(userId: uid, followerCount: 0)
            : mergeJourneys(local, remoteJourney);
        if (local == null || jsonEncode(merged.toJson()) != jsonEncode(local.toJson())) {
          await _storage.createFaithJourney(merged);
        }
        await _mirrorJourneyOnUser(uid, merged, user);
      }
    }

    // Saved verses, bookmarks, blocked people, settings.
    final userJson = user.toJson();
    final updates = <String, dynamic>{};
    for (final field in personalFields) {
      final value = remote[field];
      if (value == null) continue;
      final next = unionLists && value is List && userJson[field] is List
          ? {...(userJson[field] as List), ...value}.toList()
          : unionLists && value is Map && userJson[field] is Map
              ? {...(value), ...(userJson[field] as Map)}
              : value;
      if (jsonEncode(next) != jsonEncode(userJson[field])) updates[field] = next;
    }
    if (updates.isNotEmpty) await _storage.updateUser(uid, updates);

    final state = await _localState(uid);
    if (state != null) _lastSynced = jsonEncode(state);
  }

  /// Keeps the profile's streak numbers and reading role in step.
  Future<void> _mirrorJourneyOnUser(String uid, FaithJourney j, UserModel user) async {
    final updates = <String, dynamic>{
      if (user.consecutiveReadingDays != j.consecutiveDays) 'consecutiveReadingDays': j.consecutiveDays,
      if (user.totalReadingDays != j.totalDaysRead) 'totalReadingDays': j.totalDaysRead,
      if (j.lastReadingDate != null && user.lastReadingDate != j.lastReadingDate)
        'lastReadingDate': j.lastReadingDate,
      if (user.role != UserRole.bishop && j.currentRole.level > user.role.level) 'role': j.currentRole,
    };
    if (updates.isNotEmpty) await _storage.updateUser(uid, updates);
  }

  // ------------------------------------------------------------ merging

  static final DateTime _epoch = DateTime.fromMillisecondsSinceEpoch(0);

  static UserRole _higherReadingRole(UserRole a, UserRole b) {
    UserRole reading(UserRole r) => r == UserRole.bishop ? UserRole.shepherd : r;
    return reading(a).level >= reading(b).level ? reading(a) : reading(b);
  }

  /// Combines two copies of the same member's journey without losing
  /// progress from either: chapters and milestones are combined, lifetime
  /// totals take the larger value, and the current streak comes from the
  /// copy that was read most recently. Bishop status and follower count are
  /// kept from [local] (they come from the public profile).
  static FaithJourney mergeJourneys(FaithJourney local, FaithJourney remote) {
    final chapters = <String>[
      ...local.chaptersCompleted,
      ...remote.chaptersCompleted.where((c) => !local.chaptersCompleted.contains(c)),
    ];
    final bookProgress = <String, int>{};
    for (final c in chapters) {
      final book = c.substring(0, c.lastIndexOf(' ').clamp(0, c.length));
      bookProgress[book] = (bookProgress[book] ?? 0) + 1;
    }

    final localLast = local.lastReadingDate ?? _epoch;
    final remoteLast = remote.lastReadingDate ?? _epoch;
    final latest = remoteLast.isAfter(localLast) ? remote : local;

    final history = {
      for (final d in [...local.readingHistory, ...remote.readingHistory]) d.toIso8601String(): d,
    }.values.toList()
      ..sort();

    final milestoneTypes = local.milestones.map((m) => m.type).toSet();
    final milestones = [
      ...local.milestones,
      ...remote.milestones.where((m) => !milestoneTypes.contains(m.type)),
    ];

    DateTime? earliest(DateTime? a, DateTime? b) =>
        a == null ? b : b == null ? a : (a.isBefore(b) ? a : b);

    final role = local.currentRole == UserRole.bishop
        ? UserRole.bishop
        : _higherReadingRole(local.currentRole, remote.currentRole);

    return local.copyWith(
      currentRole: role,
      chaptersCompleted: chapters,
      chaptersRead: chapters.length,
      bookProgress: bookProgress,
      versesRead: local.versesRead > remote.versesRead ? local.versesRead : remote.versesRead,
      totalDaysRead: local.totalDaysRead > remote.totalDaysRead ? local.totalDaysRead : remote.totalDaysRead,
      consecutiveDays: latest.consecutiveDays,
      longestStreak: [local.longestStreak, remote.longestStreak, latest.consecutiveDays]
          .reduce((a, b) => a > b ? a : b),
      lastReadingDate: latest.lastReadingDate,
      streakStartDate: latest.streakStartDate,
      readingHistory: history.length > 400 ? history.sublist(history.length - 400) : history,
      milestones: milestones,
      achievements: {...local.achievements, ...remote.achievements}.toList(),
      startedAt: earliest(local.startedAt, remote.startedAt),
      hasReachedBeliever: local.hasReachedBeliever || remote.hasReachedBeliever,
      hasReachedPreacher: local.hasReachedPreacher || remote.hasReachedPreacher,
      hasReachedShepherd: local.hasReachedShepherd || remote.hasReachedShepherd,
      chosenTitle: local.chosenTitle ?? remote.chosenTitle,
    );
  }
}
