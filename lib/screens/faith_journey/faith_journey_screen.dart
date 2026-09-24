import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/theme.dart';
import '../../models/user_model.dart';
import '../../models/faith_journey_model.dart';
import '../../services/auth_service.dart';
import '../../services/faith_journey_service.dart';
import '../widgets/faith_progress_card.dart';
import '../widgets/milestone_card.dart';
import '../widgets/role_progress_card.dart';

class FaithJourneyScreen extends ConsumerStatefulWidget {
  const FaithJourneyScreen({super.key});

  @override
  ConsumerState<FaithJourneyScreen> createState() => _FaithJourneyScreenState();
}

class _FaithJourneyScreenState extends ConsumerState<FaithJourneyScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider).value;
    final journey = ref.watch(faithJourneyStreamProvider).value;
    final journeyStats = ref.watch(faithJourneyStatsProvider);
    
    if (user == null || journey == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Faith Journey'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.flag_outlined,
                size: 64,
                color: Colors.grey,
              ),
              const SizedBox(height: AppTheme.md),
              Text(
                'Loading Faith Journey...',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
      );
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Faith Journey'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Current role section
            _buildCurrentRoleSection(context, user, journey),
            
            const SizedBox(height: AppTheme.lg),
            
            // Overall progress
            if (journeyStats != null)
              FaithProgressCard(stats: journeyStats),
            
            const SizedBox(height: AppTheme.lg),
            
            // Role progression
            _buildRoleProgressionSection(context, journey),
            
            const SizedBox(height: AppTheme.lg),
            
            // Reading statistics
            _buildReadingStatsSection(context, journey),
            
            const SizedBox(height: AppTheme.lg),
            
            // Milestones
            _buildMilestonesSection(context, journey),
            
            const SizedBox(height: AppTheme.lg),
            
            // Tips
            _buildTipsSection(context),
            
            const SizedBox(height: AppTheme.lg),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentRoleSection(
    BuildContext context,
    UserModel user,
    FaithJourney journey,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: AppTheme.largeBorderRadius,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: AppTheme.largeBorderRadius,
          gradient: _getRoleGradient(user.role),
        ),
        padding: const EdgeInsets.all(AppTheme.xxl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Your Current Role',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppTheme.md),
            Text(
              user.role.displayName,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppTheme.md),
            if (user.chosenTitle != null)
              Text(
                '"${user.chosenTitle}"',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: AppTheme.md),
            Text(
              user.role.requirements['description'] ?? '',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withOpacity(0.8),
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  LinearGradient _getRoleGradient(UserRole role) {
    switch (role) {
      case UserRole.believer:
        return const LinearGradient(
          colors: [Colors.blue, Colors.lightBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case UserRole.preacher:
        return const LinearGradient(
          colors: [Colors.green, Colors.lightGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case UserRole.shepherd:
        return const LinearGradient(
          colors: [Colors.amber, Colors.orange],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case UserRole.bishop:
        return const LinearGradient(
          colors: [Colors.purple, Colors.deepPurple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }

  Widget _buildRoleProgressionSection(BuildContext context, FaithJourney journey) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Your Faith Journey',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: AppTheme.md),
        
        // Role cards
        ...UserRole.values.map((role) {
          final isCompleted = journey.hasReachedRole(role);
          final isCurrent = journey.currentRole == role;
          
          return Padding(
            padding: const EdgeInsets.only(bottom: AppTheme.md),
            child: RoleProgressCard(
              role: role,
              isCompleted: isCompleted,
              isCurrent: isCurrent,
              onTap: () {
                // Show role details
              },
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildReadingStatsSection(BuildContext context, FaithJourney journey) {
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
                const Icon(Icons.analytics_outlined, color: AppTheme.primaryColor),
                const SizedBox(width: AppTheme.sm),
                Text(
                  'Reading Statistics',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            
            const SizedBox(height: AppTheme.md),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem(context, 'Total Days', '${journey.totalDaysRead}'),
                _buildStatItem(context, 'Current Streak', '${journey.consecutiveDays}'),
                _buildStatItem(context, 'Longest Streak', '${journey.longestStreak}'),
              ],
            ),
            
            const SizedBox(height: AppTheme.md),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem(context, 'Verses Read', '${journey.versesRead}'),
                _buildStatItem(context, 'Chapters Read', '${journey.chaptersRead}'),
                _buildStatItem(context, 'Books Read', '${journey.bookProgress.length}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppTheme.primaryColor,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
        ),
      ],
    );
  }

  Widget _buildMilestonesSection(BuildContext context, FaithJourney journey) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Your Milestones',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: AppTheme.md),
        
        if (journey.milestones.isEmpty)
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: AppTheme.mediumBorderRadius,
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.lg),
              child: Column(
                children: [
                  const Icon(
                    Icons.emoji_events_outlined,
                    size: 48,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: AppTheme.md),
                  Text(
                    'No milestones yet',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppTheme.sm),
                  Text(
                    'Keep reading to unlock milestones!',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
            ),
          )
        else
          ...journey.milestones
              .where((m) => m.isAchieved)
              .map((milestone) => Padding(
                    padding: const EdgeInsets.only(bottom: AppTheme.md),
                    child: MilestoneCard(milestone: milestone),
                  ))
              .toList(),
      ],
    );
  }

  Widget _buildTipsSection(BuildContext context) {
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
                const Icon(Icons.lightbulb_outline, color: Colors.amber),
                const SizedBox(width: AppTheme.sm),
                Text(
                  'Tips for Your Journey',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            
            const SizedBox(height: AppTheme.md),
            
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _tips.length,
              separatorBuilder: (context, index) => const SizedBox(height: AppTheme.sm),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(_tips[index].icon, color: Colors.amber),
                  title: Text(_tips[index].title),
                  subtitle: Text(_tips[index].description),
                  contentPadding: const EdgeInsets.symmetric(vertical: AppTheme.sm),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Tips for faith journey
  final _tips = [
    TipItem(
      icon: Icons.calendar_today,
      title: 'Read Daily',
      description: 'Consistency is key. Read the Bible every day to maintain your streak.',
    ),
    TipItem(
      icon: Icons.menu_book,
      title: 'Explore Different Books',
      description: 'Don\'t limit yourself to one book. Explore the entire Bible.',
    ),
    TipItem(
      icon: Icons.note,
      title: 'Take Notes',
      description: 'Write down your thoughts and reflections to deepen your understanding.',
    ),
    TipItem(
      icon: Icons.share,
      title: 'Share with Others',
      description: 'Discuss what you\'ve read with others in the community.',
    ),
    TipItem(
      icon: Icons.favorite,
      title: 'Save Favorite Verses',
      description: 'Bookmark verses that speak to your heart for quick access.',
    ),
  ];
}

class TipItem {
  final IconData icon;
  final String title;
  final String description;

  TipItem({
    required this.icon,
    required this.title,
    required this.description,
  });
}

// FaithJourney extension for role checking
extension on FaithJourney {
  bool hasReachedRole(UserRole role) {
    switch (role) {
      case UserRole.believer:
        return hasReachedBeliever;
      case UserRole.preacher:
        return hasReachedPreacher;
      case UserRole.shepherd:
        return hasReachedShepherd;
      case UserRole.bishop:
        return hasReachedBishop;
    }
  }
}
