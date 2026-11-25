import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/theme.dart';
import '../../models/user_model.dart';
import '../../services/local_auth_service.dart';
import '../../services/bible_service.dart';
import '../../services/faith_journey_service.dart';
import '../../widgets/faith_progress_card.dart';
import '../../widgets/daily_verse_section.dart';
import '../../widgets/reading_streak_card.dart';
import '../../widgets/quick_action_buttons.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    // Load daily verse
    await ref.read(bibleServiceProvider).getDailyVerse();
    
    // Check faith journey
    final userId = ref.read(localAuthServiceProvider).currentUserId;
    if (userId != null) {
      final journey = await ref.read(faithJourneyServiceProvider).getFaithJourney(userId);
      if (journey == null) {
        await ref.read(faithJourneyServiceProvider).createFaithJourney(userId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(localCurrentUserProvider).value;
    final journeyStats = ref.watch(faithJourneyStatsProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Faith Mission'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // Open notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Open search
            },
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
              // Welcome section
              if (user != null)
                _buildWelcomeSection(context, user),
              
              const SizedBox(height: AppTheme.md),
              
              // Daily verse section
              const DailyVerseSection(),
              
              const SizedBox(height: AppTheme.lg),
              
              // Faith journey progress
              if (journeyStats != null)
                FaithProgressCard(stats: journeyStats),
              
              const SizedBox(height: AppTheme.lg),
              
              // Reading streak
              if (user != null)
                ReadingStreakCard(userId: user.id),
              
              const SizedBox(height: AppTheme.lg),
              
              // Quick actions
              const QuickActionButtons(),
              
              const SizedBox(height: AppTheme.lg),
              
              // Recent activity (for future implementation)
              _buildRecentActivitySection(context),
              
              const SizedBox(height: AppTheme.lg),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context, UserModel user) {
    final hour = DateTime.now().hour;
    String greeting;
    
    if (hour < 12) {
      greeting = 'Good Morning';
    } else if (hour < 17) {
      greeting = 'Good Afternoon';
    } else {
      greeting = 'Good Evening';
    }
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: AppTheme.mediumBorderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.lg),
        child: Row(
          children: [
            if (user.photoUrl != null)
              CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(user.photoUrl!),
              )
            else
              CircleAvatar(
                radius: 28,
                backgroundColor: AppTheme.primaryColor,
                child: Text(
                  user.displayName.isNotEmpty 
                      ? user.displayName[0].toUpperCase()
                      : 'U',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const SizedBox(width: AppTheme.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$greeting, ${user.displayName}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.role.displayName,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.primaryColor,
                        ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () => context.go('/settings'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivitySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Recent Activity',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: AppTheme.md),
        
        // Placeholder for recent activity
        Container(
          height: 150,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: AppTheme.mediumBorderRadius,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.history_outlined, size: 32, color: Colors.grey),
                const SizedBox(height: 8),
                Text(
                  'Your recent activity will appear here',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
