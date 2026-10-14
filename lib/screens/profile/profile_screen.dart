import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../config/theme.dart';
import '../../models/user_model.dart';
import '../../models/faith_journey_model.dart';
import '../../services/auth_service.dart';
import '../../services/database_service.dart';
import '../../services/faith_journey_service.dart';
import '../widgets/profile_header.dart';
import '../widgets/stats_card.dart';
import '../widgets/faith_progress_indicator.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    // Data will be loaded via providers
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(localCurrentUserProvider).value;
    final journeyStats = ref.watch(faithJourneyStatsProvider);
    
    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.person_outline,
                size: 64,
                color: Colors.grey,
              ),
              const SizedBox(height: AppTheme.md),
              Text(
                'Please log in',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppTheme.sm),
              ElevatedButton(
                onPressed: () => context.go('/login'),
                child: const Text('Log In'),
              ),
            ],
          ),
        ),
      );
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.go('/settings'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Profile header
              ProfileHeader(user: user),
              
              const SizedBox(height: AppTheme.lg),
              
              // Faith journey progress
              if (journeyStats != null)
                _buildFaithJourneySection(context, user, journeyStats),
              
              const SizedBox(height: AppTheme.lg),
              
              // Statistics
              _buildStatisticsSection(context, user),
              
              const SizedBox(height: AppTheme.lg),
              
              // Recent activity
              _buildRecentActivitySection(context),
              
              const SizedBox(height: AppTheme.lg),
              
              // Premium section
              _buildPremiumSection(context, user),
              
              const SizedBox(height: AppTheme.lg),
              
              // Logout button
              ElevatedButton.icon(
                onPressed: () async {
                  await ref.read(localAuthServiceProvider).signOut();
                  if (mounted) {
                    context.go('/welcome');
                  }
                },
                icon: const Icon(Icons.logout),
                label: const Text('Log Out'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: AppTheme.md),
                  shape: RoundedRectangleBorder(
                    borderRadius: AppTheme.mediumBorderRadius,
                  ),
                ),
              ),
              
              const SizedBox(height: AppTheme.lg),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFaithJourneySection(
    BuildContext context,
    UserModel user,
    FaithJourneyStats stats,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: AppTheme.mediumBorderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(Icons.flag_outlined, color: AppTheme.primaryColor),
                const SizedBox(width: AppTheme.sm),
                Text(
                  'Faith Journey',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            
            const SizedBox(height: AppTheme.md),
            
            // Current role
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Current Role: ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Chip(
                  label: Text(user.role.displayName),
                  backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                  labelStyle: TextStyle(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: AppTheme.mediumBorderRadius,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: AppTheme.md),
            
            // Progress to next role
            if (stats.hasNextRole)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Next: ${stats.nextRoleName}',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppTheme.sm),
                  FaithProgressIndicator(
                    progress: stats.progressToNextRole,
                    label: '${stats.daysToNextRole} days remaining',
                  ),
                ],
              ),
            
            const SizedBox(height: AppTheme.md),
            
            // Bishop eligibility
            if (user.role == UserRole.shepherd && stats.canBecomeBishop)
              Card(
                elevation: 0,
                color: Colors.amber.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: AppTheme.mediumBorderRadius,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        '🎉 Bishop Eligibility!',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Colors.amber.shade800,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppTheme.sm),
                      Text(
                        'You have 1000+ followers and are eligible to become a Bishop!',
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppTheme.sm),
                      ElevatedButton(
                        onPressed: () {
                          // Promote to bishop
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                            vertical: AppTheme.sm,
                            horizontal: AppTheme.md,
                          ),
                        ),
                        child: const Text('Become Bishop'),
                      ),
                    ],
                  ),
                ),
              ),
            
            // Title selection for bishop
            if (user.role == UserRole.bishop)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppTheme.md),
                  Text(
                    'Your Title',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: AppTheme.sm),
                  Chip(
                    label: Text(user.chosenTitle ?? user.role.displayName),
                    backgroundColor: AppTheme.secondaryColor.withOpacity(0.1),
                    labelStyle: TextStyle(
                      color: AppTheme.secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: AppTheme.mediumBorderRadius,
                    ),
                  ),
                  const SizedBox(height: AppTheme.sm),
                  TextButton(
                    onPressed: () {
                      // Open title selection
                    },
                    child: const Text('Change Title'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsSection(BuildContext context, UserModel user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Your Statistics',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: AppTheme.md),
        
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          childAspectRatio: 1.1,
          children: [
            StatsCard(
              icon: Icons.menu_book_outlined,
              value: '${user.readingStats.totalVersesRead ?? 0}',
              label: 'Verses Read',
              color: Colors.blue,
            ),
            StatsCard(
              icon: Icons.calendar_today_outlined,
              value: '${user.consecutiveReadingDays}',
              label: 'Day Streak',
              color: Colors.green,
            ),
            StatsCard(
              icon: Icons.favorite_outline,
              value: '${user.likedVersesCount}',
              label: 'Liked',
              color: Colors.red,
            ),
            StatsCard(
              icon: Icons.bookmark_outline,
              value: '${user.savedVersesCount}',
              label: 'Saved',
              color: Colors.amber,
            ),
            StatsCard(
              icon: Icons.article_outlined,
              value: '${user.blogPostsCount}',
              label: 'Blog Posts',
              color: Colors.purple,
            ),
            StatsCard(
              icon: Icons.people_outline,
              value: '${user.followersCount}',
              label: 'Followers',
              color: Colors.teal,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentActivitySection(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: AppTheme.mediumBorderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(Icons.history_outlined, color: AppTheme.primaryColor),
                const SizedBox(width: AppTheme.sm),
                Text(
                  'Recent Activity',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            
            const SizedBox(height: AppTheme.md),
            
            // Placeholder for recent activity
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: AppTheme.mediumBorderRadius,
              ),
              child: Center(
                child: Text(
                  'Your recent activity will appear here',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumSection(BuildContext context, UserModel user) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: AppTheme.mediumBorderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(Icons.star_outline, color: Colors.amber),
                const SizedBox(width: AppTheme.sm),
                Text(
                  'Premium Features',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            
            const SizedBox(height: AppTheme.md),
            
            Text(
              'Current Tier: ${user.premiumTier.displayName}',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: AppTheme.md),
            
            // Premium features grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              children: [
                _buildPremiumFeatureItem(context, 'Advanced Search', Icons.search),
                _buildPremiumFeatureItem(context, 'Offline Mode', Icons.download),
                _buildPremiumFeatureItem(context, 'Commentaries', Icons.comment),
                _buildPremiumFeatureItem(context, 'Reading Plans', Icons.calendar_month),
              ],
            ),
            
            const SizedBox(height: AppTheme.md),
            
            ElevatedButton(
              onPressed: () => context.go('/premium'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: AppTheme.md),
                shape: RoundedRectangleBorder(
                  borderRadius: AppTheme.mediumBorderRadius,
                ),
              ),
              child: const Text('View Premium Plans'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumFeatureItem(BuildContext context, String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.amber),
      title: Text(title),
      trailing: const Icon(Icons.lock_outline, size: 16),
    );
  }
}

// Premium tier extension for display names
extension on PremiumTier {
  String get displayName {
    switch (this) {
      case PremiumTier.free:
        return 'Free';
      case PremiumTier.basic:
        return 'Basic';
      case PremiumTier.pro:
        return 'Pro';
      case PremiumTier.bishop:
        return 'Bishop';
    }
  }
}
