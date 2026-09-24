import 'package:flutter/material.dart';

import '../config/theme.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSearch;
  final VoidCallback? onClear;

  const CustomSearchBar({
    super.key,
    required this.hintText,
    this.onChanged,
    this.onSearch,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: onClear != null
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: onClear,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: AppTheme.mediumBorderRadius,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
      ),
      onChanged: onChanged,
      onSubmitted: (value) {
        if (onSearch != null) {
          onSearch();
        }
      },
    );
  }
}
