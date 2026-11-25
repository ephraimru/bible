import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/app_config.dart';
import '../models/user_model.dart';
import 'local_storage_service.dart';

final premiumServiceProvider = Provider<PremiumService>((ref) {
  return PremiumService(
    localStorageService: ref.read(localStorageServiceProvider),
  );
});

/// Paid features.
///
/// Every app feature is currently free. The one exception is skipping the
/// faith-journey ladder straight to Bishop, which the admin arranges outside
/// the app and then grants by setting `role: "bishop"` on the user's profile
/// in the Firebase console (users/{uid}). The app picks the change up live.
/// The Google Play build ([AppConfig.isPlayStoreBuild]) shows no payment
/// instructions, because Play requires in-app features to be sold through
/// Google Play Billing.
class PremiumService {
  PremiumService({required LocalStorageService localStorageService})
      : _storage = localStorageService;

  final LocalStorageService _storage;

  /// Whether this build may show how to contact the admin about Bishop.
  static bool get showsAdminContact => !AppConfig.isPlayStoreBuild;

  /// True if [user] is a Bishop, whether by followers or by an unlock.
  static bool isBishop(UserModel user) =>
      user.role == UserRole.bishop || user.hasPaidToSkipLadder;

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
