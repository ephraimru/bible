// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'premium_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PremiumFeature {

 PremiumFeatureType get id; String get name; String get description; String get icon; PremiumTier get minimumPlan; bool get isAvailable; bool get isUnlocked; DateTime? get unlockedAt; String? get category; double? get price;
/// Create a copy of PremiumFeature
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PremiumFeatureCopyWith<PremiumFeature> get copyWith => _$PremiumFeatureCopyWithImpl<PremiumFeature>(this as PremiumFeature, _$identity);

  /// Serializes this PremiumFeature to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PremiumFeature&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.minimumPlan, minimumPlan) || other.minimumPlan == minimumPlan)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable)&&(identical(other.isUnlocked, isUnlocked) || other.isUnlocked == isUnlocked)&&(identical(other.unlockedAt, unlockedAt) || other.unlockedAt == unlockedAt)&&(identical(other.category, category) || other.category == category)&&(identical(other.price, price) || other.price == price));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,icon,minimumPlan,isAvailable,isUnlocked,unlockedAt,category,price);

@override
String toString() {
  return 'PremiumFeature(id: $id, name: $name, description: $description, icon: $icon, minimumPlan: $minimumPlan, isAvailable: $isAvailable, isUnlocked: $isUnlocked, unlockedAt: $unlockedAt, category: $category, price: $price)';
}


}

/// @nodoc
abstract mixin class $PremiumFeatureCopyWith<$Res>  {
  factory $PremiumFeatureCopyWith(PremiumFeature value, $Res Function(PremiumFeature) _then) = _$PremiumFeatureCopyWithImpl;
@useResult
$Res call({
 PremiumFeatureType id, String name, String description, String icon, PremiumTier minimumPlan, bool isAvailable, bool isUnlocked, DateTime? unlockedAt, String? category, double? price
});




}
/// @nodoc
class _$PremiumFeatureCopyWithImpl<$Res>
    implements $PremiumFeatureCopyWith<$Res> {
  _$PremiumFeatureCopyWithImpl(this._self, this._then);

  final PremiumFeature _self;
  final $Res Function(PremiumFeature) _then;

/// Create a copy of PremiumFeature
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? icon = null,Object? minimumPlan = null,Object? isAvailable = null,Object? isUnlocked = null,Object? unlockedAt = freezed,Object? category = freezed,Object? price = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as PremiumFeatureType,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,minimumPlan: null == minimumPlan ? _self.minimumPlan : minimumPlan // ignore: cast_nullable_to_non_nullable
as PremiumTier,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,isUnlocked: null == isUnlocked ? _self.isUnlocked : isUnlocked // ignore: cast_nullable_to_non_nullable
as bool,unlockedAt: freezed == unlockedAt ? _self.unlockedAt : unlockedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [PremiumFeature].
extension PremiumFeaturePatterns on PremiumFeature {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PremiumFeature value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PremiumFeature() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PremiumFeature value)  $default,){
final _that = this;
switch (_that) {
case _PremiumFeature():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PremiumFeature value)?  $default,){
final _that = this;
switch (_that) {
case _PremiumFeature() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PremiumFeatureType id,  String name,  String description,  String icon,  PremiumTier minimumPlan,  bool isAvailable,  bool isUnlocked,  DateTime? unlockedAt,  String? category,  double? price)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PremiumFeature() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.icon,_that.minimumPlan,_that.isAvailable,_that.isUnlocked,_that.unlockedAt,_that.category,_that.price);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PremiumFeatureType id,  String name,  String description,  String icon,  PremiumTier minimumPlan,  bool isAvailable,  bool isUnlocked,  DateTime? unlockedAt,  String? category,  double? price)  $default,) {final _that = this;
switch (_that) {
case _PremiumFeature():
return $default(_that.id,_that.name,_that.description,_that.icon,_that.minimumPlan,_that.isAvailable,_that.isUnlocked,_that.unlockedAt,_that.category,_that.price);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PremiumFeatureType id,  String name,  String description,  String icon,  PremiumTier minimumPlan,  bool isAvailable,  bool isUnlocked,  DateTime? unlockedAt,  String? category,  double? price)?  $default,) {final _that = this;
switch (_that) {
case _PremiumFeature() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.icon,_that.minimumPlan,_that.isAvailable,_that.isUnlocked,_that.unlockedAt,_that.category,_that.price);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PremiumFeature implements PremiumFeature {
  const _PremiumFeature({required this.id, required this.name, required this.description, required this.icon, required this.minimumPlan, this.isAvailable = false, this.isUnlocked = false, this.unlockedAt = null, this.category, this.price});
  factory _PremiumFeature.fromJson(Map<String, dynamic> json) => _$PremiumFeatureFromJson(json);

@override final  PremiumFeatureType id;
@override final  String name;
@override final  String description;
@override final  String icon;
@override final  PremiumTier minimumPlan;
@override@JsonKey() final  bool isAvailable;
@override@JsonKey() final  bool isUnlocked;
@override@JsonKey() final  DateTime? unlockedAt;
@override final  String? category;
@override final  double? price;

/// Create a copy of PremiumFeature
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PremiumFeatureCopyWith<_PremiumFeature> get copyWith => __$PremiumFeatureCopyWithImpl<_PremiumFeature>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PremiumFeatureToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PremiumFeature&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.minimumPlan, minimumPlan) || other.minimumPlan == minimumPlan)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable)&&(identical(other.isUnlocked, isUnlocked) || other.isUnlocked == isUnlocked)&&(identical(other.unlockedAt, unlockedAt) || other.unlockedAt == unlockedAt)&&(identical(other.category, category) || other.category == category)&&(identical(other.price, price) || other.price == price));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,icon,minimumPlan,isAvailable,isUnlocked,unlockedAt,category,price);

@override
String toString() {
  return 'PremiumFeature(id: $id, name: $name, description: $description, icon: $icon, minimumPlan: $minimumPlan, isAvailable: $isAvailable, isUnlocked: $isUnlocked, unlockedAt: $unlockedAt, category: $category, price: $price)';
}


}

/// @nodoc
abstract mixin class _$PremiumFeatureCopyWith<$Res> implements $PremiumFeatureCopyWith<$Res> {
  factory _$PremiumFeatureCopyWith(_PremiumFeature value, $Res Function(_PremiumFeature) _then) = __$PremiumFeatureCopyWithImpl;
@override @useResult
$Res call({
 PremiumFeatureType id, String name, String description, String icon, PremiumTier minimumPlan, bool isAvailable, bool isUnlocked, DateTime? unlockedAt, String? category, double? price
});




}
/// @nodoc
class __$PremiumFeatureCopyWithImpl<$Res>
    implements _$PremiumFeatureCopyWith<$Res> {
  __$PremiumFeatureCopyWithImpl(this._self, this._then);

  final _PremiumFeature _self;
  final $Res Function(_PremiumFeature) _then;

/// Create a copy of PremiumFeature
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? icon = null,Object? minimumPlan = null,Object? isAvailable = null,Object? isUnlocked = null,Object? unlockedAt = freezed,Object? category = freezed,Object? price = freezed,}) {
  return _then(_PremiumFeature(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as PremiumFeatureType,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,minimumPlan: null == minimumPlan ? _self.minimumPlan : minimumPlan // ignore: cast_nullable_to_non_nullable
as PremiumTier,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,isUnlocked: null == isUnlocked ? _self.isUnlocked : isUnlocked // ignore: cast_nullable_to_non_nullable
as bool,unlockedAt: freezed == unlockedAt ? _self.unlockedAt : unlockedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$Subscription {

 String get id; String get userId; SubscriptionPlan get plan; DateTime get startDate; DateTime get endDate; PaymentStatus get status; PaymentMethod? get paymentMethod; double? get amount; String? get transactionId; String? get paymentReference; bool get autoRenew; bool get isActive; bool get isCancelled; DateTime? get cancelledAt; DateTime? get createdAt; DateTime? get updatedAt; List<String> get features; Map<String, dynamic> get metadata;
/// Create a copy of Subscription
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionCopyWith<Subscription> get copyWith => _$SubscriptionCopyWithImpl<Subscription>(this as Subscription, _$identity);

  /// Serializes this Subscription to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Subscription&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.paymentReference, paymentReference) || other.paymentReference == paymentReference)&&(identical(other.autoRenew, autoRenew) || other.autoRenew == autoRenew)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isCancelled, isCancelled) || other.isCancelled == isCancelled)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.features, features)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,plan,startDate,endDate,status,paymentMethod,amount,transactionId,paymentReference,autoRenew,isActive,isCancelled,cancelledAt,createdAt,updatedAt,const DeepCollectionEquality().hash(features),const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'Subscription(id: $id, userId: $userId, plan: $plan, startDate: $startDate, endDate: $endDate, status: $status, paymentMethod: $paymentMethod, amount: $amount, transactionId: $transactionId, paymentReference: $paymentReference, autoRenew: $autoRenew, isActive: $isActive, isCancelled: $isCancelled, cancelledAt: $cancelledAt, createdAt: $createdAt, updatedAt: $updatedAt, features: $features, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $SubscriptionCopyWith<$Res>  {
  factory $SubscriptionCopyWith(Subscription value, $Res Function(Subscription) _then) = _$SubscriptionCopyWithImpl;
@useResult
$Res call({
 String id, String userId, SubscriptionPlan plan, DateTime startDate, DateTime endDate, PaymentStatus status, PaymentMethod? paymentMethod, double? amount, String? transactionId, String? paymentReference, bool autoRenew, bool isActive, bool isCancelled, DateTime? cancelledAt, DateTime? createdAt, DateTime? updatedAt, List<String> features, Map<String, dynamic> metadata
});




}
/// @nodoc
class _$SubscriptionCopyWithImpl<$Res>
    implements $SubscriptionCopyWith<$Res> {
  _$SubscriptionCopyWithImpl(this._self, this._then);

  final Subscription _self;
  final $Res Function(Subscription) _then;

/// Create a copy of Subscription
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? plan = null,Object? startDate = null,Object? endDate = null,Object? status = null,Object? paymentMethod = freezed,Object? amount = freezed,Object? transactionId = freezed,Object? paymentReference = freezed,Object? autoRenew = null,Object? isActive = null,Object? isCancelled = null,Object? cancelledAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? features = null,Object? metadata = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as SubscriptionPlan,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double?,transactionId: freezed == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String?,paymentReference: freezed == paymentReference ? _self.paymentReference : paymentReference // ignore: cast_nullable_to_non_nullable
as String?,autoRenew: null == autoRenew ? _self.autoRenew : autoRenew // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isCancelled: null == isCancelled ? _self.isCancelled : isCancelled // ignore: cast_nullable_to_non_nullable
as bool,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,features: null == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as List<String>,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [Subscription].
extension SubscriptionPatterns on Subscription {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Subscription value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Subscription() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Subscription value)  $default,){
final _that = this;
switch (_that) {
case _Subscription():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Subscription value)?  $default,){
final _that = this;
switch (_that) {
case _Subscription() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  SubscriptionPlan plan,  DateTime startDate,  DateTime endDate,  PaymentStatus status,  PaymentMethod? paymentMethod,  double? amount,  String? transactionId,  String? paymentReference,  bool autoRenew,  bool isActive,  bool isCancelled,  DateTime? cancelledAt,  DateTime? createdAt,  DateTime? updatedAt,  List<String> features,  Map<String, dynamic> metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Subscription() when $default != null:
return $default(_that.id,_that.userId,_that.plan,_that.startDate,_that.endDate,_that.status,_that.paymentMethod,_that.amount,_that.transactionId,_that.paymentReference,_that.autoRenew,_that.isActive,_that.isCancelled,_that.cancelledAt,_that.createdAt,_that.updatedAt,_that.features,_that.metadata);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  SubscriptionPlan plan,  DateTime startDate,  DateTime endDate,  PaymentStatus status,  PaymentMethod? paymentMethod,  double? amount,  String? transactionId,  String? paymentReference,  bool autoRenew,  bool isActive,  bool isCancelled,  DateTime? cancelledAt,  DateTime? createdAt,  DateTime? updatedAt,  List<String> features,  Map<String, dynamic> metadata)  $default,) {final _that = this;
switch (_that) {
case _Subscription():
return $default(_that.id,_that.userId,_that.plan,_that.startDate,_that.endDate,_that.status,_that.paymentMethod,_that.amount,_that.transactionId,_that.paymentReference,_that.autoRenew,_that.isActive,_that.isCancelled,_that.cancelledAt,_that.createdAt,_that.updatedAt,_that.features,_that.metadata);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  SubscriptionPlan plan,  DateTime startDate,  DateTime endDate,  PaymentStatus status,  PaymentMethod? paymentMethod,  double? amount,  String? transactionId,  String? paymentReference,  bool autoRenew,  bool isActive,  bool isCancelled,  DateTime? cancelledAt,  DateTime? createdAt,  DateTime? updatedAt,  List<String> features,  Map<String, dynamic> metadata)?  $default,) {final _that = this;
switch (_that) {
case _Subscription() when $default != null:
return $default(_that.id,_that.userId,_that.plan,_that.startDate,_that.endDate,_that.status,_that.paymentMethod,_that.amount,_that.transactionId,_that.paymentReference,_that.autoRenew,_that.isActive,_that.isCancelled,_that.cancelledAt,_that.createdAt,_that.updatedAt,_that.features,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Subscription implements Subscription {
  const _Subscription({required this.id, required this.userId, required this.plan, required this.startDate, required this.endDate, this.status = PaymentStatus.completed, this.paymentMethod, this.amount, this.transactionId, this.paymentReference, this.autoRenew = false, this.isActive = false, this.isCancelled = false, this.cancelledAt = null, this.createdAt = null, this.updatedAt = null, final  List<String> features = const [], final  Map<String, dynamic> metadata = const {}}): _features = features,_metadata = metadata;
  factory _Subscription.fromJson(Map<String, dynamic> json) => _$SubscriptionFromJson(json);

@override final  String id;
@override final  String userId;
@override final  SubscriptionPlan plan;
@override final  DateTime startDate;
@override final  DateTime endDate;
@override@JsonKey() final  PaymentStatus status;
@override final  PaymentMethod? paymentMethod;
@override final  double? amount;
@override final  String? transactionId;
@override final  String? paymentReference;
@override@JsonKey() final  bool autoRenew;
@override@JsonKey() final  bool isActive;
@override@JsonKey() final  bool isCancelled;
@override@JsonKey() final  DateTime? cancelledAt;
@override@JsonKey() final  DateTime? createdAt;
@override@JsonKey() final  DateTime? updatedAt;
 final  List<String> _features;
@override@JsonKey() List<String> get features {
  if (_features is EqualUnmodifiableListView) return _features;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_features);
}

 final  Map<String, dynamic> _metadata;
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}


/// Create a copy of Subscription
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionCopyWith<_Subscription> get copyWith => __$SubscriptionCopyWithImpl<_Subscription>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Subscription&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.paymentReference, paymentReference) || other.paymentReference == paymentReference)&&(identical(other.autoRenew, autoRenew) || other.autoRenew == autoRenew)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.isCancelled, isCancelled) || other.isCancelled == isCancelled)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._features, _features)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,plan,startDate,endDate,status,paymentMethod,amount,transactionId,paymentReference,autoRenew,isActive,isCancelled,cancelledAt,createdAt,updatedAt,const DeepCollectionEquality().hash(_features),const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'Subscription(id: $id, userId: $userId, plan: $plan, startDate: $startDate, endDate: $endDate, status: $status, paymentMethod: $paymentMethod, amount: $amount, transactionId: $transactionId, paymentReference: $paymentReference, autoRenew: $autoRenew, isActive: $isActive, isCancelled: $isCancelled, cancelledAt: $cancelledAt, createdAt: $createdAt, updatedAt: $updatedAt, features: $features, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionCopyWith<$Res> implements $SubscriptionCopyWith<$Res> {
  factory _$SubscriptionCopyWith(_Subscription value, $Res Function(_Subscription) _then) = __$SubscriptionCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, SubscriptionPlan plan, DateTime startDate, DateTime endDate, PaymentStatus status, PaymentMethod? paymentMethod, double? amount, String? transactionId, String? paymentReference, bool autoRenew, bool isActive, bool isCancelled, DateTime? cancelledAt, DateTime? createdAt, DateTime? updatedAt, List<String> features, Map<String, dynamic> metadata
});




}
/// @nodoc
class __$SubscriptionCopyWithImpl<$Res>
    implements _$SubscriptionCopyWith<$Res> {
  __$SubscriptionCopyWithImpl(this._self, this._then);

  final _Subscription _self;
  final $Res Function(_Subscription) _then;

/// Create a copy of Subscription
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? plan = null,Object? startDate = null,Object? endDate = null,Object? status = null,Object? paymentMethod = freezed,Object? amount = freezed,Object? transactionId = freezed,Object? paymentReference = freezed,Object? autoRenew = null,Object? isActive = null,Object? isCancelled = null,Object? cancelledAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? features = null,Object? metadata = null,}) {
  return _then(_Subscription(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as SubscriptionPlan,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double?,transactionId: freezed == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String?,paymentReference: freezed == paymentReference ? _self.paymentReference : paymentReference // ignore: cast_nullable_to_non_nullable
as String?,autoRenew: null == autoRenew ? _self.autoRenew : autoRenew // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,isCancelled: null == isCancelled ? _self.isCancelled : isCancelled // ignore: cast_nullable_to_non_nullable
as bool,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,features: null == features ? _self._features : features // ignore: cast_nullable_to_non_nullable
as List<String>,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}


/// @nodoc
mixin _$Payment {

 String get id; String get userId; double get amount; String get currency; PaymentMethod get method; PaymentStatus get status; String? get transactionId; String? get reference; String? get description; DateTime? get createdAt; DateTime? get completedAt; Map<String, dynamic> get metadata;// For ladder skip
 bool get isForLadderSkip; String? get ladderSkipFromRole; String? get ladderSkipToRole;
/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentCopyWith<Payment> get copyWith => _$PaymentCopyWithImpl<Payment>(this as Payment, _$identity);

  /// Serializes this Payment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Payment&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.method, method) || other.method == method)&&(identical(other.status, status) || other.status == status)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.isForLadderSkip, isForLadderSkip) || other.isForLadderSkip == isForLadderSkip)&&(identical(other.ladderSkipFromRole, ladderSkipFromRole) || other.ladderSkipFromRole == ladderSkipFromRole)&&(identical(other.ladderSkipToRole, ladderSkipToRole) || other.ladderSkipToRole == ladderSkipToRole));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,amount,currency,method,status,transactionId,reference,description,createdAt,completedAt,const DeepCollectionEquality().hash(metadata),isForLadderSkip,ladderSkipFromRole,ladderSkipToRole);

@override
String toString() {
  return 'Payment(id: $id, userId: $userId, amount: $amount, currency: $currency, method: $method, status: $status, transactionId: $transactionId, reference: $reference, description: $description, createdAt: $createdAt, completedAt: $completedAt, metadata: $metadata, isForLadderSkip: $isForLadderSkip, ladderSkipFromRole: $ladderSkipFromRole, ladderSkipToRole: $ladderSkipToRole)';
}


}

/// @nodoc
abstract mixin class $PaymentCopyWith<$Res>  {
  factory $PaymentCopyWith(Payment value, $Res Function(Payment) _then) = _$PaymentCopyWithImpl;
@useResult
$Res call({
 String id, String userId, double amount, String currency, PaymentMethod method, PaymentStatus status, String? transactionId, String? reference, String? description, DateTime? createdAt, DateTime? completedAt, Map<String, dynamic> metadata, bool isForLadderSkip, String? ladderSkipFromRole, String? ladderSkipToRole
});




}
/// @nodoc
class _$PaymentCopyWithImpl<$Res>
    implements $PaymentCopyWith<$Res> {
  _$PaymentCopyWithImpl(this._self, this._then);

  final Payment _self;
  final $Res Function(Payment) _then;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? amount = null,Object? currency = null,Object? method = null,Object? status = null,Object? transactionId = freezed,Object? reference = freezed,Object? description = freezed,Object? createdAt = freezed,Object? completedAt = freezed,Object? metadata = null,Object? isForLadderSkip = null,Object? ladderSkipFromRole = freezed,Object? ladderSkipToRole = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as PaymentMethod,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,transactionId: freezed == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String?,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,isForLadderSkip: null == isForLadderSkip ? _self.isForLadderSkip : isForLadderSkip // ignore: cast_nullable_to_non_nullable
as bool,ladderSkipFromRole: freezed == ladderSkipFromRole ? _self.ladderSkipFromRole : ladderSkipFromRole // ignore: cast_nullable_to_non_nullable
as String?,ladderSkipToRole: freezed == ladderSkipToRole ? _self.ladderSkipToRole : ladderSkipToRole // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Payment].
extension PaymentPatterns on Payment {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Payment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Payment() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Payment value)  $default,){
final _that = this;
switch (_that) {
case _Payment():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Payment value)?  $default,){
final _that = this;
switch (_that) {
case _Payment() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  double amount,  String currency,  PaymentMethod method,  PaymentStatus status,  String? transactionId,  String? reference,  String? description,  DateTime? createdAt,  DateTime? completedAt,  Map<String, dynamic> metadata,  bool isForLadderSkip,  String? ladderSkipFromRole,  String? ladderSkipToRole)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Payment() when $default != null:
return $default(_that.id,_that.userId,_that.amount,_that.currency,_that.method,_that.status,_that.transactionId,_that.reference,_that.description,_that.createdAt,_that.completedAt,_that.metadata,_that.isForLadderSkip,_that.ladderSkipFromRole,_that.ladderSkipToRole);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  double amount,  String currency,  PaymentMethod method,  PaymentStatus status,  String? transactionId,  String? reference,  String? description,  DateTime? createdAt,  DateTime? completedAt,  Map<String, dynamic> metadata,  bool isForLadderSkip,  String? ladderSkipFromRole,  String? ladderSkipToRole)  $default,) {final _that = this;
switch (_that) {
case _Payment():
return $default(_that.id,_that.userId,_that.amount,_that.currency,_that.method,_that.status,_that.transactionId,_that.reference,_that.description,_that.createdAt,_that.completedAt,_that.metadata,_that.isForLadderSkip,_that.ladderSkipFromRole,_that.ladderSkipToRole);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  double amount,  String currency,  PaymentMethod method,  PaymentStatus status,  String? transactionId,  String? reference,  String? description,  DateTime? createdAt,  DateTime? completedAt,  Map<String, dynamic> metadata,  bool isForLadderSkip,  String? ladderSkipFromRole,  String? ladderSkipToRole)?  $default,) {final _that = this;
switch (_that) {
case _Payment() when $default != null:
return $default(_that.id,_that.userId,_that.amount,_that.currency,_that.method,_that.status,_that.transactionId,_that.reference,_that.description,_that.createdAt,_that.completedAt,_that.metadata,_that.isForLadderSkip,_that.ladderSkipFromRole,_that.ladderSkipToRole);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Payment implements Payment {
  const _Payment({required this.id, required this.userId, required this.amount, required this.currency, required this.method, required this.status, this.transactionId, this.reference, this.description, this.createdAt = null, this.completedAt = null, final  Map<String, dynamic> metadata = const {}, this.isForLadderSkip = false, this.ladderSkipFromRole, this.ladderSkipToRole}): _metadata = metadata;
  factory _Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);

@override final  String id;
@override final  String userId;
@override final  double amount;
@override final  String currency;
@override final  PaymentMethod method;
@override final  PaymentStatus status;
@override final  String? transactionId;
@override final  String? reference;
@override final  String? description;
@override@JsonKey() final  DateTime? createdAt;
@override@JsonKey() final  DateTime? completedAt;
 final  Map<String, dynamic> _metadata;
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}

// For ladder skip
@override@JsonKey() final  bool isForLadderSkip;
@override final  String? ladderSkipFromRole;
@override final  String? ladderSkipToRole;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentCopyWith<_Payment> get copyWith => __$PaymentCopyWithImpl<_Payment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Payment&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.method, method) || other.method == method)&&(identical(other.status, status) || other.status == status)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.isForLadderSkip, isForLadderSkip) || other.isForLadderSkip == isForLadderSkip)&&(identical(other.ladderSkipFromRole, ladderSkipFromRole) || other.ladderSkipFromRole == ladderSkipFromRole)&&(identical(other.ladderSkipToRole, ladderSkipToRole) || other.ladderSkipToRole == ladderSkipToRole));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,amount,currency,method,status,transactionId,reference,description,createdAt,completedAt,const DeepCollectionEquality().hash(_metadata),isForLadderSkip,ladderSkipFromRole,ladderSkipToRole);

@override
String toString() {
  return 'Payment(id: $id, userId: $userId, amount: $amount, currency: $currency, method: $method, status: $status, transactionId: $transactionId, reference: $reference, description: $description, createdAt: $createdAt, completedAt: $completedAt, metadata: $metadata, isForLadderSkip: $isForLadderSkip, ladderSkipFromRole: $ladderSkipFromRole, ladderSkipToRole: $ladderSkipToRole)';
}


}

/// @nodoc
abstract mixin class _$PaymentCopyWith<$Res> implements $PaymentCopyWith<$Res> {
  factory _$PaymentCopyWith(_Payment value, $Res Function(_Payment) _then) = __$PaymentCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, double amount, String currency, PaymentMethod method, PaymentStatus status, String? transactionId, String? reference, String? description, DateTime? createdAt, DateTime? completedAt, Map<String, dynamic> metadata, bool isForLadderSkip, String? ladderSkipFromRole, String? ladderSkipToRole
});




}
/// @nodoc
class __$PaymentCopyWithImpl<$Res>
    implements _$PaymentCopyWith<$Res> {
  __$PaymentCopyWithImpl(this._self, this._then);

  final _Payment _self;
  final $Res Function(_Payment) _then;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? amount = null,Object? currency = null,Object? method = null,Object? status = null,Object? transactionId = freezed,Object? reference = freezed,Object? description = freezed,Object? createdAt = freezed,Object? completedAt = freezed,Object? metadata = null,Object? isForLadderSkip = null,Object? ladderSkipFromRole = freezed,Object? ladderSkipToRole = freezed,}) {
  return _then(_Payment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as PaymentMethod,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,transactionId: freezed == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String?,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,isForLadderSkip: null == isForLadderSkip ? _self.isForLadderSkip : isForLadderSkip // ignore: cast_nullable_to_non_nullable
as bool,ladderSkipFromRole: freezed == ladderSkipFromRole ? _self.ladderSkipFromRole : ladderSkipFromRole // ignore: cast_nullable_to_non_nullable
as String?,ladderSkipToRole: freezed == ladderSkipToRole ? _self.ladderSkipToRole : ladderSkipToRole // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PremiumContent {

 String get id; PremiumFeatureType get featureType; String get title; String get content; PremiumTier get minimumPlan; String? get author; String? get imageUrl; List<String> get tags; int get views; int get downloads; DateTime? get createdAt; DateTime? get updatedAt; bool get isFeatured;
/// Create a copy of PremiumContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PremiumContentCopyWith<PremiumContent> get copyWith => _$PremiumContentCopyWithImpl<PremiumContent>(this as PremiumContent, _$identity);

  /// Serializes this PremiumContent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PremiumContent&&(identical(other.id, id) || other.id == id)&&(identical(other.featureType, featureType) || other.featureType == featureType)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.minimumPlan, minimumPlan) || other.minimumPlan == minimumPlan)&&(identical(other.author, author) || other.author == author)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.views, views) || other.views == views)&&(identical(other.downloads, downloads) || other.downloads == downloads)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,featureType,title,content,minimumPlan,author,imageUrl,const DeepCollectionEquality().hash(tags),views,downloads,createdAt,updatedAt,isFeatured);

@override
String toString() {
  return 'PremiumContent(id: $id, featureType: $featureType, title: $title, content: $content, minimumPlan: $minimumPlan, author: $author, imageUrl: $imageUrl, tags: $tags, views: $views, downloads: $downloads, createdAt: $createdAt, updatedAt: $updatedAt, isFeatured: $isFeatured)';
}


}

/// @nodoc
abstract mixin class $PremiumContentCopyWith<$Res>  {
  factory $PremiumContentCopyWith(PremiumContent value, $Res Function(PremiumContent) _then) = _$PremiumContentCopyWithImpl;
@useResult
$Res call({
 String id, PremiumFeatureType featureType, String title, String content, PremiumTier minimumPlan, String? author, String? imageUrl, List<String> tags, int views, int downloads, DateTime? createdAt, DateTime? updatedAt, bool isFeatured
});




}
/// @nodoc
class _$PremiumContentCopyWithImpl<$Res>
    implements $PremiumContentCopyWith<$Res> {
  _$PremiumContentCopyWithImpl(this._self, this._then);

  final PremiumContent _self;
  final $Res Function(PremiumContent) _then;

/// Create a copy of PremiumContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? featureType = null,Object? title = null,Object? content = null,Object? minimumPlan = null,Object? author = freezed,Object? imageUrl = freezed,Object? tags = null,Object? views = null,Object? downloads = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? isFeatured = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,featureType: null == featureType ? _self.featureType : featureType // ignore: cast_nullable_to_non_nullable
as PremiumFeatureType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,minimumPlan: null == minimumPlan ? _self.minimumPlan : minimumPlan // ignore: cast_nullable_to_non_nullable
as PremiumTier,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,views: null == views ? _self.views : views // ignore: cast_nullable_to_non_nullable
as int,downloads: null == downloads ? _self.downloads : downloads // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PremiumContent].
extension PremiumContentPatterns on PremiumContent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PremiumContent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PremiumContent() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PremiumContent value)  $default,){
final _that = this;
switch (_that) {
case _PremiumContent():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PremiumContent value)?  $default,){
final _that = this;
switch (_that) {
case _PremiumContent() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  PremiumFeatureType featureType,  String title,  String content,  PremiumTier minimumPlan,  String? author,  String? imageUrl,  List<String> tags,  int views,  int downloads,  DateTime? createdAt,  DateTime? updatedAt,  bool isFeatured)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PremiumContent() when $default != null:
return $default(_that.id,_that.featureType,_that.title,_that.content,_that.minimumPlan,_that.author,_that.imageUrl,_that.tags,_that.views,_that.downloads,_that.createdAt,_that.updatedAt,_that.isFeatured);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  PremiumFeatureType featureType,  String title,  String content,  PremiumTier minimumPlan,  String? author,  String? imageUrl,  List<String> tags,  int views,  int downloads,  DateTime? createdAt,  DateTime? updatedAt,  bool isFeatured)  $default,) {final _that = this;
switch (_that) {
case _PremiumContent():
return $default(_that.id,_that.featureType,_that.title,_that.content,_that.minimumPlan,_that.author,_that.imageUrl,_that.tags,_that.views,_that.downloads,_that.createdAt,_that.updatedAt,_that.isFeatured);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  PremiumFeatureType featureType,  String title,  String content,  PremiumTier minimumPlan,  String? author,  String? imageUrl,  List<String> tags,  int views,  int downloads,  DateTime? createdAt,  DateTime? updatedAt,  bool isFeatured)?  $default,) {final _that = this;
switch (_that) {
case _PremiumContent() when $default != null:
return $default(_that.id,_that.featureType,_that.title,_that.content,_that.minimumPlan,_that.author,_that.imageUrl,_that.tags,_that.views,_that.downloads,_that.createdAt,_that.updatedAt,_that.isFeatured);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PremiumContent implements PremiumContent {
  const _PremiumContent({required this.id, required this.featureType, required this.title, required this.content, required this.minimumPlan, this.author, this.imageUrl, final  List<String> tags = const [], this.views = 0, this.downloads = 0, this.createdAt = null, this.updatedAt = null, this.isFeatured = false}): _tags = tags;
  factory _PremiumContent.fromJson(Map<String, dynamic> json) => _$PremiumContentFromJson(json);

@override final  String id;
@override final  PremiumFeatureType featureType;
@override final  String title;
@override final  String content;
@override final  PremiumTier minimumPlan;
@override final  String? author;
@override final  String? imageUrl;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override@JsonKey() final  int views;
@override@JsonKey() final  int downloads;
@override@JsonKey() final  DateTime? createdAt;
@override@JsonKey() final  DateTime? updatedAt;
@override@JsonKey() final  bool isFeatured;

/// Create a copy of PremiumContent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PremiumContentCopyWith<_PremiumContent> get copyWith => __$PremiumContentCopyWithImpl<_PremiumContent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PremiumContentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PremiumContent&&(identical(other.id, id) || other.id == id)&&(identical(other.featureType, featureType) || other.featureType == featureType)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.minimumPlan, minimumPlan) || other.minimumPlan == minimumPlan)&&(identical(other.author, author) || other.author == author)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.views, views) || other.views == views)&&(identical(other.downloads, downloads) || other.downloads == downloads)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isFeatured, isFeatured) || other.isFeatured == isFeatured));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,featureType,title,content,minimumPlan,author,imageUrl,const DeepCollectionEquality().hash(_tags),views,downloads,createdAt,updatedAt,isFeatured);

@override
String toString() {
  return 'PremiumContent(id: $id, featureType: $featureType, title: $title, content: $content, minimumPlan: $minimumPlan, author: $author, imageUrl: $imageUrl, tags: $tags, views: $views, downloads: $downloads, createdAt: $createdAt, updatedAt: $updatedAt, isFeatured: $isFeatured)';
}


}

/// @nodoc
abstract mixin class _$PremiumContentCopyWith<$Res> implements $PremiumContentCopyWith<$Res> {
  factory _$PremiumContentCopyWith(_PremiumContent value, $Res Function(_PremiumContent) _then) = __$PremiumContentCopyWithImpl;
@override @useResult
$Res call({
 String id, PremiumFeatureType featureType, String title, String content, PremiumTier minimumPlan, String? author, String? imageUrl, List<String> tags, int views, int downloads, DateTime? createdAt, DateTime? updatedAt, bool isFeatured
});




}
/// @nodoc
class __$PremiumContentCopyWithImpl<$Res>
    implements _$PremiumContentCopyWith<$Res> {
  __$PremiumContentCopyWithImpl(this._self, this._then);

  final _PremiumContent _self;
  final $Res Function(_PremiumContent) _then;

/// Create a copy of PremiumContent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? featureType = null,Object? title = null,Object? content = null,Object? minimumPlan = null,Object? author = freezed,Object? imageUrl = freezed,Object? tags = null,Object? views = null,Object? downloads = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? isFeatured = null,}) {
  return _then(_PremiumContent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,featureType: null == featureType ? _self.featureType : featureType // ignore: cast_nullable_to_non_nullable
as PremiumFeatureType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,minimumPlan: null == minimumPlan ? _self.minimumPlan : minimumPlan // ignore: cast_nullable_to_non_nullable
as PremiumTier,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,views: null == views ? _self.views : views // ignore: cast_nullable_to_non_nullable
as int,downloads: null == downloads ? _self.downloads : downloads // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isFeatured: null == isFeatured ? _self.isFeatured : isFeatured // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$PriceModel {

 SubscriptionPlan get plan; double get monthlyPrice; double get yearlyPrice; String get currency; List<PremiumFeatureType> get includedFeatures; String? get description; String? get badge; bool get isPopular; bool get isRecommended;
/// Create a copy of PriceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PriceModelCopyWith<PriceModel> get copyWith => _$PriceModelCopyWithImpl<PriceModel>(this as PriceModel, _$identity);

  /// Serializes this PriceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PriceModel&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.monthlyPrice, monthlyPrice) || other.monthlyPrice == monthlyPrice)&&(identical(other.yearlyPrice, yearlyPrice) || other.yearlyPrice == yearlyPrice)&&(identical(other.currency, currency) || other.currency == currency)&&const DeepCollectionEquality().equals(other.includedFeatures, includedFeatures)&&(identical(other.description, description) || other.description == description)&&(identical(other.badge, badge) || other.badge == badge)&&(identical(other.isPopular, isPopular) || other.isPopular == isPopular)&&(identical(other.isRecommended, isRecommended) || other.isRecommended == isRecommended));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,plan,monthlyPrice,yearlyPrice,currency,const DeepCollectionEquality().hash(includedFeatures),description,badge,isPopular,isRecommended);

@override
String toString() {
  return 'PriceModel(plan: $plan, monthlyPrice: $monthlyPrice, yearlyPrice: $yearlyPrice, currency: $currency, includedFeatures: $includedFeatures, description: $description, badge: $badge, isPopular: $isPopular, isRecommended: $isRecommended)';
}


}

/// @nodoc
abstract mixin class $PriceModelCopyWith<$Res>  {
  factory $PriceModelCopyWith(PriceModel value, $Res Function(PriceModel) _then) = _$PriceModelCopyWithImpl;
@useResult
$Res call({
 SubscriptionPlan plan, double monthlyPrice, double yearlyPrice, String currency, List<PremiumFeatureType> includedFeatures, String? description, String? badge, bool isPopular, bool isRecommended
});




}
/// @nodoc
class _$PriceModelCopyWithImpl<$Res>
    implements $PriceModelCopyWith<$Res> {
  _$PriceModelCopyWithImpl(this._self, this._then);

  final PriceModel _self;
  final $Res Function(PriceModel) _then;

/// Create a copy of PriceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? plan = null,Object? monthlyPrice = null,Object? yearlyPrice = null,Object? currency = null,Object? includedFeatures = null,Object? description = freezed,Object? badge = freezed,Object? isPopular = null,Object? isRecommended = null,}) {
  return _then(_self.copyWith(
plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as SubscriptionPlan,monthlyPrice: null == monthlyPrice ? _self.monthlyPrice : monthlyPrice // ignore: cast_nullable_to_non_nullable
as double,yearlyPrice: null == yearlyPrice ? _self.yearlyPrice : yearlyPrice // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,includedFeatures: null == includedFeatures ? _self.includedFeatures : includedFeatures // ignore: cast_nullable_to_non_nullable
as List<PremiumFeatureType>,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,badge: freezed == badge ? _self.badge : badge // ignore: cast_nullable_to_non_nullable
as String?,isPopular: null == isPopular ? _self.isPopular : isPopular // ignore: cast_nullable_to_non_nullable
as bool,isRecommended: null == isRecommended ? _self.isRecommended : isRecommended // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PriceModel].
extension PriceModelPatterns on PriceModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PriceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PriceModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PriceModel value)  $default,){
final _that = this;
switch (_that) {
case _PriceModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PriceModel value)?  $default,){
final _that = this;
switch (_that) {
case _PriceModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SubscriptionPlan plan,  double monthlyPrice,  double yearlyPrice,  String currency,  List<PremiumFeatureType> includedFeatures,  String? description,  String? badge,  bool isPopular,  bool isRecommended)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PriceModel() when $default != null:
return $default(_that.plan,_that.monthlyPrice,_that.yearlyPrice,_that.currency,_that.includedFeatures,_that.description,_that.badge,_that.isPopular,_that.isRecommended);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SubscriptionPlan plan,  double monthlyPrice,  double yearlyPrice,  String currency,  List<PremiumFeatureType> includedFeatures,  String? description,  String? badge,  bool isPopular,  bool isRecommended)  $default,) {final _that = this;
switch (_that) {
case _PriceModel():
return $default(_that.plan,_that.monthlyPrice,_that.yearlyPrice,_that.currency,_that.includedFeatures,_that.description,_that.badge,_that.isPopular,_that.isRecommended);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SubscriptionPlan plan,  double monthlyPrice,  double yearlyPrice,  String currency,  List<PremiumFeatureType> includedFeatures,  String? description,  String? badge,  bool isPopular,  bool isRecommended)?  $default,) {final _that = this;
switch (_that) {
case _PriceModel() when $default != null:
return $default(_that.plan,_that.monthlyPrice,_that.yearlyPrice,_that.currency,_that.includedFeatures,_that.description,_that.badge,_that.isPopular,_that.isRecommended);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PriceModel implements PriceModel {
  const _PriceModel({required this.plan, required this.monthlyPrice, required this.yearlyPrice, required this.currency, final  List<PremiumFeatureType> includedFeatures = const [], this.description, this.badge, this.isPopular = false, this.isRecommended = false}): _includedFeatures = includedFeatures;
  factory _PriceModel.fromJson(Map<String, dynamic> json) => _$PriceModelFromJson(json);

@override final  SubscriptionPlan plan;
@override final  double monthlyPrice;
@override final  double yearlyPrice;
@override final  String currency;
 final  List<PremiumFeatureType> _includedFeatures;
@override@JsonKey() List<PremiumFeatureType> get includedFeatures {
  if (_includedFeatures is EqualUnmodifiableListView) return _includedFeatures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_includedFeatures);
}

@override final  String? description;
@override final  String? badge;
@override@JsonKey() final  bool isPopular;
@override@JsonKey() final  bool isRecommended;

/// Create a copy of PriceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PriceModelCopyWith<_PriceModel> get copyWith => __$PriceModelCopyWithImpl<_PriceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PriceModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PriceModel&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.monthlyPrice, monthlyPrice) || other.monthlyPrice == monthlyPrice)&&(identical(other.yearlyPrice, yearlyPrice) || other.yearlyPrice == yearlyPrice)&&(identical(other.currency, currency) || other.currency == currency)&&const DeepCollectionEquality().equals(other._includedFeatures, _includedFeatures)&&(identical(other.description, description) || other.description == description)&&(identical(other.badge, badge) || other.badge == badge)&&(identical(other.isPopular, isPopular) || other.isPopular == isPopular)&&(identical(other.isRecommended, isRecommended) || other.isRecommended == isRecommended));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,plan,monthlyPrice,yearlyPrice,currency,const DeepCollectionEquality().hash(_includedFeatures),description,badge,isPopular,isRecommended);

@override
String toString() {
  return 'PriceModel(plan: $plan, monthlyPrice: $monthlyPrice, yearlyPrice: $yearlyPrice, currency: $currency, includedFeatures: $includedFeatures, description: $description, badge: $badge, isPopular: $isPopular, isRecommended: $isRecommended)';
}


}

/// @nodoc
abstract mixin class _$PriceModelCopyWith<$Res> implements $PriceModelCopyWith<$Res> {
  factory _$PriceModelCopyWith(_PriceModel value, $Res Function(_PriceModel) _then) = __$PriceModelCopyWithImpl;
@override @useResult
$Res call({
 SubscriptionPlan plan, double monthlyPrice, double yearlyPrice, String currency, List<PremiumFeatureType> includedFeatures, String? description, String? badge, bool isPopular, bool isRecommended
});




}
/// @nodoc
class __$PriceModelCopyWithImpl<$Res>
    implements _$PriceModelCopyWith<$Res> {
  __$PriceModelCopyWithImpl(this._self, this._then);

  final _PriceModel _self;
  final $Res Function(_PriceModel) _then;

/// Create a copy of PriceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? plan = null,Object? monthlyPrice = null,Object? yearlyPrice = null,Object? currency = null,Object? includedFeatures = null,Object? description = freezed,Object? badge = freezed,Object? isPopular = null,Object? isRecommended = null,}) {
  return _then(_PriceModel(
plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as SubscriptionPlan,monthlyPrice: null == monthlyPrice ? _self.monthlyPrice : monthlyPrice // ignore: cast_nullable_to_non_nullable
as double,yearlyPrice: null == yearlyPrice ? _self.yearlyPrice : yearlyPrice // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,includedFeatures: null == includedFeatures ? _self._includedFeatures : includedFeatures // ignore: cast_nullable_to_non_nullable
as List<PremiumFeatureType>,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,badge: freezed == badge ? _self.badge : badge // ignore: cast_nullable_to_non_nullable
as String?,isPopular: null == isPopular ? _self.isPopular : isPopular // ignore: cast_nullable_to_non_nullable
as bool,isRecommended: null == isRecommended ? _self.isRecommended : isRecommended // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$LadderSkipConfig {

 String get fromRole; String get toRole; double get price; String get currency; String get description; List<String> get includedFeatures; bool get isAvailable;
/// Create a copy of LadderSkipConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LadderSkipConfigCopyWith<LadderSkipConfig> get copyWith => _$LadderSkipConfigCopyWithImpl<LadderSkipConfig>(this as LadderSkipConfig, _$identity);

  /// Serializes this LadderSkipConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LadderSkipConfig&&(identical(other.fromRole, fromRole) || other.fromRole == fromRole)&&(identical(other.toRole, toRole) || other.toRole == toRole)&&(identical(other.price, price) || other.price == price)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.includedFeatures, includedFeatures)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fromRole,toRole,price,currency,description,const DeepCollectionEquality().hash(includedFeatures),isAvailable);

@override
String toString() {
  return 'LadderSkipConfig(fromRole: $fromRole, toRole: $toRole, price: $price, currency: $currency, description: $description, includedFeatures: $includedFeatures, isAvailable: $isAvailable)';
}


}

/// @nodoc
abstract mixin class $LadderSkipConfigCopyWith<$Res>  {
  factory $LadderSkipConfigCopyWith(LadderSkipConfig value, $Res Function(LadderSkipConfig) _then) = _$LadderSkipConfigCopyWithImpl;
@useResult
$Res call({
 String fromRole, String toRole, double price, String currency, String description, List<String> includedFeatures, bool isAvailable
});




}
/// @nodoc
class _$LadderSkipConfigCopyWithImpl<$Res>
    implements $LadderSkipConfigCopyWith<$Res> {
  _$LadderSkipConfigCopyWithImpl(this._self, this._then);

  final LadderSkipConfig _self;
  final $Res Function(LadderSkipConfig) _then;

/// Create a copy of LadderSkipConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fromRole = null,Object? toRole = null,Object? price = null,Object? currency = null,Object? description = null,Object? includedFeatures = null,Object? isAvailable = null,}) {
  return _then(_self.copyWith(
fromRole: null == fromRole ? _self.fromRole : fromRole // ignore: cast_nullable_to_non_nullable
as String,toRole: null == toRole ? _self.toRole : toRole // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,includedFeatures: null == includedFeatures ? _self.includedFeatures : includedFeatures // ignore: cast_nullable_to_non_nullable
as List<String>,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LadderSkipConfig].
extension LadderSkipConfigPatterns on LadderSkipConfig {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LadderSkipConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LadderSkipConfig() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LadderSkipConfig value)  $default,){
final _that = this;
switch (_that) {
case _LadderSkipConfig():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LadderSkipConfig value)?  $default,){
final _that = this;
switch (_that) {
case _LadderSkipConfig() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fromRole,  String toRole,  double price,  String currency,  String description,  List<String> includedFeatures,  bool isAvailable)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LadderSkipConfig() when $default != null:
return $default(_that.fromRole,_that.toRole,_that.price,_that.currency,_that.description,_that.includedFeatures,_that.isAvailable);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fromRole,  String toRole,  double price,  String currency,  String description,  List<String> includedFeatures,  bool isAvailable)  $default,) {final _that = this;
switch (_that) {
case _LadderSkipConfig():
return $default(_that.fromRole,_that.toRole,_that.price,_that.currency,_that.description,_that.includedFeatures,_that.isAvailable);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fromRole,  String toRole,  double price,  String currency,  String description,  List<String> includedFeatures,  bool isAvailable)?  $default,) {final _that = this;
switch (_that) {
case _LadderSkipConfig() when $default != null:
return $default(_that.fromRole,_that.toRole,_that.price,_that.currency,_that.description,_that.includedFeatures,_that.isAvailable);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LadderSkipConfig implements LadderSkipConfig {
  const _LadderSkipConfig({required this.fromRole, required this.toRole, required this.price, required this.currency, required this.description, final  List<String> includedFeatures = const [], this.isAvailable = false}): _includedFeatures = includedFeatures;
  factory _LadderSkipConfig.fromJson(Map<String, dynamic> json) => _$LadderSkipConfigFromJson(json);

@override final  String fromRole;
@override final  String toRole;
@override final  double price;
@override final  String currency;
@override final  String description;
 final  List<String> _includedFeatures;
@override@JsonKey() List<String> get includedFeatures {
  if (_includedFeatures is EqualUnmodifiableListView) return _includedFeatures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_includedFeatures);
}

@override@JsonKey() final  bool isAvailable;

/// Create a copy of LadderSkipConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LadderSkipConfigCopyWith<_LadderSkipConfig> get copyWith => __$LadderSkipConfigCopyWithImpl<_LadderSkipConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LadderSkipConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LadderSkipConfig&&(identical(other.fromRole, fromRole) || other.fromRole == fromRole)&&(identical(other.toRole, toRole) || other.toRole == toRole)&&(identical(other.price, price) || other.price == price)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._includedFeatures, _includedFeatures)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fromRole,toRole,price,currency,description,const DeepCollectionEquality().hash(_includedFeatures),isAvailable);

@override
String toString() {
  return 'LadderSkipConfig(fromRole: $fromRole, toRole: $toRole, price: $price, currency: $currency, description: $description, includedFeatures: $includedFeatures, isAvailable: $isAvailable)';
}


}

/// @nodoc
abstract mixin class _$LadderSkipConfigCopyWith<$Res> implements $LadderSkipConfigCopyWith<$Res> {
  factory _$LadderSkipConfigCopyWith(_LadderSkipConfig value, $Res Function(_LadderSkipConfig) _then) = __$LadderSkipConfigCopyWithImpl;
@override @useResult
$Res call({
 String fromRole, String toRole, double price, String currency, String description, List<String> includedFeatures, bool isAvailable
});




}
/// @nodoc
class __$LadderSkipConfigCopyWithImpl<$Res>
    implements _$LadderSkipConfigCopyWith<$Res> {
  __$LadderSkipConfigCopyWithImpl(this._self, this._then);

  final _LadderSkipConfig _self;
  final $Res Function(_LadderSkipConfig) _then;

/// Create a copy of LadderSkipConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fromRole = null,Object? toRole = null,Object? price = null,Object? currency = null,Object? description = null,Object? includedFeatures = null,Object? isAvailable = null,}) {
  return _then(_LadderSkipConfig(
fromRole: null == fromRole ? _self.fromRole : fromRole // ignore: cast_nullable_to_non_nullable
as String,toRole: null == toRole ? _self.toRole : toRole // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,includedFeatures: null == includedFeatures ? _self._includedFeatures : includedFeatures // ignore: cast_nullable_to_non_nullable
as List<String>,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
