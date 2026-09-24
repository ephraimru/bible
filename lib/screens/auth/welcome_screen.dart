import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../config/theme.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                const Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(AppTheme.md),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.1),
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
                    child: SvgPicture.asset(
                      'assets/images/bible.svg',
                      height: 200,
                      color: Colors.white.withOpacity(0.8),
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
                
                // Divider
                const Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppTheme.md),
                      child: Text('or'),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                
                const SizedBox(height: AppTheme.md),
                
                // Social login buttons
                OutlinedButton.icon(
                  onPressed: () {
                    // Google sign in
                    context.go('/home');
                  },
                  icon: SvgPicture.asset(
                    'assets/images/google.svg',
                    height: 20,
                  ),
                  label: const Text('Continue with Google'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: AppTheme.md),
                    shape: RoundedRectangleBorder(
                      borderRadius: AppTheme.mediumBorderRadius,
                    ),
                  ),
                ),
                
                const SizedBox(height: AppTheme.md),
                
                OutlinedButton.icon(
                  onPressed: () {
                    // Apple sign in
                    context.go('/home');
                  },
                  icon: const Icon(Icons.apple),
                  label: const Text('Continue with Apple'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: AppTheme.md),
                    shape: RoundedRectangleBorder(
                      borderRadius: AppTheme.mediumBorderRadius,
                    ),
                  ),
                ),
                
                const SizedBox(height: AppTheme.lg),
                
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
