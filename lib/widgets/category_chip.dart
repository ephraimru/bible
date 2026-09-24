import 'package:flutter/material.dart';

import '../config/theme.dart';
import '../models/blog_model.dart';

class CategoryChip extends StatelessWidget {
  final BlogCategory category;
  final bool isSelected;
  final VoidCallback? onSelected;

  const CategoryChip({
    super.key,
    required this.category,
    this.isSelected = false,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final color = _getCategoryColor(category);
    
    return FilterChip(
      label: Text(category.displayName),
      selected: isSelected,
      onSelected: (selected) {
        if (onSelected != null) {
          onSelected();
        }
      },
      backgroundColor: Colors.white,
      selectedColor: color.withOpacity(0.1),
      labelStyle: TextStyle(
        color: isSelected ? color : Colors.black,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: AppTheme.mediumBorderRadius,
      ),
    );
  }

  Color _getCategoryColor(BlogCategory category) {
    switch (category) {
      case BlogCategory.devotionals:
        return Colors.purple;
      case BlogCategory.sermons:
        return Colors.blue;
      case BlogCategory.testimonies:
        return Colors.green;
      case BlogCategory.bibleStudy:
        return Colors.amber;
      case BlogCategory.faithJourney:
        return Colors.teal;
      case BlogCategory.gospelReflections:
        return Colors.orange;
    }
  }
}

// Category extension for display names
extension on BlogCategory {
  String get displayName {
    switch (this) {
      case BlogCategory.devotionals:
        return 'Devotionals';
      case BlogCategory.sermons:
        return 'Sermons';
      case BlogCategory.testimonies:
        return 'Testimonies';
      case BlogCategory.bibleStudy:
        return 'Bible Study';
      case BlogCategory.faithJourney:
        return 'Faith Journey';
      case BlogCategory.gospelReflections:
        return 'Gospel Reflections';
    }
  }
}
