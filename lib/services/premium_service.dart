import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../models/user_model.dart';
import '../models/premium_model.dart';
import 'database_service.dart';

// Premium Service Provider
final premiumServiceProvider = Provider<PremiumService>((ref) {
  return PremiumService(
    databaseService: ref.read(databaseServiceProvider),
    inAppPurchase: InAppPurchase.instance,
  );
});

// Current Subscription Provider
final currentSubscriptionProvider = StreamProvider<Subscription?>((ref) async* {
  final userId = ref.read(authServiceProvider).currentUserId;
  if (userId == null) return;
  
  final premiumService = ref.read(premiumServiceProvider);
  yield* premiumService.streamActiveSubscription(userId);
});

// Available Products Provider
final availableProductsProvider = FutureProvider<List<ProductDetails>>((ref) async {
  return ref.read(premiumServiceProvider).getAvailableProducts();
});

class PremiumService {
  final DatabaseService _databaseService;
  final InAppPurchase _inAppPurchase;
  
  // Product IDs
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

  // In-app purchase stream
  final Stream<List<PurchaseDetails>> _purchaseStream;
  final StreamSubscription<List<PurchaseDetails>>? _subscription;

  PremiumService({
    required DatabaseService databaseService,
    required InAppPurchase inAppPurchase,
  })  : _databaseService = databaseService,
        _inAppPurchase = inAppPurchase,
        _purchaseStream = inAppPurchase.purchaseStream {
    _subscription = _purchaseStream.listen(_onPurchaseUpdate);
    _initialize();
  }

  // Initialize
  Future<void> _initialize() async {
    await _inAppPurchase.initialize();
    await _loadPurchases();
  }

  // Load previous purchases
  Future<void> _loadPurchases() async {
    final purchaseStream = _inAppPurchase.queryPastPurchases();
    await for (final purchases in purchaseStream) {
      for (final purchase in purchases) {
        await _verifyPurchase(purchase);
      }
      break;
    }
  }

  // Handle purchase updates
  Future<void> _onPurchaseUpdate(List<PurchaseDetails> purchases) async {
    for (final purchase in purchases) {
      await _handlePurchase(purchase);
    }
  }

  // Handle purchase
  Future<void> _handlePurchase(PurchaseDetails purchase) async {
    switch (purchase.status) {
      case PurchaseStatus.pending:
        // Purchase is pending
        break;
      case PurchaseStatus.purchased:
      case PurchaseStatus.restored:
        await _verifyPurchase(purchase);
        break;
      case PurchaseStatus.error:
        // Handle error
        break;
      case PurchaseStatus.canceled:
        // Purchase was canceled
        break;
    }
  }

  // Verify purchase
  Future<void> _verifyPurchase(PurchaseDetails purchase) async {
    // In production, verify with your backend
    // For demo purposes, we'll assume it's valid
    
    final userId = _databaseService.currentUserId;
    if (userId == null) return;
    
    final productId = purchase.productID;
    
    // Check if this is a subscription or one-time purchase
    if (productId == bishopLadderSkip) {
      // One-time purchase for ladder skip
      await _processLadderSkipPurchase(userId, purchase);
    } else {
      // Subscription
      await _processSubscriptionPurchase(userId, purchase);
    }
    
    // Complete the purchase
    await _inAppPurchase.completePurchase(purchase);
  }

  // Process subscription purchase
  Future<void> _processSubscriptionPurchase(
    String userId,
    PurchaseDetails purchase,
  ) async {
    final productId = purchase.productID;
    final subscriptionPlan = _getSubscriptionPlanFromProductId(productId);
    if (subscriptionPlan == null) return;
    
    final now = DateTime.now();
    final endDate = _calculateEndDate(subscriptionPlan, now);
    
    // Create subscription record
    final subscription = Subscription(
      id: '',
      userId: userId,
      plan: subscriptionPlan,
      startDate: now,
      endDate: endDate,
      status: PaymentStatus.completed,
      paymentMethod: PaymentMethod.creditCard,
      transactionId: purchase.verificationData.serverVerificationData,
      paymentReference: purchase.purchaseID,
      autoRenew: true,
      isActive: true,
      features: _getFeaturesForPlan(subscriptionPlan),
      createdAt: now,
      updatedAt: now,
    );
    
    await _databaseService.createSubscription(subscription);
    
    // Update user premium tier
    await _updateUserPremiumTier(userId, subscriptionPlan);
  }

  // Process ladder skip purchase
  Future<void> _processLadderSkipPurchase(
    String userId,
    PurchaseDetails purchase,
  ) async {
    final user = await _databaseService.getUser(userId);
    if (user == null) return;
    
    // Create payment record
    final payment = Payment(
      id: '',
      userId: userId,
      amount: 49.99, // Price for ladder skip
      currency: 'USD',
      method: PaymentMethod.creditCard,
      status: PaymentStatus.completed,
      transactionId: purchase.verificationData.serverVerificationData,
      reference: purchase.purchaseID,
      description: 'Ladder skip payment',
      isForLadderSkip: true,
      ladderSkipFromRole: user.role.name,
      ladderSkipToRole: UserRole.bishop.name,
      createdAt: DateTime.now(),
      completedAt: DateTime.now(),
    );
    
    await _databaseService.createPayment(payment);
    
    // Promote user to bishop
    await _databaseService.updateUser(userId, {
      'role': UserRole.bishop.name,
      'hasPaidToSkipLadder': true,
      'canPostOnBlog': true,
      'premiumTier': PremiumTier.bishop.name,
      'updatedAt': FieldValue.serverTimestamp(),
    });
    
    // Update faith journey
    await _databaseService.updateFaithJourney(userId, {
      'currentRole': UserRole.bishop.name,
      'hasReachedBishop': true,
      'hasPaidToSkip': true,
      'canPostOnBlog': true,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // Get subscription plan from product ID
  SubscriptionPlan? _getSubscriptionPlanFromProductId(String productId) {
    switch (productId) {
      case basicMonthly:
        return SubscriptionPlan.basicMonthly;
      case basicYearly:
        return SubscriptionPlan.basicYearly;
      case proMonthly:
        return SubscriptionPlan.proMonthly;
      case proYearly:
        return SubscriptionPlan.proYearly;
      default:
        return null;
    }
  }

  // Calculate subscription end date
  DateTime _calculateEndDate(SubscriptionPlan plan, DateTime startDate) {
    switch (plan) {
      case SubscriptionPlan.basicMonthly:
      case SubscriptionPlan.proMonthly:
        return startDate.add(Duration(days: 30));
      case SubscriptionPlan.basicYearly:
      case SubscriptionPlan.proYearly:
        return startDate.add(Duration(days: 365));
      default:
        return startDate.add(Duration(days: 30));
    }
  }

  // Get features for plan
  List<String> _getFeaturesForPlan(SubscriptionPlan plan) {
    switch (plan) {
      case SubscriptionPlan.basicMonthly:
      case SubscriptionPlan.basicYearly:
        return [
          PremiumFeatureType.advancedSearch.name,
          PremiumFeatureType.offlineMode.name,
          PremiumFeatureType.adFreeExperience.name,
        ];
      case SubscriptionPlan.proMonthly:
      case SubscriptionPlan.proYearly:
        return [
          PremiumFeatureType.advancedSearch.name,
          PremiumFeatureType.offlineMode.name,
          PremiumFeatureType.adFreeExperience.name,
          PremiumFeatureType.premiumBibleCommentaries.name,
          PremiumFeatureType.premiumDevotionals.name,
          PremiumFeatureType.bibleReadingPlans.name,
          PremiumFeatureType.verseComparisons.name,
          PremiumFeatureType.crossReferences.name,
          PremiumFeatureType.studyNotes.name,
        ];
      case SubscriptionPlan.bishop:
        return PremiumFeatureType.values.map((f) => f.name).toList();
      default:
        return [];
    }
  }

  // Update user premium tier
  Future<void> _updateUserPremiumTier(
    String userId,
    SubscriptionPlan plan,
  ) async {
    PremiumTier tier;
    
    switch (plan) {
      case SubscriptionPlan.basicMonthly:
      case SubscriptionPlan.basicYearly:
        tier = PremiumTier.basic;
        break;
      case SubscriptionPlan.proMonthly:
      case SubscriptionPlan.proYearly:
        tier = PremiumTier.pro;
        break;
      case SubscriptionPlan.bishop:
        tier = PremiumTier.bishop;
        break;
      default:
        tier = PremiumTier.free;
    }
    
    await _databaseService.updatePremiumTier(userId, tier);
  }

  // Dispose
  void dispose() {
    _subscription?.cancel();
  }

  // ============ PUBLIC METHODS ============

  /// Get available products
  Future<List<ProductDetails>> getAvailableProducts() async {
    final productDetailsResponse = await _inAppPurchase.queryProductDetails(
      productIds.toSet(),
    );
    
    return productDetailsResponse.productDetails
        .where((product) => productIds.contains(product.id))
        .toList();
  }

  /// Get product details by ID
  Future<ProductDetails?> getProductDetails(String productId) async {
    final products = await getAvailableProducts();
    return products.firstWhere(
      (product) => product.id == productId,
      orElse: () => null,
    );
  }

  /// Purchase a product
  Future<void> purchaseProduct(String productId) async {
    final product = await getProductDetails(productId);
    if (product == null) {
      throw Exception('Product not found');
    }
    
    final purchaseParam = PurchaseParam(
      productDetails: product,
      applicationUserName: _databaseService.currentUserId,
    );
    
    await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  }

  /// Purchase a subscription
  Future<void> purchaseSubscription(String productId) async {
    final product = await getProductDetails(productId);
    if (product == null) {
      throw Exception('Product not found');
    }
    
    final purchaseParam = PurchaseParam(
      productDetails: product,
      applicationUserName: _databaseService.currentUserId,
    );
    
    await _inAppPurchase.buyAutoConsumable(
      purchaseParam: purchaseParam,
      autoConsume: false,
    );
  }

  /// Restore purchases
  Future<void> restorePurchases() async {
    await _loadPurchases();
  }

  /// Get active subscription for user
  Future<Subscription?> getActiveSubscription(String userId) async {
    return _databaseService.getActiveSubscription(userId);
  }

  /// Stream active subscription for user
  Stream<Subscription?> streamActiveSubscription(String userId) async* {
    yield await getActiveSubscription(userId);
    
    // In production, you might want to periodically check
    // For now, just yield once
  }

  /// Check if user has active subscription
  Future<bool> hasActiveSubscription(String userId) async {
    final subscription = await getActiveSubscription(userId);
    if (subscription == null) return false;
    
    return subscription.isActive && 
        subscription.endDate.isAfter(DateTime.now());
  }

  /// Get user's premium tier
  Future<PremiumTier> getPremiumTier(String userId) async {
    final user = await _databaseService.getUser(userId);
    if (user == null) return PremiumTier.free;
    
    return user.premiumTier;
  }

  /// Check if user has access to a premium feature
  Future<bool> hasAccessToFeature(
    String userId,
    PremiumFeatureType feature,
  ) async {
    final user = await _databaseService.getUser(userId);
    if (user == null) return false;
    
    // Bishop has access to all features
    if (user.role == UserRole.bishop) return true;
    
    // Check subscription
    final subscription = await getActiveSubscription(userId);
    if (subscription != null && subscription.isActive) {
      final features = subscription.features
          .map((f) => PremiumFeatureType.values.firstWhere(
                (type) => type.name == f,
                orElse: () => PremiumFeatureType.advancedSearch,
              ))
          .toList();
      
      return features.contains(feature);
    }
    
    // Check premium tier
    final tier = user.premiumTier;
    
    switch (feature) {
      case PremiumFeatureType.advancedSearch:
      case PremiumFeatureType.offlineMode:
      case PremiumFeatureType.adFreeExperience:
        return tier.index >= PremiumTier.basic.index;
      case PremiumFeatureType.premiumBibleCommentaries:
      case PremiumFeatureType.premiumDevotionals:
      case PremiumFeatureType.bibleReadingPlans:
      case PremiumFeatureType.verseComparisons:
      case PremiumFeatureType.crossReferences:
      case PremiumFeatureType.studyNotes:
        return tier.index >= PremiumTier.pro.index;
      case PremiumFeatureType.customTitle:
      case PremiumFeatureType.profileBadge:
      case PremiumFeatureType.prioritySupport:
      case PremiumFeatureType.exclusiveChatRooms:
        return tier.index >= PremiumTier.pro.index;
      case PremiumFeatureType.blogPosting:
      case PremiumFeatureType.titleSelection:
      case PremiumFeatureType.followerAnalytics:
      case PremiumFeatureType.skipLadder:
        return user.role == UserRole.bishop || user.hasPaidToSkipLadder;
      case PremiumFeatureType.customThemes:
      case PremiumFeatureType.customNotifications:
        return tier.index >= PremiumTier.basic.index;
    }
  }

  /// Get all features for user's tier
  Future<List<PremiumFeature>> getFeaturesForUser(String userId) async {
    final user = await _databaseService.getUser(userId);
    if (user == null) return [];
    
    final tier = user.premiumTier;
    final subscription = await getActiveSubscription(userId);
    
    // Get all features
    final allFeatures = PremiumFeatureType.values.map((type) {
      return PremiumFeature(
        id: type,
        name: _getFeatureName(type),
        description: _getFeatureDescription(type),
        icon: _getFeatureIcon(type),
        minimumPlan: _getMinimumPlanForFeature(type),
        isAvailable: true,
        isUnlocked: hasAccessToFeature(userId, type),
      );
    }).toList();
    
    return allFeatures;
  }

  // Get feature name
  String _getFeatureName(PremiumFeatureType feature) {
    switch (feature) {
      case PremiumFeatureType.premiumBibleCommentaries:
        return 'Premium Bible Commentaries';
      case PremiumFeatureType.premiumDevotionals:
        return 'Premium Devotionals';
      case PremiumFeatureType.premiumBibleStudies:
        return 'Premium Bible Studies';
      case PremiumFeatureType.advancedSearch:
        return 'Advanced Bible Search';
      case PremiumFeatureType.offlineMode:
        return 'Offline Mode';
      case PremiumFeatureType.customTitle:
        return 'Custom Title';
      case PremiumFeatureType.profileBadge:
        return 'Profile Badge';
      case PremiumFeatureType.prioritySupport:
        return 'Priority Support';
      case PremiumFeatureType.exclusiveChatRooms:
        return 'Exclusive Chat Rooms';
      case PremiumFeatureType.bibleReadingPlans:
        return 'Bible Reading Plans';
      case PremiumFeatureType.verseComparisons:
        return 'Verse Comparisons';
      case PremiumFeatureType.crossReferences:
        return 'Cross References';
      case PremiumFeatureType.studyNotes:
        return 'Study Notes';
      case PremiumFeatureType.customThemes:
        return 'Custom Themes';
      case PremiumFeatureType.customNotifications:
        return 'Custom Notifications';
      case PremiumFeatureType.adFreeExperience:
        return 'Ad-Free Experience';
      case PremiumFeatureType.blogPosting:
        return 'Blog Posting';
      case PremiumFeatureType.titleSelection:
        return 'Title Selection';
      case PremiumFeatureType.followerAnalytics:
        return 'Follower Analytics';
      case PremiumFeatureType.skipLadder:
        return 'Skip Ladder';
    }
  }

  // Get feature description
  String _getFeatureDescription(PremiumFeatureType feature) {
    switch (feature) {
      case PremiumFeatureType.premiumBibleCommentaries:
        return 'Access to premium Bible commentaries from renowned theologians';
      case PremiumFeatureType.premiumDevotionals:
        return 'Exclusive devotionals to deepen your faith journey';
      case PremiumFeatureType.premiumBibleStudies:
        return 'In-depth Bible study materials and guides';
      case PremiumFeatureType.advancedSearch:
        return 'Advanced search capabilities with filters and options';
      case PremiumFeatureType.offlineMode:
        return 'Download and read the Bible offline without internet';
      case PremiumFeatureType.customTitle:
        return 'Choose a custom title for your profile';
      case PremiumFeatureType.profileBadge:
        return 'Display a premium badge on your profile';
      case PremiumFeatureType.prioritySupport:
        return 'Get priority support from our team';
      case PremiumFeatureType.exclusiveChatRooms:
        return 'Access to exclusive chat rooms for premium members';
      case PremiumFeatureType.bibleReadingPlans:
        return 'Guided Bible reading plans for different durations';
      case PremiumFeatureType.verseComparisons:
        return 'Compare verses across different translations';
      case PremiumFeatureType.crossReferences:
        return 'View cross-references to related verses';
      case PremiumFeatureType.studyNotes:
        return 'Create and save personal study notes';
      case PremiumFeatureType.customThemes:
        return 'Customize the app theme with premium colors';
      case PremiumFeatureType.customNotifications:
        return 'Customize notification sounds and vibrations';
      case PremiumFeatureType.adFreeExperience:
        return 'Remove all advertisements from the app';
      case PremiumFeatureType.blogPosting:
        return 'Post articles on the community blog';
      case PremiumFeatureType.titleSelection:
        return 'Choose from various titles for your role';
      case PremiumFeatureType.followerAnalytics:
        return 'View detailed analytics about your followers';
      case PremiumFeatureType.skipLadder:
        return 'Skip the faith journey ladder and become a Bishop immediately';
    }
  }

  // Get feature icon
  String _getFeatureIcon(PremiumFeatureType feature) {
    switch (feature) {
      case PremiumFeatureType.premiumBibleCommentaries:
        return '📖';
      case PremiumFeatureType.premiumDevotionals:
        return '🙏';
      case PremiumFeatureType.premiumBibleStudies:
        return '🎓';
      case PremiumFeatureType.advancedSearch:
        return '🔍';
      case PremiumFeatureType.offlineMode:
        return '📱';
      case PremiumFeatureType.customTitle:
        return '👑';
      case PremiumFeatureType.profileBadge:
        return '🎖️';
      case PremiumFeatureType.prioritySupport:
        return '⭐';
      case PremiumFeatureType.exclusiveChatRooms:
        return '💬';
      case PremiumFeatureType.bibleReadingPlans:
        return '📅';
      case PremiumFeatureType.verseComparisons:
        return '⚖️';
      case PremiumFeatureType.crossReferences:
        return '🔗';
      case PremiumFeatureType.studyNotes:
        return '📝';
      case PremiumFeatureType.customThemes:
        return '🎨';
      case PremiumFeatureType.customNotifications:
        return '🔔';
      case PremiumFeatureType.adFreeExperience:
        return '🚫';
      case PremiumFeatureType.blogPosting:
        return '✍️';
      case PremiumFeatureType.titleSelection:
        return '👤';
      case PremiumFeatureType.followerAnalytics:
        return '📊';
      case PremiumFeatureType.skipLadder:
        return '⬆️';
    }
  }

  // Get minimum plan for feature
  SubscriptionPlan _getMinimumPlanForFeature(PremiumFeatureType feature) {
    switch (feature) {
      case PremiumFeatureType.advancedSearch:
      case PremiumFeatureType.offlineMode:
      case PremiumFeatureType.customThemes:
      case PremiumFeatureType.customNotifications:
      case PremiumFeatureType.adFreeExperience:
        return SubscriptionPlan.basicMonthly;
      case PremiumFeatureType.premiumBibleCommentaries:
      case PremiumFeatureType.premiumDevotionals:
      case PremiumFeatureType.bibleReadingPlans:
      case PremiumFeatureType.verseComparisons:
      case PremiumFeatureType.crossReferences:
      case PremiumFeatureType.studyNotes:
      case PremiumFeatureType.customTitle:
      case PremiumFeatureType.profileBadge:
      case PremiumFeatureType.prioritySupport:
      case PremiumFeatureType.exclusiveChatRooms:
        return SubscriptionPlan.proMonthly;
      case PremiumFeatureType.blogPosting:
      case PremiumFeatureType.titleSelection:
      case PremiumFeatureType.followerAnalytics:
      case PremiumFeatureType.skipLadder:
        return SubscriptionPlan.bishop;
      default:
        return SubscriptionPlan.free;
    }
  }

  // Get price for product
  Future<String?> getProductPrice(String productId) async {
    final product = await getProductDetails(productId);
    return product?.price;
  }

  // Get all price models
  Future<List<PriceModel>> getPriceModels() async {
    final products = await getAvailableProducts();
    
    return [
      PriceModel(
        plan: SubscriptionPlan.basicMonthly,
        monthlyPrice: double.tryParse(
          products.firstWhere(
            (p) => p.id == basicMonthly,
            orElse: () => null,
          )?.price ?? '4.99',
        ) ?? 4.99,
        yearlyPrice: double.tryParse(
          products.firstWhere(
            (p) => p.id == basicYearly,
            orElse: () => null,
          )?.price ?? '49.99',
        ) ?? 49.99,
        currency: 'USD',
        includedFeatures: [
          PremiumFeatureType.advancedSearch,
          PremiumFeatureType.offlineMode,
          PremiumFeatureType.adFreeExperience,
          PremiumFeatureType.customThemes,
          PremiumFeatureType.customNotifications,
        ],
        description: 'Basic features for dedicated believers',
        isPopular: false,
        isRecommended: false,
      ),
      PriceModel(
        plan: SubscriptionPlan.proMonthly,
        monthlyPrice: double.tryParse(
          products.firstWhere(
            (p) => p.id == proMonthly,
            orElse: () => null,
          )?.price ?? '9.99',
        ) ?? 9.99,
        yearlyPrice: double.tryParse(
          products.firstWhere(
            (p) => p.id == proYearly,
            orElse: () => null,
          )?.price ?? '99.99',
        ) ?? 99.99,
        currency: 'USD',
        includedFeatures: [
          PremiumFeatureType.advancedSearch,
          PremiumFeatureType.offlineMode,
          PremiumFeatureType.adFreeExperience,
          PremiumFeatureType.premiumBibleCommentaries,
          PremiumFeatureType.premiumDevotionals,
          PremiumFeatureType.bibleReadingPlans,
          PremiumFeatureType.verseComparisons,
          PremiumFeatureType.crossReferences,
          PremiumFeatureType.studyNotes,
          PremiumFeatureType.customTitle,
          PremiumFeatureType.profileBadge,
          PremiumFeatureType.prioritySupport,
          PremiumFeatureType.exclusiveChatRooms,
          PremiumFeatureType.customThemes,
          PremiumFeatureType.customNotifications,
        ],
        description: 'All premium features for serious students of the Word',
        badge: 'Most Popular',
        isPopular: true,
        isRecommended: true,
      ),
      PriceModel(
        plan: SubscriptionPlan.bishop,
        monthlyPrice: 0,
        yearlyPrice: double.tryParse(
          products.firstWhere(
            (p) => p.id == bishopLadderSkip,
            orElse: () => null,
          )?.price ?? '49.99',
        ) ?? 49.99,
        currency: 'USD',
        includedFeatures: PremiumFeatureType.values.toList(),
        description: 'Become a Bishop immediately with all premium features',
        badge: 'One-Time Payment',
        isPopular: false,
        isRecommended: false,
      ),
    ];
  }

  // Get ladder skip configuration
  Future<LadderSkipConfig> getLadderSkipConfig() async {
    return LadderSkipConfig(
      fromRole: UserRole.shepherd.name,
      toRole: UserRole.bishop.name,
      price: double.tryParse(
        await getProductPrice(bishopLadderSkip) ?? '49.99',
      ) ?? 49.99,
      currency: 'USD',
      description: 'Skip the faith journey ladder and become a Bishop immediately with all premium features',
      includedFeatures: [
        'Blog posting access',
        'Custom title selection',
        'Follower analytics',
        'All premium features',
      ],
      isAvailable: true,
    );
  }

  // Process ladder skip purchase (alternative method)
  Future<void> processLadderSkipPurchase(String userId) async {
    // This is called when user clicks "Skip Ladder" button
    // In production, this would initiate the purchase flow
    
    await purchaseProduct(bishopLadderSkip);
  }

  // Check if user can skip ladder
  Future<bool> canSkipLadder(String userId) async {
    final user = await _databaseService.getUser(userId);
    if (user == null) return false;
    
    // User must have paid for ladder skip
    return user.hasPaidToSkipLadder || user.role == UserRole.bishop;
  }

  // Get premium content
  Future<List<PremiumContent>> getPremiumContent({
    required String userId,
    required PremiumFeatureType featureType,
  }) async {
    // Check if user has access
    final hasAccess = await hasAccessToFeature(userId, featureType);
    if (!hasAccess) return [];
    
    // Get content from database
    final snapshot = await _databaseService._firestore
        .collection('premium_content')
        .where('featureType', isEqualTo: featureType.name)
        .get();
    
    return snapshot.docs
        .map((doc) => PremiumContent.fromJson(doc.data()))
        .toList();
  }
}
