import 'package:flutter/material.dart';

import '../config/theme.dart';
import '../models/faith_journey_model.dart';
import 'faith_progress_indicator.dart';

class FaithProgressCard extends StatelessWidget {
  final FaithJourneyStats stats;

  const FaithProgressCard({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
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
                  'Faith Journey Progress',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            
            const SizedBox(height: AppTheme.md),
            
            // Current role
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Current: ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Chip(
                  label: Text(stats.currentRoleDisplayName),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Next: ${stats.nextRoleName}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.sm),
                  FaithProgressIndicator(
                    progress: stats.progressToNextRole,
                    label: '${stats.daysToNextRole} days remaining',
                  ),
                ],
              ),
            
            const SizedBox(height: AppTheme.md),
            
            // Statistics
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMiniStat(context, 'Streak', '${stats.totalReadingStreak}'),
                _buildMiniStat(context, 'Verses', '${stats.totalVersesRead}'),
                _buildMiniStat(context, 'Followers', '${stats.totalFollowers}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniStat(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
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
}
