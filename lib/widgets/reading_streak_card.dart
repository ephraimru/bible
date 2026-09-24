import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/theme.dart';
import '../services/faith_journey_service.dart';

class ReadingStreakCard extends ConsumerWidget {
  final String userId;

  const ReadingStreakCard({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streakFuture = ref.read(faithJourneyServiceProvider).getReadingStreak(userId);
    
    return FutureBuilder<Map<String, dynamic>>(
      future: streakFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingView(context);
        }
        
        if (snapshot.hasError || !snapshot.hasData) {
          return _buildErrorView(context);
        }
        
        final streakData = snapshot.data!;
        final consecutiveDays = streakData['consecutiveDays'] as int? ?? 0;
        final longestStreak = streakData['longestStreak'] as int? ?? 0;
        final streakStart = streakData['streakStart'] as DateTime?;
        final lastReadingDate = streakData['lastReadingDate'] as DateTime?;
        
        return _buildStreakView(context, consecutiveDays, longestStreak, streakStart, lastReadingDate);
      },
    );
  }

  Widget _buildLoadingView(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: AppTheme.mediumBorderRadius,
      ),
      child: const Padding(
        padding: EdgeInsets.all(AppTheme.lg),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildErrorView(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: AppTheme.mediumBorderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.lg),
        child: Center(
          child: Text(
            'Unable to load streak data',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }

  Widget _buildStreakView(
    BuildContext context,
    int consecutiveDays,
    int longestStreak,
    DateTime? streakStart,
    DateTime? lastReadingDate,
  ) {
    // Determine streak color
    Color streakColor;
    String streakLabel;
    
    if (consecutiveDays >= 365) {
      streakColor = Colors.purple;
      streakLabel = 'Shepherd';
    } else if (consecutiveDays >= 30) {
      streakColor = Colors.green;
      streakLabel = 'Preacher';
    } else if (consecutiveDays >= 7) {
      streakColor = Colors.blue;
      streakLabel = 'Believer';
    } else {
      streakColor = Colors.grey;
      streakLabel = 'Beginner';
    }
    
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
                Icon(Icons.whatshot_outlined, color: streakColor),
                const SizedBox(width: AppTheme.sm),
                Text(
                  'Reading Streak',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            
            const SizedBox(height: AppTheme.md),
            
            // Current streak
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$consecutiveDays',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: streakColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(width: AppTheme.sm),
                Text(
                  'days',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            
            // Streak label
            if (consecutiveDays > 0)
              Padding(
                padding: const EdgeInsets.only(top: AppTheme.sm),
                child: Chip(
                  label: Text(streakLabel),
                  backgroundColor: streakColor.withOpacity(0.1),
                  labelStyle: TextStyle(
                    color: streakColor,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: AppTheme.mediumBorderRadius,
                  ),
                ),
              ),
            
            const SizedBox(height: AppTheme.md),
            
            // Longest streak
            Text(
              'Longest streak: $longestStreak days',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: AppTheme.md),
            
            // Streak progress
            LinearProgressIndicator(
              value: (consecutiveDays / 365).clamp(0.0, 1.0),
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(streakColor),
              minHeight: 6,
            ),
            
            const SizedBox(height: AppTheme.sm),
            
            // Progress labels
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Beginner',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                ),
                Text(
                  'Shepherd',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.purple,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
