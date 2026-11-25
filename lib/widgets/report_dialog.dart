import 'package:flutter/material.dart';

/// Asks why content is being reported. Returns the reason, or null if the
/// user cancelled.
Future<String?> showReportDialog(BuildContext context) {
  const reasons = [
    'Offensive or hateful',
    'Harassment or bullying',
    'Spam or advertising',
    'Not about the Gospel',
    'Something else',
  ];
  return showDialog<String>(
    context: context,
    builder: (context) => SimpleDialog(
      title: const Text('Why are you reporting this?'),
      children: [
        for (final reason in reasons)
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, reason),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Text(reason),
            ),
          ),
        SimpleDialogOption(
          onPressed: () => Navigator.pop(context),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: Text('Cancel', style: TextStyle(fontWeight: FontWeight.w600)),
          ),
        ),
      ],
    ),
  );
}
