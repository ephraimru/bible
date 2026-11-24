
import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_model.dart';

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
abstract class PremiumFeature with _$PremiumFeature {
  const factory PremiumFeature({
    required PremiumFeatureType id,
    required String name,
    required String description,
    required String icon,
    required PremiumTier minimumPlan,
    @Default(false) bool isAvailable,
    @Default(false) bool isUnlocked,
    @Default(null) DateTime? unlockedAt,
    String? category,
    double? price,
  }) = _PremiumFeature;

  factory PremiumFeature.fromJson(Map<String, dynamic> json) =>
      _$PremiumFeatureFromJson(json);

}

/// Subscription model
@freezed
abstract class Subscription with _$Subscription {
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

}

/// Payment model
@freezed
abstract class Payment with _$Payment {
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

}

/// Premium content model
@freezed
abstract class PremiumContent with _$PremiumContent {
  const factory PremiumContent({
    required String id,
    required PremiumFeatureType featureType,
    required String title,
    required String content,
    required PremiumTier minimumPlan,
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

}

/// Price model for different plans
@freezed
abstract class PriceModel with _$PriceModel {
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
abstract class LadderSkipConfig with _$LadderSkipConfig {
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
