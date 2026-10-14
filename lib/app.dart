import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/theme.dart';
import 'config/router.dart';
import 'services/notification_service.dart';
import 'services/local_auth_service.dart';
import 'services/faith_journey_service.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    // Initialize notification service
    await ref.read(notificationServiceProvider).initialize();
    
    // Setup reading reminders for logged-in user
    final userId = ref.read(localAuthServiceProvider).currentUserId;
    if (userId != null) {
      await ref.read(notificationServiceProvider).setupDefaultReadingReminders(userId);
      await ref.read(faithJourneyServiceProvider).setupReadingReminders(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Faith Mission',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      routerConfig: AppRouter.router,
    );
  }

  @override
  void dispose() {
    // Clean up services
    ref.read(localAuthServiceProvider).dispose();
    super.dispose();
  }
}
