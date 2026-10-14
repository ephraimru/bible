import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';
import '../models/premium_model.dart';
import 'local_storage_service.dart';

// Premium Service Provider
final premiumServiceProvider = Provider<PremiumService>((ref) {
  return PremiumService(
    localStorageService: ref.read(localStorageServiceProvider),
  );
});

// Current Subscription Provider
final currentSubscriptionProvider = Provider<Subscription?>((ref) {
  final userId = ref.read(localAuthServiceProvider).currentUserId;
  if (userId == null) return null;
  
  final premiumService = ref.read(premiumServiceProvider);
  return premiumService.getActiveSubscription(userId);
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
  Stream<Subscription?> streamActiveSubscription(String userId) {
    // For local mode, just return a stream with the current subscription
    return Stream.value(getActiveSubscription(userId));
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
  Future<List<Payment>> getPaymentHistory(String userId) async {
    // For local mode, return empty list
    return [];
  }

  // Create subscription (simulated for local mode)
  Future<String> createSubscription({
    required String userId,
    required PremiumTier tier,
    required double price,
    required String currency,
    required Duration duration,
  }) async {
    final subscription = Subscription(
      id: '',
      userId: userId,
      plan: tier.name,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(duration),
      isActive: true,
      autoRenew: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    await _localStorageService.createSubscription(subscription);
    await updatePremiumTier(userId, tier);
    
    return subscription.id;
  }

  // Cancel subscription (simulated for local mode)
  Future<void> cancelSubscription(String subscriptionId) async {
    // In local mode, just mark as inactive
    // This would need to be implemented properly for Firebase mode
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
