/// App-wide constants.
class AppConfig {
  static const String version = '1.0.0';
  static const String appName = 'Faith Mission';

  /// The bundled translation (see assets/data/bible_kjv.json).
  static const String defaultBibleTranslation = 'KJV';

  /// Contact for arranging the "skip to Bishop" payment.
  static const String adminEmail = 'ephraimrusike13@gmail.com';

  /// Ed25519 public key that verifies Bishop unlock codes (see
  /// tool/bishop_codes.dart). The private key is kept by the admin only.
  static const String bishopUnlockPublicKey = 'j7iCRQLIHxUKuqf10Zj/PmAdOH/TTS/G5CVEXjRBoNc=';

  /// Which store this build is for. Build the Google Play version with
  /// `--dart-define=DISTRIBUTION=play`: it keeps "skip to Bishop" locked and
  /// shows no outside-payment instructions, as Google Play's payments policy
  /// requires. Any other build (e.g. an APK shared directly) shows how to
  /// contact the admin and where to enter an unlock code.
  static const String distribution =
      String.fromEnvironment('DISTRIBUTION', defaultValue: 'direct');

  static bool get isPlayStoreBuild => distribution == 'play';
}
