import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';
import '../models/premium_model.dart';
import 'local_auth_service.dart';
import 'local_storage_service.dart';

// Premium Service Provider
final premiumServiceProvider = Provider<PremiumService>((ref) {
  return PremiumService(
    localStorageService: ref.read(localStorageServiceProvider),
  );
});

// Current Subscription Provider
final currentSubscriptionProvider = FutureProvider<Subscription?>((ref) async {
  final userId = ref.watch(localAuthStateProvider).value?.id ??
      ref.read(localAuthServiceProvider).currentUserId;
  if (userId == null) return null;
  return ref.read(premiumServiceProvider).getActiveSubscription(userId);
});

// Available Products Provider (empty for local mode)
final availableProductsProvider = FutureProvider<List<dynamic>>((ref) async {
  // In local mode, we don't have in-app purchases
  return [];
});

/// Thrown when a purchase is attempted but no payment provider is set up.
class PurchasesUnavailableException implements Exception {
  @override
  String toString() =>
      'In-app purchases are not available yet. Premium features will be '
      'offered once payments are set up.';
}

class PremiumService {
  /// There is no app-store / payment integration yet. Until there is, every
  /// purchase path refuses instead of granting paid features for free.
  static const bool isStoreAvailable = false;

  final LocalStorageService _localStorageService;

  // Store product IDs (for when a payment provider is added)
  static const basicMonthly = 'faith_mission_basic_monthly';
  static const basicYearly = 'faith_mission_basic_yearly';
  static const proMonthly = 'faith_mission_pro_monthly';
  static const proYearly = 'faith_mission_pro_yearly';
  static const bishopLadderSkip = 'faith_mission_bishop_skip';
  
  // Product IDs list
  static const productIds = {
    basicMonthly,
    basicYearly,
    proMonthly,
    proYearly,
    bishopLadderSkip,
  };

  PremiumService({
    required LocalStorageService localStorageService,
  })  : _localStorageService = localStorageService;

  // Initialize
  Future<void> _initialize() async {
    // In local mode, premium features are available to everyone
    // or can be enabled through a simple flag
  }

  // Get active subscription
  Future<Subscription?> getActiveSubscription(String userId) async {
    return _localStorageService.getActiveSubscription(userId);
  }

  // Stream active subscription
  Stream<Subscription?> streamActiveSubscription(String userId) async* {
    // For local mode, just return a stream with the current subscription
    final sub = await getActiveSubscription(userId);
    yield sub;
  }

  // Get available products (empty for local mode)
  Future<List<dynamic>> getAvailableProducts() async {
    return [];
  }

  /// Starts a subscription purchase. Returns true when the purchase completed.
  Future<bool> purchaseSubscription(SubscriptionPlan plan) async {
    if (!isStoreAvailable) throw PurchasesUnavailableException();
    return false;
  }

  /// Starts the one-off "skip to Bishop" purchase.
  Future<bool> purchaseLadderSkip() async {
    if (!isStoreAvailable) throw PurchasesUnavailableException();
    return false;
  }

  Future<bool> restorePurchases() async {
    if (!isStoreAvailable) throw PurchasesUnavailableException();
    return false;
  }

  /// Applies a ladder skip. Must only be called after the payment provider
  /// has verified the purchase identified by [transactionId].
  Future<void> processLadderSkipPayment({
    required String userId,
    required double amount,
    required String transactionId,
    required UserRole fromRole,
    required UserRole toRole,
  }) async {
    if (!isStoreAvailable) throw PurchasesUnavailableException();
    final user = await _localStorageService.getUser(userId);
    if (user == null) return;

    await _localStorageService.updateUser(userId, {
      'role': toRole,
      'hasPaidToSkipLadder': true,
      'canPostOnBlog': true,
    });

    final journey = await _localStorageService.getFaithJourney(userId);
    if (journey != null) {
      await _localStorageService.updateFaithJourney(userId, {
        'currentRole': toRole,
        'hasReached${toRole.name.capitalize()}': true,
        'hasPaidToSkip': true,
        'canPostOnBlog': true,
      });
    }

    await _localStorageService.createPayment(Payment(
      id: '',
      userId: userId,
      amount: amount,
      currency: 'USD',
      method: PaymentMethod.creditCard,
      status: PaymentStatus.completed,
      transactionId: transactionId,
      description: 'Ladder skip from ${fromRole.displayName} to ${toRole.displayName}',
      isForLadderSkip: true,
      ladderSkipFromRole: fromRole.name,
      ladderSkipToRole: toRole.name,
      createdAt: DateTime.now(),
      completedAt: DateTime.now(),
    ));
  }

  // Update premium tier
  Future<void> updatePremiumTier(String userId, PremiumTier tier) async {
    await _localStorageService.updateUser(userId, {'premiumTier': tier});
  }

  // Get premium features for user
  Future<Map<String, bool>> getPremiumFeatures(String userId) async {
    final user = await _localStorageService.getUser(userId);
    if (user == null) return {};
    
    return {
      'adFree': user.premiumTier != PremiumTier.free,
      'offlineMode': user.premiumTier.index >= PremiumTier.basic.index,
      'advancedSearch': user.premiumTier.index >= PremiumTier.basic.index,
      'readingPlans': user.premiumTier.index >= PremiumTier.pro.index,
      'commentaries': user.premiumTier.index >= PremiumTier.pro.index,
      'devotionals': user.premiumTier.index >= PremiumTier.pro.index,
      'customThemes': user.premiumTier.index >= PremiumTier.basic.index,
      'canPostOnBlog': user.role == UserRole.bishop || user.canPostOnBlog,
      'hasPaidToSkipLadder': user.hasPaidToSkipLadder,
    };
  }

  // Check if user has premium feature
  Future<bool> hasFeature(String userId, String feature) async {
    final features = await getPremiumFeatures(userId);
    return features[feature] ?? false;
  }

  // Get subscription history
  Future<List<Subscription>> getSubscriptionHistory(String userId) async {
    return _localStorageService.getUserSubscriptions(userId);
  }

  Future<List<Payment>> getPaymentHistory(String userId) =>
      _localStorageService.getUserPayments(userId);

  /// Records a subscription after the payment provider has verified it.
  Future<String> createSubscription({
    required String userId,
    required SubscriptionPlan plan,
    required PremiumTier tier,
    required Duration duration,
  }) async {
    if (!isStoreAvailable) throw PurchasesUnavailableException();
    final now = DateTime.now();
    final id = await _localStorageService.createSubscription(Subscription(
      id: '',
      userId: userId,
      plan: plan,
      startDate: now,
      endDate: now.add(duration),
      isActive: true,
      autoRenew: true,
      createdAt: now,
      updatedAt: now,
    ));
    await updatePremiumTier(userId, tier);
    return id;
  }

  Future<void> cancelSubscription(String subscriptionId) =>
      _localStorageService.updateSubscription(subscriptionId, {
        'isCancelled': true,
        'autoRenew': false,
        'cancelledAt': DateTime.now(),
      });

  // Dispose
  void dispose() {
    // Nothing to dispose in local mode
  }
}

extension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}
