
import 'package:freezed_annotation/freezed_annotation.dart';

part 'premium_model.freezed.dart';
part 'premium_model.g.dart';

/// Premium feature type
enum PremiumFeatureType {
  // Content features
  premiumBibleCommentaries,
  premiumDevotionals,
  premiumBibleStudies,
  advancedSearch,
  offlineMode,
  
  // Social features
  customTitle,
  profileBadge,
  prioritySupport,
  exclusiveChatRooms,
  
  // Learning features
  bibleReadingPlans,
  verseComparisons,
  crossReferences,
  studyNotes,
  
  // Customization
  customThemes,
  customNotifications,
  adFreeExperience,
  
  // Bishop features
  blogPosting,
  titleSelection,
  followerAnalytics,
  
  // Special
  skipLadder,
}

/// Subscription plan
enum SubscriptionPlan {
  free,
  basicMonthly,
  basicYearly,
  proMonthly,
  proYearly,
  bishop,
}

extension SubscriptionPlanExtension on SubscriptionPlan {
  String get displayName {
    switch (this) {
      case SubscriptionPlan.free:
        return 'Free';
      case SubscriptionPlan.basicMonthly:
        return 'Basic Monthly';
      case SubscriptionPlan.basicYearly:
        return 'Basic Yearly';
      case SubscriptionPlan.proMonthly:
        return 'Pro Monthly';
      case SubscriptionPlan.proYearly:
        return 'Pro Yearly';
      case SubscriptionPlan.bishop:
        return 'Bishop';
    }
  }
}

/// Payment method
enum PaymentMethod {
  creditCard,
  paypal,
  mobileMoney,
  bankTransfer,
  crypto,
}

/// Payment status
enum PaymentStatus {
  pending,
  completed,
  failed,
  refunded,
  cancelled,
}

@freezed
class PremiumFeature with _$PremiumFeature {
  const factory PremiumFeature({
    required PremiumFeatureType id,
    required String name,
    required String description,
    required String icon,
    required SubscriptionPlan minimumPlan,
    @Default(false) bool isAvailable,
    @Default(false) bool isUnlocked,
    @Default(null) DateTime? unlockedAt,
    String? category,
    double? price,
  }) = _PremiumFeature;

  factory PremiumFeature.fromJson(Map<String, dynamic> json) =>
      _$PremiumFeatureFromJson(json);

  factory PremiumFeature.
    final data = doc.data() as Map<String, dynamic>;
    return PremiumFeature.fromJson({...data, 'id': doc.id});
  }
}

/// Subscription model
@freezed
class Subscription with _$Subscription {
  const factory Subscription({
    required String id,
    required String userId,
    required SubscriptionPlan plan,
    required DateTime startDate,
    required DateTime endDate,
    @Default(PaymentStatus.completed) PaymentStatus status,
    PaymentMethod? paymentMethod,
    double? amount,
    String? transactionId,
    String? paymentReference,
    @Default(false) bool autoRenew,
    @Default(false) bool isActive,
    @Default(false) bool isCancelled,
    @Default(null) DateTime? cancelledAt,
    @Default(null) DateTime? createdAt,
    @Default(null) DateTime? updatedAt,
    @Default([]) List<String> features,
    @Default({}) Map<String, dynamic> metadata,
  }) = _Subscription;

  factory Subscription.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionFromJson(json);

  factory Subscription.
    final data = doc.data() as Map<String, dynamic>;
    return Subscription.fromJson({...data, 'id': doc.id});
  }
}

/// Payment model
@freezed
class Payment with _$Payment {
  const factory Payment({
    required String id,
    required String userId,
    required double amount,
    required String currency,
    required PaymentMethod method,
    required PaymentStatus status,
    String? transactionId,
    String? reference,
    String? description,
    @Default(null) DateTime? createdAt,
    @Default(null) DateTime? completedAt,
    @Default({}) Map<String, dynamic> metadata,
    // For ladder skip
    @Default(false) bool isForLadderSkip,
    String? ladderSkipFromRole,
    String? ladderSkipToRole,
  }) = _Payment;

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);

  factory Payment.
    final data = doc.data() as Map<String, dynamic>;
    return Payment.fromJson({...data, 'id': doc.id});
  }
}

/// Premium content model
@freezed
class PremiumContent with _$PremiumContent {
  const factory PremiumContent({
    required String id,
    required PremiumFeatureType featureType,
    required String title,
    required String content,
    required SubscriptionPlan minimumPlan,
    String? author,
    String? imageUrl,
    @Default([]) List<String> tags,
    @Default(0) int views,
    @Default(0) int downloads,
    @Default(null) DateTime? createdAt,
    @Default(null) DateTime? updatedAt,
    @Default(false) bool isFeatured,
  }) = _PremiumContent;

  factory PremiumContent.fromJson(Map<String, dynamic> json) =>
      _$PremiumContentFromJson(json);

  factory PremiumContent.
    final data = doc.data() as Map<String, dynamic>;
    return PremiumContent.fromJson({...data, 'id': doc.id});
  }
}

/// Price model for different plans
@freezed
class PriceModel with _$PriceModel {
  const factory PriceModel({
    required SubscriptionPlan plan,
    required double monthlyPrice,
    required double yearlyPrice,
    required String currency,
    @Default([]) List<PremiumFeatureType> includedFeatures,
    String? description,
    String? badge,
    @Default(false) bool isPopular,
    @Default(false) bool isRecommended,
  }) = _PriceModel;

  factory PriceModel.fromJson(Map<String, dynamic> json) =>
      _$PriceModelFromJson(json);
}

/// Ladder skip payment configuration
@freezed
class LadderSkipConfig with _$LadderSkipConfig {
  const factory LadderSkipConfig({
    required String fromRole,
    required String toRole,
    required double price,
    required String currency,
    required String description,
    @Default([]) List<String> includedFeatures,
    @Default(false) bool isAvailable,
  }) = _LadderSkipConfig;

  factory LadderSkipConfig.fromJson(Map<String, dynamic> json) =>
      _$LadderSkipConfigFromJson(json);
}
