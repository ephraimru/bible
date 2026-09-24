import 'package:flutter/material.dart';

import '../config/theme.dart';
import '../models/user_model.dart';
import 'faith_progress_indicator.dart';

class RoleProgressCard extends StatelessWidget {
  final UserRole role;
  final bool isCompleted;
  final bool isCurrent;
  final VoidCallback? onTap;

  const RoleProgressCard({
    super.key,
    required this.role,
    required this.isCompleted,
    required this.isCurrent,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = _getRoleColor(role);
    final icon = _getRoleIcon(role);
    
    return Card(
      elevation: isCurrent ? 4 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: AppTheme.mediumBorderRadius,
        side: isCurrent 
            ? BorderSide(color: color, width: 2)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppTheme.mediumBorderRadius,
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.md),
          child: Row(
            children: [
              // Role icon
              Container(
                padding: const EdgeInsets.all(AppTheme.md),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color),
              ),
              
              const SizedBox(width: AppTheme.md),
              
              // Role info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      role.displayName,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    
                    const SizedBox(height: AppTheme.xs),
                    
                    Text(
                      role.requirements['description'] ?? '',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                  ],
                ),
              ),
              
              // Status indicator
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.md,
                  vertical: AppTheme.sm,
                ),
                decoration: BoxDecoration(
                  color: isCompleted 
                      ? Colors.green.withOpacity(0.1)
                      : Colors.grey.withOpacity(0.1),
                  borderRadius: AppTheme.mediumBorderRadius,
                ),
                child: Text(
                  isCompleted ? 'Completed' : 'Locked',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isCompleted ? Colors.green : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getRoleColor(UserRole role) {
    switch (role) {
      case UserRole.believer:
        return Colors.blue;
      case UserRole.preacher:
        return Colors.green;
      case UserRole.shepherd:
        return Colors.amber;
      case UserRole.bishop:
        return Colors.purple;
    }
  }

  IconData _getRoleIcon(UserRole role) {
    switch (role) {
      case UserRole.believer:
        return Icons.person;
      case UserRole.preacher:
        return Icons.mic;
      case UserRole.shepherd:
        return Icons.groups;
      case UserRole.bishop:
        return Icons.star;
    }
  }
}
