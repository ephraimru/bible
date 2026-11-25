/// App-wide constants.
class AppConfig {
  static const String version = '1.0.0';
  static const String appName = 'Faith Mission';

  /// The bundled translation (see assets/data/bible_kjv.json).
  static const String defaultBibleTranslation = 'KJV';

  /// Contact for arranging the "skip to Bishop" payment.
  static const String adminEmail = 'ephraimrusike13@gmail.com';

  /// Which store this build is for. Build the Google Play version with
  /// `--dart-define=DISTRIBUTION=play`: it keeps "skip to Bishop" locked and
  /// shows no outside-payment instructions, as Google Play's payments policy
  /// requires. Any other build (e.g. an APK shared directly) shows how to
  /// contact the admin, who then grants Bishop in the Firebase console.
  static const String distribution =
      String.fromEnvironment('DISTRIBUTION', defaultValue: 'direct');

  static bool get isPlayStoreBuild => distribution == 'play';
}
