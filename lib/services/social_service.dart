import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_service.dart';

final socialServiceProvider = Provider<SocialService>((ref) {
  return SocialService(ref.read(firestoreProvider));
});

/// A member's public profile, as other members see it.
class MemberProfile {
  const MemberProfile({
    required this.uid,
    required this.displayName,
    this.bio,
    this.chosenTitle,
    this.role = 'believer',
    this.followersCount = 0,
  });

  final String uid;
  final String displayName;
  final String? bio;
  final String? chosenTitle;
  final String role;
  final int followersCount;

  String get fullName => chosenTitle == null ? displayName : '$chosenTitle $displayName';

  factory MemberProfile.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final d = doc.data() ?? const {};
    return MemberProfile(
      uid: doc.id,
      displayName: (d['displayName'] as String?) ?? 'Member',
      bio: d['bio'] as String?,
      chosenTitle: d['chosenTitle'] as String?,
      role: (d['role'] as String?) ?? 'believer',
      followersCount: (d['followersCount'] as num?)?.toInt() ?? 0,
    );
  }
}

/// Following other members.
///
/// - `users/{uid}/followers/{followerUid}`: one document per follower.
///   Creating or deleting it must change `users/{uid}.followersCount` by
///   exactly one in the same write (enforced by firestore.rules), so the
///   count can't be inflated.
/// - `users/{uid}/following/{targetUid}`: the member's own list of who they
///   follow, for showing "Following" and the following count.
///
/// Members reach Bishop automatically at [bishopFollowers] followers.
class SocialService {
  SocialService(this._db);

  final FirebaseFirestore _db;

  static const int bishopFollowers = 1000;

  DocumentReference<Map<String, dynamic>> _user(String uid) => _db.collection('users').doc(uid);

  Stream<MemberProfile?> watchProfile(String uid) =>
      _user(uid).snapshots().map((d) => d.exists ? MemberProfile.fromDoc(d) : null);

  Stream<bool> watchIsFollowing({required String me, required String target}) =>
      _user(target).collection('followers').doc(me).snapshots().map((d) => d.exists);

  Stream<int> watchFollowingCount(String uid) =>
      _user(uid).collection('following').snapshots().map((s) => s.size);

  Future<void> follow({required String me, required String target}) async {
    if (me == target) return;
    final follower = _user(target).collection('followers').doc(me);
    if ((await follower.get()).exists) return; // already following
    final batch = _db.batch();
    batch.set(follower, {'followerId': me, 'createdAt': FieldValue.serverTimestamp()});
    batch.update(_user(target), {'followersCount': FieldValue.increment(1)});
    batch.set(_user(me).collection('following').doc(target), {
      'targetId': target,
      'createdAt': FieldValue.serverTimestamp(),
    });
    await batch.commit();
  }

  Future<void> unfollow({required String me, required String target}) async {
    final follower = _user(target).collection('followers').doc(me);
    final batch = _db.batch();
    if ((await follower.get()).exists) {
      batch.delete(follower);
      batch.update(_user(target), {'followersCount': FieldValue.increment(-1)});
    }
    batch.delete(_user(me).collection('following').doc(target));
    await batch.commit();
  }

  /// Unfollows everyone [me] follows (used when deleting an account).
  Future<void> unfollowAll(String me) async {
    final following = await _user(me).collection('following').get();
    for (final doc in following.docs) {
      try {
        await unfollow(me: me, target: doc.id);
      } catch (_) {
        await doc.reference.delete(); // the other member's profile is gone
      }
    }
  }
}
