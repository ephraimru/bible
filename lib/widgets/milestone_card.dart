import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../config/theme.dart';
import '../models/faith_journey_model.dart';

class MilestoneCard extends StatelessWidget {
  final FaithMilestone milestone;

  const MilestoneCard({super.key, required this.milestone});

  @override
  Widget build(BuildContext context) {
    final icon = _getMilestoneIcon(milestone.type);
    final color = _getMilestoneColor(milestone.type);
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: AppTheme.mediumBorderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.md),
        child: Row(
          children: [
            // Milestone icon
            Container(
              padding: const EdgeInsets.all(AppTheme.md),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color),
            ),
            
            const SizedBox(width: AppTheme.md),
            
            // Milestone info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    milestone.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  
                  const SizedBox(height: AppTheme.xs),
                  
                  Text(
                    milestone.description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: AppTheme.xs),
                  
                  // Date
                  if (milestone.achievedAt != null)
                    Text(
                      DateFormat('MMM dd, yyyy').format(milestone.achievedAt!),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                ],
              ),
            ),
            
            // Status badge
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.md,
                vertical: AppTheme.sm,
              ),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: AppTheme.mediumBorderRadius,
              ),
              child: const Icon(Icons.check, color: Colors.green, size: 16),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getMilestoneIcon(FaithMilestoneType type) {
    switch (type) {
      case FaithMilestoneType.firstReading:
        return Icons.menu_book;
      case FaithMilestoneType.sevenDayStreak:
        return Icons.calendar_today;
      case FaithMilestoneType.thirtyDayStreak:
        return Icons.calendar_month;
      case FaithMilestoneType.oneYearStreak:
        return Icons.event_available;
      case FaithMilestoneType.firstSavedVerse:
        return Icons.bookmark;
      case FaithMilestoneType.firstBlogPost:
        return Icons.article;
      case FaithMilestoneType.firstChatMessage:
        return Icons.chat;
      case FaithMilestoneType.rolePromotion:
        return Icons.arrow_upward;
      case FaithMilestoneType.followerMilestone:
        return Icons.people;
      case FaithMilestoneType.custom:
        return Icons.star;
    }
  }

  Color _getMilestoneColor(FaithMilestoneType type) {
    switch (type) {
      case FaithMilestoneType.firstReading:
        return Colors.blue;
      case FaithMilestoneType.sevenDayStreak:
        return Colors.blue;
      case FaithMilestoneType.thirtyDayStreak:
        return Colors.green;
      case FaithMilestoneType.oneYearStreak:
        return Colors.amber;
      case FaithMilestoneType.firstSavedVerse:
        return Colors.purple;
      case FaithMilestoneType.firstBlogPost:
        return Colors.teal;
      case FaithMilestoneType.firstChatMessage:
        return Colors.orange;
      case FaithMilestoneType.rolePromotion:
        return Colors.red;
      case FaithMilestoneType.followerMilestone:
        return Colors.pink;
      case FaithMilestoneType.custom:
        return Colors.indigo;
    }
  }
}
