import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/theme.dart';
import '../models/verse_model.dart';

class BookCard extends StatelessWidget {
  final BibleBook book;
  final VoidCallback? onTap;

  const BookCard({
    super.key,
    required this.book,
    this.onTap,
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
          padding: const EdgeInsets.all(AppTheme.md),
          child: Row(
            children: [
              // Book icon/abbreviation
              Container(
                padding: const EdgeInsets.all(AppTheme.sm),
                decoration: BoxDecoration(
                  color: _getBookColor(book.testament),
                  borderRadius: AppTheme.mediumBorderRadius,
                ),
                child: Text(
                  book.abbreviation,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              
              const SizedBox(width: AppTheme.md),
              
              // Book info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      '${book.chapters} chapters',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                  ],
                ),
              ),
              
              // Testament indicator
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.sm,
                  vertical: AppTheme.xs,
                ),
                decoration: BoxDecoration(
                  color: _getTestamentColor(book.testament),
                  borderRadius: AppTheme.mediumBorderRadius,
                ),
                child: Text(
                  book.testament == 1 ? 'OT' : 'NT',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
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

  Color _getBookColor(int testament) {
    return testament == 1 ? Colors.blue : Colors.green;
  }

  Color _getTestamentColor(int testament) {
    return testament == 1 ? Colors.blue : Colors.green;
  }
}
