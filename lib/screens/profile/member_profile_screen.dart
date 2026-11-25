import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/router.dart';
import '../../config/theme.dart';
import '../../models/blog_model.dart';
import '../../models/user_model.dart';
import '../../services/auth_service.dart';
import '../../services/community_service.dart';
import '../../services/social_service.dart';
import '../../widgets/blog_post_card.dart';

/// A member's public profile: name, role, bio, followers and their posts,
/// with a Follow button.
class MemberProfileScreen extends ConsumerStatefulWidget {
  const MemberProfileScreen({super.key, required this.uid});

  final String uid;

  @override
  ConsumerState<MemberProfileScreen> createState() => _MemberProfileScreenState();
}

class _MemberProfileScreenState extends ConsumerState<MemberProfileScreen> {
  bool _busy = false;

  late final _social = ref.read(socialServiceProvider);
  late final Stream<MemberProfile?> _profile = _social.watchProfile(widget.uid);
  late final Stream<int> _followingCount = _social.watchFollowingCount(widget.uid);
  late final Stream<List<BlogPostModel>> _posts =
      ref.read(communityServiceProvider).watchPostsBy(widget.uid, limit: 20);
  Stream<bool>? _isFollowing;

  String? get _me => ref.read(authServiceProvider).currentUserId;

  @override
  void initState() {
    super.initState();
    final me = _me;
    if (me != null && me != widget.uid) {
      _isFollowing = _social.watchIsFollowing(me: me, target: widget.uid);
    }
  }

  Future<void> _toggleFollow(bool following) async {
    final me = _me;
    if (me == null || _busy) return;
    setState(() => _busy = true);
    try {
      if (following) {
        await _social.unfollow(me: me, target: widget.uid);
      } else {
        await _social.follow(me: me, target: widget.uid);
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not update. Check your connection.')),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Member')),
      body: StreamBuilder<MemberProfile?>(
        stream: _profile,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final profile = snap.data;
          if (profile == null) {
            return const Center(child: Text('This member could not be found.'));
          }
          final role = UserRole.values.asNameMap()[profile.role] ?? UserRole.believer;
          final isMe = widget.uid == _me;
          return ListView(
            padding: const EdgeInsets.all(AppTheme.md),
            children: [
              const SizedBox(height: AppTheme.md),
              Center(
                child: CircleAvatar(
                  radius: 44,
                  backgroundColor: AppTheme.primaryColor,
                  child: Text(
                    profile.displayName.isEmpty ? '?' : profile.displayName[0].toUpperCase(),
                    style: const TextStyle(fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: AppTheme.md),
              Text(profile.fullName, textAlign: TextAlign.center, style: theme.textTheme.headlineSmall),
              const SizedBox(height: AppTheme.sm),
              Center(
                child: Chip(
                  avatar: Icon(
                    role == UserRole.bishop ? Icons.verified : Icons.auto_graph,
                    size: 18,
                    color: AppTheme.primaryColor,
                  ),
                  label: Text(role.displayName),
                ),
              ),
              if (profile.bio != null && profile.bio!.isNotEmpty) ...[
                const SizedBox(height: AppTheme.sm),
                Text(profile.bio!, textAlign: TextAlign.center, style: theme.textTheme.bodyMedium),
              ],
              const SizedBox(height: AppTheme.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _Count(label: 'Followers', value: profile.followersCount),
                  const SizedBox(width: AppTheme.xl),
                  StreamBuilder<int>(
                    stream: _followingCount,
                    builder: (context, s) => _Count(label: 'Following', value: s.data ?? 0),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.md),
              if (!isMe && _isFollowing != null)
                StreamBuilder<bool>(
                  stream: _isFollowing,
                  builder: (context, s) {
                    final following = s.data ?? false;
                    return Center(
                      child: following
                          ? OutlinedButton.icon(
                              onPressed: _busy ? null : () => _toggleFollow(true),
                              icon: const Icon(Icons.check),
                              label: const Text('Following'),
                            )
                          : FilledButton.icon(
                              onPressed: _busy ? null : () => _toggleFollow(false),
                              icon: const Icon(Icons.person_add_alt_1),
                              label: const Text('Follow'),
                            ),
                    );
                  },
                ),
              if (isMe && role != UserRole.bishop)
                Text(
                  '${profile.followersCount} of ${SocialService.bishopFollowers} followers '
                  'needed to become a Bishop.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey.shade700),
                ),
              const SizedBox(height: AppTheme.lg),
              Text('Posts', style: theme.textTheme.titleMedium),
              const SizedBox(height: AppTheme.sm),
              StreamBuilder<List<BlogPostModel>>(
                stream: _posts,
                builder: (context, s) {
                  final posts = s.data ?? const <BlogPostModel>[];
                  if (posts.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppTheme.md),
                      child: Text(
                        'No posts yet.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
                      ),
                    );
                  }
                  return Column(
                    children: [
                      for (final post in posts)
                        Padding(
                          padding: const EdgeInsets.only(bottom: AppTheme.sm),
                          child: BlogPostCard(post: post, onTap: () => context.pushPostDetail(post.id)),
                        ),
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Count extends StatelessWidget {
  const _Count({required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$value', style: Theme.of(context).textTheme.titleLarge),
        Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)),
      ],
    );
  }
}

/// Opens a member's profile.
extension MemberNavigation on BuildContext {
  void pushMemberProfile(String uid) => go('/member/$uid');
}
