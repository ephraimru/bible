import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/theme.dart';
import '../../services/local_storage_service.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canSave = ref.read(localStorageServiceProvider).isPersistent;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppTheme.xl),
                
                // App icon and name
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(AppTheme.md),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.church,
                        size: 64,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    SizedBox(height: AppTheme.md),
                    Text(
                      'Faith Mission',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            color: AppTheme.primaryColor,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Your Journey of Faith',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.grey,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                
                const SizedBox(height: AppTheme.xxl),
                
                // Welcome image
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: AppTheme.mediumBorderRadius,
                    gradient: AppTheme.primaryGradient,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.menu_book_rounded,
                      size: 160,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                ),
                
                const SizedBox(height: AppTheme.xxl),
                
                // Description
                Text(
                  'Join our community of believers and grow in your faith journey. Read the Bible, share your thoughts, and connect with others.',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: AppTheme.xxl),
                
                // Action buttons
                ElevatedButton(
                  onPressed: () => context.go('/login'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: AppTheme.md),
                    shape: RoundedRectangleBorder(
                      borderRadius: AppTheme.mediumBorderRadius,
                    ),
                  ),
                  child: const Text('Log In'),
                ),
                
                const SizedBox(height: AppTheme.md),
                
                OutlinedButton(
                  onPressed: () => context.go('/signup'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: AppTheme.md),
                    shape: RoundedRectangleBorder(
                      borderRadius: AppTheme.mediumBorderRadius,
                    ),
                  ),
                  child: const Text('Sign Up'),
                ),
                
                const SizedBox(height: AppTheme.md),
                
                if (!canSave) ...[
                  Container(
                    padding: const EdgeInsets.all(AppTheme.md),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade50,
                      borderRadius: AppTheme.mediumBorderRadius,
                      border: Border.all(color: Colors.amber.shade300),
                    ),
                    child: const Text(
                      'This browser is not letting the app save data, so your '
                      'account and reading progress will last only until you '
                      'close this page.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: AppTheme.md),
                ],

                // Terms and privacy
                Text(
                  'By continuing, you agree to our Terms of Service and Privacy Policy',
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: AppTheme.md),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
