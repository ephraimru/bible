import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../services/local_auth_service.dart';
import '../services/bible_service.dart';
import '../services/faith_journey_service.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  String? _error;

  Future<void> _initializeApp() async {
    setState(() => _error = null);
    try {
      // Load the bundled KJV while the splash is visible (min. ~1s so it
      // doesn't just flash).
      await Future.wait([
        ref.read(bibleServiceProvider).initialize(),
        Future<void>.delayed(const Duration(milliseconds: 900)),
      ]);

      final userId = ref.read(localAuthServiceProvider).currentUserId;
      if (userId != null) {
        final faithJourneyService = ref.read(faithJourneyServiceProvider);
        if (await faithJourneyService.getFaithJourney(userId) == null) {
          await faithJourneyService.createFaithJourney(userId);
        }
      }

      if (!mounted) return;
      context.go(userId != null ? '/home' : '/welcome');
    } catch (e, st) {
      debugPrint('Start-up failed: $e\n$st');
      if (mounted) setState(() => _error = 'Could not load the Bible. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.lightBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App icon
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.church,
                  size: 64,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 32),
              
              // App name
              const Text(
                'Faith Mission',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              
              // Tagline
              const Text(
                'Your Journey of Faith',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 48),
              
              // Loading indicator, or an error with a retry button
              if (_error == null)
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              else ...[
                Text(_error!, style: const TextStyle(color: Colors.white)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _initializeApp,
                  child: const Text('Retry'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
