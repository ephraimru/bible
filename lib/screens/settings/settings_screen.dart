import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/theme.dart';
import '../../models/user_model.dart';
import '../../services/auth_service.dart';
import '../../services/database_service.dart';
import '../../services/faith_journey_service.dart';
import '../../services/notification_service.dart';
import '../../services/premium_service.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider).value;
    final premiumService = ref.watch(premiumServiceProvider);
    final notificationService = ref.watch(notificationServiceProvider);
    
    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.settings_outlined, size: 64, color: Colors.grey),
              const SizedBox(height: AppTheme.md),
              Text('Please log in to access settings', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppTheme.sm),
              ElevatedButton(
                onPressed: () => context.go('/login'),
                child: const Text('Log In'),
              ),
            ],
          ),
        ),
      );
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: _showHelpDialog,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Account Section
            _buildSectionHeader('Account', Icons.person_outline),
            const SizedBox(height: AppTheme.sm),
            
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.md),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person, color: Colors.blue),
                      title: const Text('Profile'),
                      subtitle: const Text('View and edit your profile'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () => context.go('/profile'),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.email_outlined, color: Colors.green),
                      title: const Text('Email'),
                      subtitle: Text(user.email),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.verified_user_outlined, color: Colors.purple),
                      title: const Text('Role'),
                      subtitle: Text(user.role.displayName),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppTheme.md),
            
            // Faith Journey Section
            _buildSectionHeader('Faith Journey', Icons.auto_graph),
            const SizedBox(height: AppTheme.sm),
            
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.md),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.flag, color: Colors.orange),
                      title: const Text('Faith Journey Progress'),
                      subtitle: const Text('Track your spiritual growth'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () => context.go('/home/faith-journey'),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.history, color: Colors.teal),
                      title: const Text('Reading History'),
                      subtitle: Text('${user.totalReadingDays} days of reading'),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.star, color: Colors.amber),
                      title: const Text('Saved Verses'),
                      subtitle: Text('${user.savedVersesCount} verses saved'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppTheme.md),
            
            // Notifications Section
            _buildSectionHeader('Notifications', Icons.notifications_outlined),
            const SizedBox(height: AppTheme.sm),
            
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.md),
                child: Column(
                  children: [
                    SwitchListTile(
                      secondary: const Icon(Icons.notifications_active, color: Colors.red),
                      title: const Text('Daily Reading Reminders'),
                      subtitle: const Text('Get reminded to read your Bible daily'),
                      value: user.preferences['dailyReminders'] ?? true,
                      onChanged: (value) => _updatePreference(user.id, 'dailyReminders', value),
                    ),
                    const Divider(),
                    SwitchListTile(
                      secondary: const Icon(Icons.volume_up, color: Colors.blue),
                      title: const Text('Sound'),
                      subtitle: const Text('Enable notification sounds'),
                      value: user.preferences['notificationSound'] ?? true,
                      onChanged: (value) => _updatePreference(user.id, 'notificationSound', value),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.schedule, color: Colors.green),
                      title: const Text('Reminder Time'),
                      subtitle: Text(user.preferences['reminderTime'] ?? '09:00'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: _showTimePicker,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppTheme.md),
            
            // Premium Section
            _buildSectionHeader('Premium', Icons.star_outline),
            const SizedBox(height: AppTheme.sm),
            
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.md),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.diamond, color: Colors.amber),
                      title: const Text('Premium Features'),
                      subtitle: Text(user.premiumTier.displayName),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () => context.go('/premium'),
                    ),
                    if (user.premiumTier == PremiumTier.bishop) ...[
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.person_pin, color: Colors.purple),
                        title: const Text('Custom Title'),
                        subtitle: Text(user.chosenTitle ?? 'Choose your title'),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: _showTitleSelection,
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppTheme.md),
            
            // Chat Section
            _buildSectionHeader('Chat', Icons.chat_outlined),
            const SizedBox(height: AppTheme.sm),
            
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.md),
                child: Column(
                  children: [
                    SwitchListTile(
                      secondary: const Icon(Icons.messenger, color: Colors.blue),
                      title: const Text('Chat Notifications'),
                      subtitle: const Text('Get notified of new messages'),
                      value: user.preferences['chatNotifications'] ?? true,
                      onChanged: (value) => _updatePreference(user.id, 'chatNotifications', value),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.block, color: Colors.red),
                      title: const Text('Blocked Users'),
                      subtitle: Text('${user.blockedUserIds.length} users blocked'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: _showBlockedUsers,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppTheme.md),
            
            // About Section
            _buildSectionHeader('About', Icons.info_outline),
            const SizedBox(height: AppTheme.sm),
            
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.md),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.info, color: Colors.blue),
                      title: const Text('About Faith Mission'),
                      subtitle: const Text('Learn more about the app'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: _showAboutDialog,
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.security, color: Colors.green),
                      title: const Text('Privacy Policy'),
                      subtitle: const Text('Our privacy practices'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: _showPrivacyPolicy,
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.description, color: Colors.orange),
                      title: const Text('Terms of Service'),
                      subtitle: const Text('App terms and conditions'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: _showTermsOfService,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppTheme.md),
            
            // Logout
            Card(
              color: Colors.red.shade50,
              child: ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Log Out'),
                subtitle: const Text('Sign out of your account'),
                textColor: Colors.red,
                iconColor: Colors.red,
                onTap: _confirmLogout,
              ),
            ),
            const SizedBox(height: AppTheme.md),
            
            // Delete Account
            Card(
              color: Colors.red.shade50,
              child: ListTile(
                leading: const Icon(Icons.delete_forever, color: Colors.red),
                title: const Text('Delete Account'),
                subtitle: const Text('Permanently delete your account'),
                textColor: Colors.red,
                iconColor: Colors.red,
                onTap: _confirmDeleteAccount,
              ),
            ),
            const SizedBox(height: AppTheme.md),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.blue.shade800),
        const SizedBox(width: AppTheme.sm),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Future<void> _updatePreference(String userId, String key, bool value) async {
    final db = ref.read(databaseServiceProvider);
    await db.updateUser(userId, {
      'preferences.$key': value,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> _showTimePicker() async {
    final user = ref.read(currentUserProvider).value;
    if (user == null) return;
    
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: int.tryParse(user.preferences['reminderTime']?.split(':')[0] ?? '9') ?? 9,
        minute: int.tryParse(user.preferences['reminderTime']?.split(':')[1] ?? '00') ?? 0,
      ),
    );
    
    if (time != null) {
      final timeString = '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
      await ref.read(databaseServiceProvider).updateUser(user.id, {
        'preferences.reminderTime': timeString,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<void> _showTitleSelection() async {
    final user = ref.read(currentUserProvider).value;
    if (user == null || user.role != UserRole.bishop) return;
    
    final titles = AvailableTitle.values.map((t) => t.displayName).toList();
    
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Your Title'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: titles.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(titles[index]),
              selected: user.chosenTitle == titles[index],
              selectedTileColor: Colors.blue.shade50,
              onTap: () async {
                await ref.read(databaseServiceProvider).updateUser(user.id, {
                  'chosenTitle': titles[index],
                  'updatedAt': FieldValue.serverTimestamp(),
                });
                if (mounted) Navigator.of(context).pop();
              },
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Future<void> _showBlockedUsers() async {
    final user = ref.read(currentUserProvider).value;
    if (user == null) return;
    
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Blocked Users'),
        content: user.blockedUserIds.isEmpty
            ? const Text('You have not blocked any users.')
            : SizedBox(
                width: double.maxFinite,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: user.blockedUserIds.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(user.blockedUserIds[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.unblock, color: Colors.green),
                      onPressed: () async {
                        final newList = List<String>.from(user.blockedUserIds)..removeAt(index);
                        await ref.read(databaseServiceProvider).updateUser(user.id, {
                          'blockedUserIds': newList,
                          'updatedAt': FieldValue.serverTimestamp(),
                        });
                        if (mounted) Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmLogout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
    
    if (confirmed == true) {
      await ref.read(authServiceProvider).signOut();
      if (mounted) context.go('/welcome');
    }
  }

  Future<void> _confirmDeleteAccount() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text('This will permanently delete your account and all your data. This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    
    if (confirmed == true) {
      final user = ref.read(currentUserProvider).value;
      if (user != null) {
        await ref.read(authServiceProvider).deleteAccount(user.id);
        if (mounted) context.go('/welcome');
      }
    }
  }

  Future<void> _showHelpDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Help & Support'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Faith Mission App Support'),
            SizedBox(height: AppTheme.sm),
            Text('Email: support@faithmission.app'),
            SizedBox(height: AppTheme.sm),
            Text('Phone: +1 (555) 123-4567'),
            SizedBox(height: AppTheme.sm),
            Text('Website: https://faithmission.app'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _showAboutDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About Faith Mission'),
        content: const SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Faith Mission is a comprehensive mobile application designed to help believers grow in their faith journey.'),
              SizedBox(height: AppTheme.sm),
              Text('Features:'),
              SizedBox(height: AppTheme.xs),
              Text('- Daily Bible verses with beautiful backgrounds'),
              Text('- Complete King James Version Bible'),
              Text('- Blog platform for faith-based articles'),
              Text('- Gospel-focused chat rooms'),
              Text('- Faith journey tracking and role progression'),
              Text('- Premium features for enhanced experience'),
              SizedBox(height: AppTheme.sm),
              Text('Version: 1.0.0'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _showPrivacyPolicy() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Privacy Policy'),
        content: const SingleChildScrollView(
          child: Text('''
Privacy Policy for Faith Mission App

1. Information We Collect
   - We collect information you provide when you create an account
   - We track your reading progress and faith journey
   - We store your chat messages and blog posts

2. How We Use Your Information
   - To provide and improve our services
   - To personalize your experience
   - To communicate with you

3. Information Sharing
   - We do not sell your personal information
   - Your public profile and posts are visible to other users
   - We may share aggregated, non-personal information

4. Security
   - We implement security measures to protect your data
   - Your password is stored securely

5. Changes to This Policy
   - We may update this policy from time to time
   - We will notify you of significant changes

For questions about this policy, please contact us at privacy@faithmission.app
'''),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _showTermsOfService() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Terms of Service'),
        content: const SingleChildScrollView(
          child: Text('''
Terms of Service for Faith Mission App

1. Acceptance of Terms
   - By using this app, you agree to these terms

2. User Conduct
   - You must be at least 13 years old to use this app
   - You agree to use the app only for lawful purposes
   - You agree not to post offensive, political, or inappropriate content
   - All discussions must be focused on the Gospel

3. Content Guidelines
   - No political discussions allowed
   - No offensive language or content
   - No spam or promotional content
   - Respect all users and their beliefs

4. Account Termination
   - We may suspend or terminate accounts that violate these terms
   - You can delete your account at any time

5. Disclaimer
   - The app is provided "as is" without warranties
   - We are not responsible for any content posted by users

6. Changes to Terms
   - We may update these terms from time to time
   - Continued use constitutes acceptance of changes

For questions about these terms, please contact us at legal@faithmission.app
'''),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
