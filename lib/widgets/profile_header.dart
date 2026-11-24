import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/theme.dart';
import '../models/user_model.dart';
import '../services/local_auth_service.dart';

class ProfileHeader extends ConsumerWidget {
  final UserModel user;

  const ProfileHeader({super.key, required this.user});

  Future<void> _editProfile(BuildContext context, WidgetRef ref) async {
    final nameController = TextEditingController(text: user.displayName);
    final bioController = TextEditingController(text: user.bio ?? '');
    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Display name'),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: AppTheme.md),
            TextField(
              controller: bioController,
              decoration: const InputDecoration(labelText: 'Bio'),
              maxLines: 3,
              maxLength: 200,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    final name = nameController.text.trim();
    final bio = bioController.text.trim();
    nameController.dispose();
    bioController.dispose();
    if (saved != true || name.isEmpty) return;
    await ref.read(localAuthServiceProvider).updateProfile(displayName: name, bio: bio);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Cover photo (placeholder)
        Container(
          height: 120,
          decoration: BoxDecoration(
            borderRadius: AppTheme.largeBorderRadius,
            gradient: LinearGradient(
              colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Icon(
              Icons.church,
              size: 48,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ),
        
        // Profile picture
        Container(
          margin: const EdgeInsets.only(top: -40),
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: AppTheme.mediumShadow,
            ),
            child: user.photoUrl != null
                ? CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(user.photoUrl!),
                  )
                : CircleAvatar(
                    radius: 40,
                    backgroundColor: AppTheme.primaryColor,
                    child: Text(
                      user.displayName.isNotEmpty
                          ? user.displayName[0].toUpperCase()
                          : 'U',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ),
        ),
        
        const SizedBox(height: AppTheme.md),
        
        // User info
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Display name
            Text(
              user.displayName,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: AppTheme.xs),
            
            // Role
            Chip(
              label: Text(user.role.displayName),
              backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
              labelStyle: TextStyle(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: AppTheme.mediumBorderRadius,
              ),
            ),
            
            // Custom title (if available)
            if (user.chosenTitle != null)
              Padding(
                padding: const EdgeInsets.only(top: AppTheme.xs),
                child: Text(
                  '"${user.chosenTitle}"',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            
            const SizedBox(height: AppTheme.md),
            
            // Bio
            if (user.bio != null && user.bio!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppTheme.lg),
                child: Text(
                  user.bio!,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
        
        const SizedBox(height: AppTheme.md),
        
        // Follow button (if viewing own profile, show edit)
        if (user.id == ref.read(localAuthServiceProvider).currentUserId)
          ElevatedButton.icon(
            onPressed: () => _editProfile(context, ref),
            icon: const Icon(Icons.edit_outlined),
            label: const Text('Edit Profile'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.xxl,
                vertical: AppTheme.md,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: AppTheme.mediumBorderRadius,
              ),
            ),
          )
        else
          OutlinedButton.icon(
            onPressed: () {
              // Follow user
            },
            icon: const Icon(Icons.person_add_outlined),
            label: const Text('Follow'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.xxl,
                vertical: AppTheme.md,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: AppTheme.mediumBorderRadius,
              ),
            ),
          ),
      ],
    );
  }
}
