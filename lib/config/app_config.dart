// App configuration to toggle between local and Firebase modes

class AppConfig {
  // Set this to false to use local storage instead of Firebase
  static const bool useFirebase = false;
  
  // Set this to true to use mock data for Bible verses
  static const bool useMockBibleData = true;
  
  // App version
  static const String version = '1.0.0';
  
  // App name
  static const String appName = 'Faith Mission';
  
  // Default Bible translation
  static const String defaultBibleTranslation = 'KJV';
}
