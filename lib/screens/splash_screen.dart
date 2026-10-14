import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../services/local_auth_service.dart';
import '../services/local_storage_service.dart';
import '../services/mock_bible_service.dart';
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

  Future<void> _initializeApp() async {
    // Initialize mock Bible data
    final mockBibleService = ref.read(mockBibleServiceProvider);
    await mockBibleService.initialize();
    
    // Wait for auth state to be determined
    await Future.delayed(const Duration(seconds: 2));
    
    final authService = ref.read(localAuthServiceProvider);
    final userId = authService.currentUserId;
    
    if (userId != null) {
      // User is logged in, check if faith journey exists
      final faithJourneyService = ref.read(faithJourneyServiceProvider);
      final journey = await faithJourneyService.getFaithJourney(userId);
      
      if (journey == null) {
        // Create faith journey for new user
        await faithJourneyService.createFaithJourney(userId);
      }
      
      // Navigate to home
      if (mounted) {
        context.go('/home');
      }
    } else {
      // User is not logged in, navigate to welcome
      if (mounted) {
        context.go('/welcome');
      }
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
                  color: Colors.white.withOpacity(0.2),
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
              
              // Loading indicator
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
