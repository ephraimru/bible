import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'firebase_options.dart';
import 'services/auth_service.dart';
import 'services/local_storage_service.dart';

/// Build with `--dart-define=USE_FIREBASE_EMULATOR=true` to use the local
/// Firebase Emulator Suite (`firebase emulators:start`) instead of the real
/// project. Set FIREBASE_EMULATOR_HOST for a device on the network.
const bool _useEmulator = bool.fromEnvironment('USE_FIREBASE_EMULATOR');
const String _emulatorHost =
    String.fromEnvironment('FIREBASE_EMULATOR_HOST', defaultValue: 'localhost');

Future<void> _initFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (_useEmulator) {
    await FirebaseAuth.instance.useAuthEmulator(_emulatorHost, 9099);
    FirebaseFirestore.instance.useFirestoreEmulator(_emulatorHost, 8080);
  } else if (!DefaultFirebaseOptions.isConfigured) {
    debugPrint('Firebase is not configured: see docs/firebase-setup.md. '
        'Accounts, blog and chat will not work until it is.');
  }
  // Wait for a saved sign-in to be restored so the first screen is right.
  await FirebaseAuth.instance.authStateChanges().first;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Local storage (Hive) for offline data: reading progress, settings, ...
  final localStorageService = LocalStorageService();
  await localStorageService.initialize();
  
  await _initFirebase();
  final authService = AuthService(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
    localStorageService: localStorageService,
    isBackendConfigured: _useEmulator || DefaultFirebaseOptions.isConfigured,
  );
  
  // Set preferred orientations (no-op on web/desktop)
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
        authServiceProvider.overrideWithValue(authService),
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
