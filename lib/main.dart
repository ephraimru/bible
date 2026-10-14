import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'services/local_storage_service.dart';
import 'services/local_auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive for local storage
  await Hive.initFlutter();
  
  // Initialize local storage service
  final localStorageService = LocalStorageService();
  await localStorageService.initialize();
  
  // Initialize local auth service
  final localAuthService = LocalAuthService(
    localStorageService: localStorageService,
  );
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  
  runApp(
    ProviderScope(
      overrides: [
        localStorageServiceProvider.overrideWithValue(localStorageService),
        localAuthServiceProvider.overrideWithValue(localAuthService),
      ],
      child: const FaithMissionApp(),
    ),
  );
}

class FaithMissionApp extends StatelessWidget {
  const FaithMissionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const App();
  }
}
