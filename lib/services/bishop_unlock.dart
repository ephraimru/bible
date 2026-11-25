import 'dart:convert';

import 'package:cryptography/cryptography.dart';

import '../config/app_config.dart';

/// Offline "skip to Bishop" unlock codes.
///
/// The admin signs `faith-mission:bishop-skip:v1:<account email>` with an
/// Ed25519 private key (see `tool/bishop_codes.dart` or
/// `tool/bishop_code_generator.html`). The app only holds the matching
/// public key, so codes can be checked offline but cannot be forged, and a
/// code only works for the account email it was made for.
///
/// Code format: `FMB1.` followed by the 64-byte signature in base64url
/// (no padding), 91 characters in total.
class BishopUnlock {
  static const String codePrefix = 'FMB1.';

  /// The exact bytes that are signed for [email].
  static List<int> messageFor(String email) =>
      utf8.encode('faith-mission:bishop-skip:v1:${normalizeEmail(email)}');

  static String normalizeEmail(String email) => email.trim().toLowerCase();

  /// Extracts the signature from a pasted code, tolerating spaces and line
  /// breaks. Returns null if it is not a well-formed code.
  static List<int>? parseCode(String code) {
    final compact = code.replaceAll(RegExp(r'\s+'), '');
    if (!compact.toUpperCase().startsWith(codePrefix)) return null;
    final body = compact.substring(codePrefix.length);
    if (!RegExp(r'^[A-Za-z0-9_-]{86}$').hasMatch(body)) return null;
    try {
      final bytes = base64Url.decode('$body==');
      return bytes.length == 64 ? bytes : null;
    } on FormatException {
      return null;
    }
  }

  static String formatCode(List<int> signature) =>
      '$codePrefix${base64Url.encode(signature).replaceAll('=', '')}';

  /// True if [code] was issued by the admin for [email].
  static Future<bool> verify(
    String code,
    String email, {
    String publicKeyBase64 = AppConfig.bishopUnlockPublicKey,
  }) async {
    final signature = parseCode(code);
    if (signature == null) return false;
    final publicKey = SimplePublicKey(
      base64.decode(publicKeyBase64),
      type: KeyPairType.ed25519,
    );
    return Ed25519().verify(
      messageFor(email),
      signature: Signature(signature, publicKey: publicKey),
    );
  }

  /// Creates a code for [email] from a 32-byte Ed25519 private key seed.
  /// Used by the admin tools and tests; the app itself never signs.
  static Future<String> sign(String email, List<int> privateKeySeed) async {
    final keyPair = await Ed25519().newKeyPairFromSeed(privateKeySeed);
    final signature = await Ed25519().sign(messageFor(email), keyPair: keyPair);
    return formatCode(signature.bytes);
  }
}
