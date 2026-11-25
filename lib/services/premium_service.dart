import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';
import '../models/premium_model.dart';
import 'database_service.dart';
import 'local_storage_service.dart';
import 'local_auth_service.dart';

// Premium Service Provider
final premiumServiceProvider = Provider<PremiumService>((ref) {
  return PremiumService(
    localStorageService: ref.read(localStorageServiceProvider),
  );
});

// Active subscription of the signed-in user; refreshes when the user changes.
final currentSubscriptionProvider = FutureProvider<Subscription?>((ref) async {
  final userId = ref.watch(localCurrentUserProvider.select((user) => user.value?.id));
  if (userId == null) return null;
  return ref.read(premiumServiceProvider).getActiveSubscription(userId);
});

// Available Products Provider (empty for local mode)
final availableProductsProvider = FutureProvider<List<dynamic>>((ref) async {
  // In local mode, we don't have in-app purchases
  return [];
});

class PremiumService {
  final LocalStorageService _localStorageService;

  // Product IDs (for future Firebase mode)
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

  // Simulated prices (USD), matching the premium screen.
  static const Map<SubscriptionPlan, double> planPrices = {
    SubscriptionPlan.basicMonthly: 4.99,
    SubscriptionPlan.basicYearly: 39.99,
    SubscriptionPlan.proMonthly: 9.99,
    SubscriptionPlan.proYearly: 79.99,
    SubscriptionPlan.bishop: 24.99,
  };
  static const double ladderSkipPrice = 49.99;

  PremiumService({
    required LocalStorageService localStorageService,
  })  : _localStorageService = localStorageService;

  String? get _currentUserId =>
      _localStorageService.getAppSetting<String>('current_user_id');

  /// Simulated purchase of [plan] for the signed-in user (local mode has no
  /// payment provider). Returns false if nobody is signed in.
  Future<bool> purchaseSubscription(SubscriptionPlan plan) async {
    final userId = _currentUserId;
    if (userId == null || plan == SubscriptionPlan.free) return false;

    final isYearly =
        plan == SubscriptionPlan.basicYearly || plan == SubscriptionPlan.proYearly;
    await createSubscription(
      userId: userId,
      plan: plan,
      price: planPrices[plan] ?? 0,
      currency: 'USD',
      duration: Duration(days: isYearly ? 365 : 30),
    );
    return true;
  }

  /// Simulated ladder-skip purchase: records the payment only. The caller
  /// promotes the user. Returns false if nobody is signed in.
  Future<bool> purchaseLadderSkip() async {
    final userId = _currentUserId;
    if (userId == null) return false;
    final user = await _localStorageService.getUser(userId);
    final now = DateTime.now();
    await _localStorageService.createPayment(Payment(
      id: '',
      userId: userId,
      amount: ladderSkipPrice,
      currency: 'USD',
      method: PaymentMethod.creditCard,
      status: PaymentStatus.completed,
      transactionId: 'local_${now.millisecondsSinceEpoch}',
      description: 'Ladder skip to Bishop',
      isForLadderSkip: true,
      ladderSkipFromRole: user?.role.name,
      ladderSkipToRole: UserRole.bishop.name,
      createdAt: now,
      completedAt: now,
    ));
    return true;
  }

  /// Re-applies the signed-in user's active subscription, if any. Returns
  /// whether one was found.
  Future<bool> restorePurchases() async {
    final userId = _currentUserId;
    if (userId == null) return false;
    final subscription = await getActiveSubscription(userId);
    if (subscription == null || subscription.endDate.isBefore(DateTime.now())) {
      return false;
    }
    await updatePremiumTier(userId, premiumTierForPlan(subscription.plan));
    return true;
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

  // Process ladder skip payment (simulated for local mode)
  Future<void> processLadderSkipPayment({
    required String userId,
    required double amount,
    required String transactionId,
    required UserRole fromRole,
    required UserRole toRole,
  }) async {
    // In local mode, just update the user's role
    final user = await _localStorageService.getUser(userId);
    if (user != null) {
      await _localStorageService.updateUser(userId, {
        'role': toRole.name,
        'hasPaidToSkipLadder': true,
        'canPostOnBlog': true,
        'updatedAt': DateTime.now(),
      });
      
      // Update faith journey if it exists
      final journey = await _localStorageService.getFaithJourney(userId);
      if (journey != null) {
        await _localStorageService.updateFaithJourney(userId, {
          'currentRole': toRole.name,
          'hasReached${toRole.name.capitalize()}': true,
          'hasPaidToSkip': true,
          'canPostOnBlog': true,
          'updatedAt': DateTime.now(),
        });
      }
      
      // Create payment record
      final payment = Payment(
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
      );
      
      await _localStorageService.createPayment(payment);
    }
  }

  // Update premium tier
  Future<void> updatePremiumTier(String userId, PremiumTier tier) async {
    await _localStorageService.updateUser(userId, {
      'premiumTier': tier.name,
      'updatedAt': DateTime.now(),
    });
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

  // Get payment history
  Future<List<Payment>> getPaymentHistory(String userId) =>
      _localStorageService.getUserPayments(userId);

  // Create subscription (simulated for local mode)
  Future<String> createSubscription({
    required String userId,
    required SubscriptionPlan plan,
    required double price,
    required String currency,
    required Duration duration,
  }) async {
    final subscription = Subscription(
      id: '',
      userId: userId,
      plan: plan,
      amount: price,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(duration),
      isActive: true,
      autoRenew: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    final subscriptionId = await _localStorageService.createSubscription(subscription);
    await updatePremiumTier(userId, premiumTierForPlan(plan));
    return subscriptionId;
  }

  // Cancel subscription (simulated for local mode)
  Future<void> cancelSubscription(String subscriptionId) async {
    final subscription = await _localStorageService.getSubscription(subscriptionId);
    await _localStorageService.updateSubscription(subscriptionId, {
      'isActive': false,
      'isCancelled': true,
      'autoRenew': false,
      'cancelledAt': DateTime.now(),
    });
    if (subscription != null) {
      await updatePremiumTier(subscription.userId, PremiumTier.free);
    }
  }

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
