import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/app_config.dart';
import '../models/user_model.dart';
import 'bishop_unlock.dart';
import 'local_storage_service.dart';

final premiumServiceProvider = Provider<PremiumService>((ref) {
  return PremiumService(
    localStorageService: ref.read(localStorageServiceProvider),
  );
});

/// Result of trying to redeem a Bishop unlock code.
enum RedeemResult { unlocked, alreadyBishop, invalidCode, notAvailable }

/// Paid features.
///
/// Every app feature is currently free. The one exception is skipping the
/// faith-journey ladder straight to Bishop, which the admin sells outside the
/// app and unlocks with a signed code (see [BishopUnlock]). On the Google Play
/// build ([AppConfig.isPlayStoreBuild]) code redemption is disabled, because
/// Play requires in-app features to be sold through Google Play Billing.
class PremiumService {
  PremiumService({
    required LocalStorageService localStorageService,
    String unlockPublicKey = AppConfig.bishopUnlockPublicKey,
  })  : _storage = localStorageService,
        _unlockPublicKey = unlockPublicKey;

  final LocalStorageService _storage;
  final String _unlockPublicKey;

  /// Whether this build lets users redeem an unlock code.
  static bool get canRedeemCodes => !AppConfig.isPlayStoreBuild;

  /// True if [user] is a Bishop, whether by followers or by an unlock.
  static bool isBishop(UserModel user) =>
      user.role == UserRole.bishop || user.hasPaidToSkipLadder;

  /// Checks [code] against [userId]'s account email and, if valid, makes the
  /// user a Bishop.
  Future<RedeemResult> redeemBishopCode(String userId, String code) async {
    if (!canRedeemCodes) return RedeemResult.notAvailable;
    final user = await _storage.getUser(userId);
    if (user == null) return RedeemResult.invalidCode;
    if (isBishop(user)) return RedeemResult.alreadyBishop;
    if (!await BishopUnlock.verify(code, user.email, publicKeyBase64: _unlockPublicKey)) {
      return RedeemResult.invalidCode;
    }
    await grantBishop(userId, viaSkip: true);
    return RedeemResult.unlocked;
  }

  /// Makes [userId] a Bishop: blog posting and title selection unlocked.
  Future<void> grantBishop(String userId, {required bool viaSkip}) async {
    await _storage.updateUser(userId, {
      'role': UserRole.bishop,
      'canPostOnBlog': true,
      if (viaSkip) 'hasPaidToSkipLadder': true,
    });
    final journey = await _storage.getFaithJourney(userId);
    if (journey != null) {
      await _storage.updateFaithJourney(userId, {
        'currentRole': UserRole.bishop,
        'hasReachedBishop': true,
        'canPostOnBlog': true,
        if (viaSkip) 'hasPaidToSkip': true,
      });
    }
  }

  /// Feature flags for [userId]. Everything is free; only Bishop privileges
  /// depend on the user's role.
  Future<Map<String, bool>> getFeatures(String userId) async {
    final user = await _storage.getUser(userId);
    if (user == null) return {};
    return {
      'fullBible': true,
      'search': true,
      'offlineReading': true,
      'dailyVerse': true,
      'faithJourney': true,
      'blogReading': true,
      'chat': true,
      'adFree': true,
      'canPostOnBlog': isBishop(user) || user.canPostOnBlog,
      'canChooseTitle': isBishop(user),
    };
  }

  Future<bool> hasFeature(String userId, String feature) async =>
      (await getFeatures(userId))[feature] ?? false;
}
