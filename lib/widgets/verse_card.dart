import 'package:flutter/material.dart';

import '../config/theme.dart';
import '../models/verse_model.dart';

class VerseCard extends StatelessWidget {
  final VerseModel verse;
  final bool showBook;
  final bool showActions;
  final VoidCallback? onTap;
  final VoidCallback? onLike;
  final VoidCallback? onSave;
  final VoidCallback? onShare;

  const VerseCard({
    super.key,
    required this.verse,
    this.showBook = true,
    this.showActions = true,
    this.onTap,
    this.onLike,
    this.onSave,
    this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: AppTheme.mediumBorderRadius,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppTheme.mediumBorderRadius,
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Reference
              if (showBook)
                Text(
                  verse.reference,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.primaryColor,
                      ),
                ),
              
              const SizedBox(height: AppTheme.sm),
              
              // Verse text
              Text(
                verse.text,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              
              const SizedBox(height: AppTheme.md),
              
              // Actions
              if (showActions)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (onLike != null)
                      IconButton(
                        icon: const Icon(Icons.favorite_outline, size: 18),
                        onPressed: onLike,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    if (onSave != null)
                      IconButton(
                        icon: const Icon(Icons.bookmark_outline, size: 18),
                        onPressed: onSave,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    if (onShare != null)
                      IconButton(
                        icon: const Icon(Icons.share_outlined, size: 18),
                        onPressed: onShare,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
