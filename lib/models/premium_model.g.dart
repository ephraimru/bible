// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'premium_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PremiumFeature _$PremiumFeatureFromJson(Map<String, dynamic> json) =>
    _PremiumFeature(
      id: $enumDecode(_$PremiumFeatureTypeEnumMap, json['id']),
      name: json['name'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
      minimumPlan: $enumDecode(_$SubscriptionPlanEnumMap, json['minimumPlan']),
      isAvailable: json['isAvailable'] as bool? ?? false,
      isUnlocked: json['isUnlocked'] as bool? ?? false,
      unlockedAt: json['unlockedAt'] == null
          ? null
          : DateTime.parse(json['unlockedAt'] as String),
      category: json['category'] as String?,
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PremiumFeatureToJson(_PremiumFeature instance) =>
    <String, dynamic>{
      'id': _$PremiumFeatureTypeEnumMap[instance.id]!,
      'name': instance.name,
      'description': instance.description,
      'icon': instance.icon,
      'minimumPlan': _$SubscriptionPlanEnumMap[instance.minimumPlan]!,
      'isAvailable': instance.isAvailable,
      'isUnlocked': instance.isUnlocked,
      'unlockedAt': instance.unlockedAt?.toIso8601String(),
      'category': instance.category,
      'price': instance.price,
    };

const _$PremiumFeatureTypeEnumMap = {
  PremiumFeatureType.premiumBibleCommentaries: 'premiumBibleCommentaries',
  PremiumFeatureType.premiumDevotionals: 'premiumDevotionals',
  PremiumFeatureType.premiumBibleStudies: 'premiumBibleStudies',
  PremiumFeatureType.advancedSearch: 'advancedSearch',
  PremiumFeatureType.offlineMode: 'offlineMode',
  PremiumFeatureType.customTitle: 'customTitle',
  PremiumFeatureType.profileBadge: 'profileBadge',
  PremiumFeatureType.prioritySupport: 'prioritySupport',
  PremiumFeatureType.exclusiveChatRooms: 'exclusiveChatRooms',
  PremiumFeatureType.bibleReadingPlans: 'bibleReadingPlans',
  PremiumFeatureType.verseComparisons: 'verseComparisons',
  PremiumFeatureType.crossReferences: 'crossReferences',
  PremiumFeatureType.studyNotes: 'studyNotes',
  PremiumFeatureType.customThemes: 'customThemes',
  PremiumFeatureType.customNotifications: 'customNotifications',
  PremiumFeatureType.adFreeExperience: 'adFreeExperience',
  PremiumFeatureType.blogPosting: 'blogPosting',
  PremiumFeatureType.titleSelection: 'titleSelection',
  PremiumFeatureType.followerAnalytics: 'followerAnalytics',
  PremiumFeatureType.skipLadder: 'skipLadder',
};

const _$SubscriptionPlanEnumMap = {
  SubscriptionPlan.free: 'free',
  SubscriptionPlan.basicMonthly: 'basicMonthly',
  SubscriptionPlan.basicYearly: 'basicYearly',
  SubscriptionPlan.proMonthly: 'proMonthly',
  SubscriptionPlan.proYearly: 'proYearly',
  SubscriptionPlan.bishop: 'bishop',
};

_Subscription _$SubscriptionFromJson(Map<String, dynamic> json) =>
    _Subscription(
      id: json['id'] as String,
      userId: json['userId'] as String,
      plan: $enumDecode(_$SubscriptionPlanEnumMap, json['plan']),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      status:
          $enumDecodeNullable(_$PaymentStatusEnumMap, json['status']) ??
          PaymentStatus.completed,
      paymentMethod: $enumDecodeNullable(
        _$PaymentMethodEnumMap,
        json['paymentMethod'],
      ),
      amount: (json['amount'] as num?)?.toDouble(),
      transactionId: json['transactionId'] as String?,
      paymentReference: json['paymentReference'] as String?,
      autoRenew: json['autoRenew'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? false,
      isCancelled: json['isCancelled'] as bool? ?? false,
      cancelledAt: json['cancelledAt'] == null
          ? null
          : DateTime.parse(json['cancelledAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      features:
          (json['features'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$SubscriptionToJson(_Subscription instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'plan': _$SubscriptionPlanEnumMap[instance.plan]!,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'status': _$PaymentStatusEnumMap[instance.status]!,
      'paymentMethod': _$PaymentMethodEnumMap[instance.paymentMethod],
      'amount': instance.amount,
      'transactionId': instance.transactionId,
      'paymentReference': instance.paymentReference,
      'autoRenew': instance.autoRenew,
      'isActive': instance.isActive,
      'isCancelled': instance.isCancelled,
      'cancelledAt': instance.cancelledAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'features': instance.features,
      'metadata': instance.metadata,
    };

const _$PaymentStatusEnumMap = {
  PaymentStatus.pending: 'pending',
  PaymentStatus.completed: 'completed',
  PaymentStatus.failed: 'failed',
  PaymentStatus.refunded: 'refunded',
  PaymentStatus.cancelled: 'cancelled',
};

const _$PaymentMethodEnumMap = {
  PaymentMethod.creditCard: 'creditCard',
  PaymentMethod.paypal: 'paypal',
  PaymentMethod.mobileMoney: 'mobileMoney',
  PaymentMethod.bankTransfer: 'bankTransfer',
  PaymentMethod.crypto: 'crypto',
};

_Payment _$PaymentFromJson(Map<String, dynamic> json) => _Payment(
  id: json['id'] as String,
  userId: json['userId'] as String,
  amount: (json['amount'] as num).toDouble(),
  currency: json['currency'] as String,
  method: $enumDecode(_$PaymentMethodEnumMap, json['method']),
  status: $enumDecode(_$PaymentStatusEnumMap, json['status']),
  transactionId: json['transactionId'] as String?,
  reference: json['reference'] as String?,
  description: json['description'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  completedAt: json['completedAt'] == null
      ? null
      : DateTime.parse(json['completedAt'] as String),
  metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
  isForLadderSkip: json['isForLadderSkip'] as bool? ?? false,
  ladderSkipFromRole: json['ladderSkipFromRole'] as String?,
  ladderSkipToRole: json['ladderSkipToRole'] as String?,
);

Map<String, dynamic> _$PaymentToJson(_Payment instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'amount': instance.amount,
  'currency': instance.currency,
  'method': _$PaymentMethodEnumMap[instance.method]!,
  'status': _$PaymentStatusEnumMap[instance.status]!,
  'transactionId': instance.transactionId,
  'reference': instance.reference,
  'description': instance.description,
  'createdAt': instance.createdAt?.toIso8601String(),
  'completedAt': instance.completedAt?.toIso8601String(),
  'metadata': instance.metadata,
  'isForLadderSkip': instance.isForLadderSkip,
  'ladderSkipFromRole': instance.ladderSkipFromRole,
  'ladderSkipToRole': instance.ladderSkipToRole,
};

_PremiumContent _$PremiumContentFromJson(Map<String, dynamic> json) =>
    _PremiumContent(
      id: json['id'] as String,
      featureType: $enumDecode(
        _$PremiumFeatureTypeEnumMap,
        json['featureType'],
      ),
      title: json['title'] as String,
      content: json['content'] as String,
      minimumPlan: $enumDecode(_$SubscriptionPlanEnumMap, json['minimumPlan']),
      author: json['author'] as String?,
      imageUrl: json['imageUrl'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      views: (json['views'] as num?)?.toInt() ?? 0,
      downloads: (json['downloads'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      isFeatured: json['isFeatured'] as bool? ?? false,
    );

Map<String, dynamic> _$PremiumContentToJson(_PremiumContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'featureType': _$PremiumFeatureTypeEnumMap[instance.featureType]!,
      'title': instance.title,
      'content': instance.content,
      'minimumPlan': _$SubscriptionPlanEnumMap[instance.minimumPlan]!,
      'author': instance.author,
      'imageUrl': instance.imageUrl,
      'tags': instance.tags,
      'views': instance.views,
      'downloads': instance.downloads,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'isFeatured': instance.isFeatured,
    };

_PriceModel _$PriceModelFromJson(Map<String, dynamic> json) => _PriceModel(
  plan: $enumDecode(_$SubscriptionPlanEnumMap, json['plan']),
  monthlyPrice: (json['monthlyPrice'] as num).toDouble(),
  yearlyPrice: (json['yearlyPrice'] as num).toDouble(),
  currency: json['currency'] as String,
  includedFeatures:
      (json['includedFeatures'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$PremiumFeatureTypeEnumMap, e))
          .toList() ??
      const [],
  description: json['description'] as String?,
  badge: json['badge'] as String?,
  isPopular: json['isPopular'] as bool? ?? false,
  isRecommended: json['isRecommended'] as bool? ?? false,
);

Map<String, dynamic> _$PriceModelToJson(_PriceModel instance) =>
    <String, dynamic>{
      'plan': _$SubscriptionPlanEnumMap[instance.plan]!,
      'monthlyPrice': instance.monthlyPrice,
      'yearlyPrice': instance.yearlyPrice,
      'currency': instance.currency,
      'includedFeatures': instance.includedFeatures
          .map((e) => _$PremiumFeatureTypeEnumMap[e]!)
          .toList(),
      'description': instance.description,
      'badge': instance.badge,
      'isPopular': instance.isPopular,
      'isRecommended': instance.isRecommended,
    };

_LadderSkipConfig _$LadderSkipConfigFromJson(Map<String, dynamic> json) =>
    _LadderSkipConfig(
      fromRole: json['fromRole'] as String,
      toRole: json['toRole'] as String,
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String,
      description: json['description'] as String,
      includedFeatures:
          (json['includedFeatures'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isAvailable: json['isAvailable'] as bool? ?? false,
    );

Map<String, dynamic> _$LadderSkipConfigToJson(_LadderSkipConfig instance) =>
    <String, dynamic>{
      'fromRole': instance.fromRole,
      'toRole': instance.toRole,
      'price': instance.price,
      'currency': instance.currency,
      'description': instance.description,
      'includedFeatures': instance.includedFeatures,
      'isAvailable': instance.isAvailable,
    };
