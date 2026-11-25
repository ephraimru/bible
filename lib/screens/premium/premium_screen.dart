import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/app_config.dart';
import '../../config/theme.dart';
import '../../models/user_model.dart';
import '../../services/local_auth_service.dart';
import '../../services/premium_service.dart';

/// Shows that every feature is free, and how to become a Bishop.
class PremiumScreen extends ConsumerWidget {
  const PremiumScreen({super.key});

  static const _freeFeatures = <(IconData, String)>[
    (Icons.menu_book, 'The complete King James Bible, offline'),
    (Icons.search, 'Search by word, phrase or reference'),
    (Icons.wb_sunny_outlined, 'A verse of the day'),
    (Icons.flag_outlined, 'Faith journey: streaks, roles and milestones'),
    (Icons.article_outlined, 'Read the blog and join the discussion'),
    (Icons.chat_bubble_outline, 'Gospel chat'),
    (Icons.notifications_none, 'Reading reminders'),
    (Icons.block, 'No ads'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(localCurrentUserProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Free & Bishop Access')),
      body: ListView(
        padding: const EdgeInsets.all(AppTheme.md),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.lg),
              child: Column(
                children: [
                  const Icon(Icons.volunteer_activism, size: 48, color: AppTheme.primaryColor),
                  const SizedBox(height: AppTheme.sm),
                  Text('Faith Mission is free', style: theme.textTheme.titleLarge),
                  const SizedBox(height: AppTheme.xs),
                  Text(
                    'Every feature is free for everyone.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppTheme.md),
          Text('Included for everyone', style: theme.textTheme.titleMedium),
          const SizedBox(height: AppTheme.sm),
          Card(
            child: Column(
              children: [
                for (final (icon, label) in _freeFeatures)
                  ListTile(
                    leading: Icon(icon, color: AppTheme.primaryColor),
                    title: Text(label),
                    trailing: const Icon(Icons.check_circle, color: Colors.green),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppTheme.md),
          Text('Bishop', style: theme.textTheme.titleMedium),
          const SizedBox(height: AppTheme.sm),
          if (user != null) _BishopCard(user: user),
        ],
      ),
    );
  }
}

class _BishopCard extends ConsumerWidget {
  const _BishopCard({required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    if (PremiumService.isBishop(user)) {
      return Card(
        color: Colors.green.shade50,
        child: const ListTile(
          leading: Icon(Icons.verified, color: Colors.green, size: 36),
          title: Text("You're a Bishop"),
          subtitle: Text('You can publish blog posts and use the Bishop and Apostle titles.'),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(Icons.lock_outline, color: Colors.deepPurple),
                const SizedBox(width: AppTheme.sm),
                Expanded(
                  child: Text('Skip to Bishop (locked)', style: theme.textTheme.titleMedium),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.sm),
            const Text(
              'Bishops can publish blog posts and use the Bishop and Apostle titles. '
              'You become a Bishop by reaching 1,000 followers.',
            ),
            if (PremiumService.canRedeemCodes) ...[
              const SizedBox(height: AppTheme.md),
              const Text(
                'To skip the ladder, contact the admin to arrange payment. '
                "You'll receive an unlock code for your account.",
              ),
              const SizedBox(height: AppTheme.sm),
              _EmailRow(user: user),
              const SizedBox(height: AppTheme.md),
              FilledButton.icon(
                onPressed: () => _showRedeemDialog(context, ref),
                icon: const Icon(Icons.vpn_key_outlined),
                label: const Text('Enter unlock code'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _showRedeemDialog(BuildContext context, WidgetRef ref) async {
    final message = await showDialog<String>(
      context: context,
      builder: (context) => _RedeemDialog(userId: user.id, email: user.email),
    );
    if (message != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
  }
}

class _EmailRow extends StatelessWidget {
  const _EmailRow({required this.user});

  final UserModel user;

  Future<void> _emailAdmin(BuildContext context) async {
    final uri = Uri(
      scheme: 'mailto',
      path: AppConfig.adminEmail,
      query: 'subject=${Uri.encodeComponent('Faith Mission: skip to Bishop')}'
          '&body=${Uri.encodeComponent('Hello, I would like to skip to Bishop.\n'
              'My Faith Mission account email is: ${user.email}\n')}',
    );
    var opened = false;
    try {
      opened = await launchUrl(uri);
    } catch (_) {}
    if (!opened && context.mounted) {
      await _copyEmail(context);
    }
  }

  Future<void> _copyEmail(BuildContext context) async {
    await Clipboard.setData(const ClipboardData(text: AppConfig.adminEmail));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Admin email copied')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.md),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: AppTheme.mediumBorderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SelectableText(
            AppConfig.adminEmail,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: AppTheme.xs),
          Text(
            'Tell the admin your account email: ${user.email}',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: AppTheme.sm),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: AppTheme.sm,
            children: [
              OutlinedButton.icon(
                onPressed: () => _emailAdmin(context),
                icon: const Icon(Icons.email_outlined),
                label: const Text('Email admin'),
              ),
              OutlinedButton.icon(
                onPressed: () => _copyEmail(context),
                icon: const Icon(Icons.copy),
                label: const Text('Copy email'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RedeemDialog extends ConsumerStatefulWidget {
  const _RedeemDialog({required this.userId, required this.email});

  final String userId;
  final String email;

  @override
  ConsumerState<_RedeemDialog> createState() => _RedeemDialogState();
}

class _RedeemDialogState extends ConsumerState<_RedeemDialog> {
  final _controller = TextEditingController();
  String? _error;
  bool _busy = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _redeem() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    final result = await ref
        .read(premiumServiceProvider)
        .redeemBishopCode(widget.userId, _controller.text);
    if (!mounted) return;
    switch (result) {
      case RedeemResult.unlocked:
        Navigator.of(context).pop('Welcome, Bishop! Blog posting and Bishop titles are unlocked.');
      case RedeemResult.alreadyBishop:
        Navigator.of(context).pop('You are already a Bishop.');
      case RedeemResult.invalidCode:
        setState(() {
          _busy = false;
          _error = 'This code is not valid for ${widget.email}. Check that you '
              'copied all of it, and that the admin made it for this email.';
        });
      case RedeemResult.notAvailable:
        Navigator.of(context).pop('Unlock codes are not available in this version.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter unlock code'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Paste the code the admin sent you for ${widget.email}.'),
          const SizedBox(height: AppTheme.md),
          TextField(
            controller: _controller,
            minLines: 2,
            maxLines: 4,
            autocorrect: false,
            enableSuggestions: false,
            decoration: InputDecoration(
              labelText: 'Unlock code',
              hintText: 'FMB1.…',
              errorText: _error,
              errorMaxLines: 3,
              border: const OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _busy ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _busy ? null : _redeem,
          child: _busy
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Unlock'),
        ),
      ],
    );
  }
}
