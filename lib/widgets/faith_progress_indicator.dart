import 'package:flutter/material.dart';

import '../config/theme.dart';

class FaithProgressIndicator extends StatelessWidget {
  final double progress;
  final String label;

  const FaithProgressIndicator({
    super.key,
    required this.progress,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Progress bar
        LinearProgressIndicator(
          value: progress.clamp(0.0, 1.0),
          backgroundColor: Colors.grey.shade200,
          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
          minHeight: 8,
        ),
        
        const SizedBox(height: AppTheme.sm),
        
        // Label
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
