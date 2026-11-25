// Firebase project settings.
//
// These values are not secret: they identify the Firebase project, and access
// is controlled by Firebase Authentication and firestore.rules.
//
// To connect a real project, replace the placeholders below with the values
// from the project's google-services.json (Android) and the web app config,
// or run `flutterfire configure`, which regenerates this file.
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  /// The placeholder project ID. "demo-" projects only work with the local
  /// Firebase Emulator Suite; they never reach Google's servers.
  static const String demoProjectId = 'demo-faith-mission';

  /// True once real project settings have been filled in below.
  static bool get isConfigured => android.projectId != demoProjectId;

  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        return android;
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'demo-api-key',
    appId: '1:000000000000:android:0000000000000000',
    messagingSenderId: '000000000000',
    projectId: demoProjectId,
    storageBucket: '$demoProjectId.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'demo-api-key',
    appId: '1:000000000000:ios:0000000000000000',
    messagingSenderId: '000000000000',
    projectId: demoProjectId,
    storageBucket: '$demoProjectId.appspot.com',
    iosBundleId: 'com.faithmission.app',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'demo-api-key',
    appId: '1:000000000000:web:0000000000000000',
    messagingSenderId: '000000000000',
    projectId: demoProjectId,
    authDomain: '$demoProjectId.firebaseapp.com',
    storageBucket: '$demoProjectId.appspot.com',
  );
}
