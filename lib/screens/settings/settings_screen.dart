import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/theme.dart';
import '../../models/user_model.dart';
import '../../services/local_auth_service.dart';
import '../../services/local_storage_service.dart';
import '../../services/faith_journey_service.dart';
import '../../services/notification_service.dart';
import '../../services/mock_bible_service.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(localCurrentUserProvider);
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
    final localStorage = ref.read(localStorageServiceProvider);
    await localStorage.updateUser(userId, {
      'preferences.$key': value,
      'updatedAt': DateTime.now(),
    });
  }

  Future<void> _showTimePicker() async {
    final user = ref.read(localCurrentUserProvider);
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
      final localStorage = ref.read(localStorageServiceProvider);
      await localStorage.updateUser(user.id, {
        'preferences.reminderTime': timeString,
        'updatedAt': DateTime.now(),
      });
    }
  }

  Future<void> _showTitleSelection() async {
    final user = ref.read(localCurrentUserProvider);
    if (user == null) return;
    
    final faithJourneyService = ref.read(faithJourneyServiceProvider);
    final availableTitles = await faithJourneyService.getAvailableTitles(user.id);
    
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Your Title'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: availableTitles.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(availableTitles[index]),
                onTap: () async {
                  await faithJourneyService.setChosenTitle(user.id, availableTitles[index]);
                  if (mounted) Navigator.of(context).pop();
                },
              );
            },
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
    final user = ref.read(localCurrentUserProvider);
    if (user == null) return;
    
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Blocked Users'),
        content: user.blockedUserIds.isEmpty
            ? const Text('You have not blocked any users')
            : SizedBox(
                width: double.maxFinite,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: user.blockedUserIds.length,
                  itemBuilder: (context, index) {
                    final blockedUserId = user.blockedUserIds[index];
                    return ListTile(
                      title: Text(blockedUserId),
                      trailing: IconButton(
                        icon: const Icon(Icons.unblock, color: Colors.green),
                        onPressed: () async {
                          final localStorage = ref.read(localStorageServiceProvider);
                          final blockedUserIds = List<String>.from(user.blockedUserIds);
                          blockedUserIds.remove(blockedUserId);
                          await localStorage.updateUser(user.id, {
                            'blockedUserIds': blockedUserIds,
                            'updatedAt': DateTime.now(),
                          });
                          if (mounted) Navigator.of(context).pop();
                        },
                      ),
                    );
                  },
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

  Future<void> _showAboutDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About Faith Mission'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Faith Mission is a comprehensive Bible app designed to help you grow in your faith journey.'),
            SizedBox(height: AppTheme.md),
            Text('Features:'),
            SizedBox(height: AppTheme.sm),
            Text('- Daily Bible verses'),
            Text('- Complete KJV Bible'),
            Text('- Faith journey tracking'),
            Text('- Community chat'),
            Text('- Blog posts'),
            SizedBox(height: AppTheme.md),
            Text('Version: 1.0.0'),
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

  Future<void> _showPrivacyPolicy() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Privacy Policy'),
        content: const SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Faith Mission Privacy Policy'),
              SizedBox(height: AppTheme.md),
              Text('We respect your privacy and are committed to protecting your personal data.'),
              SizedBox(height: AppTheme.sm),
              Text('In local mode, all your data is stored on your device and is not shared with anyone.'),
              SizedBox(height: AppTheme.sm),
              Text('When using Firebase, data is stored in the cloud and protected by Firebase security.'),
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

  Future<void> _showTermsOfService() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Terms of Service'),
        content: const SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Faith Mission Terms of Service'),
              SizedBox(height: AppTheme.md),
              Text('By using this app, you agree to our terms and conditions.'),
              SizedBox(height: AppTheme.sm),
              Text('The app is provided as-is without warranty.'),
              SizedBox(height: AppTheme.sm),
              Text('We are not responsible for any content posted by users.'),
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

  Future<void> _showHelpDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Help & Support'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Need help with Faith Mission?'),
            SizedBox(height: AppTheme.md),
            Text('Contact us at: support@faithmission.com'),
            SizedBox(height: AppTheme.sm),
            Text('Or visit our website for FAQs and tutorials.'),
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
      await ref.read(localAuthServiceProvider).signOut();
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
      final user = ref.read(localCurrentUserProvider);
      if (user != null) {
        await ref.read(localAuthServiceProvider).deleteAccount();
        if (mounted) context.go('/welcome');
      }
    }
  }
}
