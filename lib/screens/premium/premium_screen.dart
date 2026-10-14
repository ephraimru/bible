import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../config/theme.dart';
import '../../models/user_model.dart';
import '../../models/premium_model.dart';
import '../../models/faith_journey_model.dart';
import '../../services/auth_service.dart';
import '../../services/database_service.dart';
import '../../services/premium_service.dart';
import '../../services/faith_journey_service.dart';

class PremiumScreen extends ConsumerStatefulWidget {
  const PremiumScreen({super.key});

  @override
  ConsumerState<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends ConsumerState<PremiumScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(localCurrentUserProvider).value;
    final subscription = ref.watch(currentSubscriptionProvider).value;
    final productsAsync = ref.watch(availableProductsProvider);
    final premiumService = ref.read(premiumServiceProvider);
    
    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Premium Features'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star_outline, size: 64, color: Colors.grey),
              const SizedBox(height: AppTheme.md),
              Text('Please log in to access premium features', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppTheme.sm),
              ElevatedButton(
                onPressed: () => context.go('/login'),
                child: const Text('Log In'),
              ),
            ],
          ),
        ),
      );
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Premium Features'),
        actions: [
          if (user.premiumTier != PremiumTier.free)
            IconButton(
              icon: const Icon(Icons.history),
              onPressed: _showSubscriptionHistory,
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Subscription Status
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.md),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          user.premiumTier == PremiumTier.free ? Icons.star_outline : Icons.star,
                          size: 40,
                          color: user.premiumTier == PremiumTier.free ? Colors.grey : Colors.amber,
                        ),
                        const SizedBox(width: AppTheme.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.premiumTier.displayName,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (subscription != null)
                                Text(
                                  'Expires: ${_formatDate(subscription.endDate)}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: subscription.isActive ? Colors.green : Colors.red,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.md),
                    if (user.premiumTier == PremiumTier.free)
                      Text(
                        'Upgrade to unlock premium features and enhance your faith journey!',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    if (user.premiumTier != PremiumTier.free)
                      Text(
                        'Thank you for supporting Faith Mission!',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppTheme.md),
            
            // Premium Tier Comparison
            _buildSectionHeader('Subscription Plans', Icons.compare_arrows),
            const SizedBox(height: AppTheme.sm),
            
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildTierCard(
                    tier: PremiumTier.basic,
                    isCurrent: user.premiumTier == PremiumTier.basic,
                    isAvailable: true,
                    price: '\$4.99/month',
                    features: const [
                      'Advanced Bible Search',
                      'Offline Mode',
                      'Ad-Free Experience',
                      'Reading Plans',
                    ],
                    onTap: () => _purchaseSubscription(SubscriptionPlan.basicMonthly),
                  ),
                  const SizedBox(width: AppTheme.md),
                  _buildTierCard(
                    tier: PremiumTier.pro,
                    isCurrent: user.premiumTier == PremiumTier.pro,
                    isAvailable: true,
                    price: '\$9.99/month',
                    features: const [
                      'All Basic Features',
                      'Bible Commentaries',
                      'Devotionals',
                      'Cross References',
                      'Study Notes',
                    ],
                    onTap: () => _purchaseSubscription(SubscriptionPlan.proMonthly),
                  ),
                  const SizedBox(width: AppTheme.md),
                  _buildTierCard(
                    tier: PremiumTier.bishop,
                    isCurrent: user.premiumTier == PremiumTier.bishop || user.role == UserRole.bishop,
                    isAvailable: user.role == UserRole.bishop || user.hasPaidToSkipLadder,
                    price: user.role == UserRole.bishop ? 'Included' : '\$24.99',
                    features: const [
                      'All Pro Features',
                      'Blog Posting',
                      'Custom Title Selection',
                      'Follower Analytics',
                      'Priority Support',
                    ],
                    onTap: user.role == UserRole.bishop || user.hasPaidToSkipLadder
                        ? null
                        : () => _purchaseBishopAccess(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.md),
            
            // Yearly Plans (Discounted)
            _buildSectionHeader('Yearly Plans (Save 20%)', Icons.calendar_today),
            const SizedBox(height: AppTheme.sm),
            
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildTierCard(
                    tier: PremiumTier.basic,
                    isCurrent: false,
                    isAvailable: true,
                    price: '\$39.99/year',
                    features: const [
                      'All Basic Features',
                      '20% Discount',
                    ],
                    onTap: () => _purchaseSubscription(SubscriptionPlan.basicYearly),
                  ),
                  const SizedBox(width: AppTheme.md),
                  _buildTierCard(
                    tier: PremiumTier.pro,
                    isCurrent: false,
                    isAvailable: true,
                    price: '\$79.99/year',
                    features: const [
                      'All Pro Features',
                      '20% Discount',
                    ],
                    onTap: () => _purchaseSubscription(SubscriptionPlan.proYearly),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.md),
            
            // Skip Ladder Option
            if (user.role != UserRole.bishop && !user.hasPaidToSkipLadder)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader('Special Offer', Icons.bolt),
                  const SizedBox(height: AppTheme.sm),
                  Card(
                    elevation: 4,
                    color: Colors.purple.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(AppTheme.md),
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.skip_next, size: 40, color: Colors.purple),
                              SizedBox(width: AppTheme.md),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Become a Bishop Immediately',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.purple.shade800,
                                      ),
                                    ),
                                    Text(
                                      'Skip the faith journey ladder',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.purple.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppTheme.md),
                          const Divider(),
                          const SizedBox(height: AppTheme.sm),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Current Role: ${user.role.displayName}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(height: AppTheme.xs),
                                  Text(
                                    'Next: ${user.role.level < 4 ? UserRole.values[user.role.level].displayName : 'Bishop'}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              ElevatedButton.icon(
                                onPressed: () => _purchaseLadderSkip(),
                                icon: const Icon(Icons.bolt),
                                label: const Text('\$49.99'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.purple,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppTheme.md,
                                    vertical: AppTheme.sm,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppTheme.sm),
                          Text(
                            'Or reach 1000+ followers to become a Bishop for free',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            
            const SizedBox(height: AppTheme.md),
            
            // Your Features
            _buildSectionHeader('Your Features', Icons.check_circle),
            const SizedBox(height: AppTheme.sm),
            
            ..._getAvailableFeatures(user.premiumTier, user.role, user.hasPaidToSkipLadder)
                .map((feature) => Card(
                      child: ListTile(
                        leading: Icon(
                          feature.isUnlocked ? Icons.check_circle : Icons.lock,
                          color: feature.isUnlocked ? Colors.green : Colors.grey,
                        ),
                        title: Text(feature.name),
                        subtitle: Text(feature.description),
                        trailing: feature.isUnlocked
                            ? const Icon(Icons.star, color: Colors.amber)
                            : Text(
                                feature.minimumPlan.displayName,
                                style: const TextStyle(color: Colors.grey),
                              ),
                      ),
                    )),
            
            const SizedBox(height: AppTheme.md),
            
            // Restore Purchases
            if (user.premiumTier == PremiumTier.free)
              Center(
                child: TextButton.icon(
                  onPressed: _restorePurchases,
                  icon: const Icon(Icons.restore),
                  label: const Text('Restore Purchases'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.blue.shade800),
        const SizedBox(width: AppTheme.sm),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildTierCard({
    required PremiumTier tier,
    required bool isCurrent,
    required bool isAvailable,
    required String price,
    required List<String> features,
    required VoidCallback? onTap,
  }) {
    final isFree = tier == PremiumTier.free;
    
    return SizedBox(
      width: 200,
      child: Card(
        elevation: isCurrent ? 4 : 2,
        color: isCurrent ? Colors.blue.shade50 : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: isCurrent 
              ? BorderSide(color: Colors.blue.shade800, width: 2)
              : BorderSide.none,
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    tier == PremiumTier.basic ? Icons.star
                    : tier == PremiumTier.pro ? Icons.star_half
                    : Icons.star,
                    color: tier == PremiumTier.basic ? Colors.amber
                    : tier == PremiumTier.pro ? Colors.amber
                    : Colors.purple,
                  ),
                  const SizedBox(width: AppTheme.xs),
                  Text(
                    tier.displayName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isCurrent ? Colors.blue.shade800 : Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.xs),
              Text(
                price,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isCurrent ? Colors.blue.shade800 : Colors.black,
                ),
              ),
              const SizedBox(height: AppTheme.sm),
              const Divider(),
              const SizedBox(height: AppTheme.xs),
              ...features.map((feature) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        const Icon(Icons.check, size: 16, color: Colors.green),
                        const SizedBox(width: AppTheme.xs),
                        Text(
                          feature,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: AppTheme.sm),
              if (isCurrent)
                Center(
                  child: Text(
                    'Current Plan',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade800,
                    ),
                  ),
                ),
              if (!isCurrent && onTap != null)
                Center(
                  child: ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.sm,
                        vertical: AppTheme.xs,
                      ),
                      backgroundColor: Colors.blue.shade800,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Upgrade'),
                  ),
                ),
              if (!isCurrent && onTap == null)
                Center(
                  child: Text(
                    'Locked',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  List<PremiumFeature> _getAvailableFeatures(
    PremiumTier tier,
    UserRole role,
    bool hasPaidToSkip,
  ) {
    final allFeatures = [
      PremiumFeature(
        id: PremiumFeatureType.advancedSearch,
        name: 'Advanced Bible Search',
        description: 'Enhanced search capabilities for the Bible',
        icon: 'search',
        minimumPlan: PremiumTier.basic,
        isUnlocked: tier.index >= PremiumTier.basic.index,
      ),
      PremiumFeature(
        id: PremiumFeatureType.offlineMode,
        name: 'Offline Mode',
        description: 'Download and read the Bible without internet',
        icon: 'download',
        minimumPlan: PremiumTier.basic,
        isUnlocked: tier.index >= PremiumTier.basic.index,
      ),
      PremiumFeature(
        id: PremiumFeatureType.adFreeExperience,
        name: 'Ad-Free Experience',
        description: 'Remove all advertisements from the app',
        icon: 'ad_free',
        minimumPlan: PremiumTier.basic,
        isUnlocked: tier.index >= PremiumTier.basic.index,
      ),
      PremiumFeature(
        id: PremiumFeatureType.bibleReadingPlans,
        name: 'Bible Reading Plans',
        description: 'Guided reading plans to help you read the Bible',
        icon: 'book',
        minimumPlan: PremiumTier.basic,
        isUnlocked: tier.index >= PremiumTier.basic.index,
      ),
      PremiumFeature(
        id: PremiumFeatureType.premiumBibleCommentaries,
        name: 'Bible Commentaries',
        description: 'Access to premium Bible commentaries',
        icon: 'comment',
        minimumPlan: PremiumTier.pro,
        isUnlocked: tier.index >= PremiumTier.pro.index,
      ),
      PremiumFeature(
        id: PremiumFeatureType.premiumDevotionals,
        name: 'Devotionals',
        description: 'Exclusive devotionals and Bible studies',
        icon: 'devotionals',
        minimumPlan: PremiumTier.pro,
        isUnlocked: tier.index >= PremiumTier.pro.index,
      ),
      PremiumFeature(
        id: PremiumFeatureType.crossReferences,
        name: 'Cross References',
        description: 'View cross-references between Bible verses',
        icon: 'cross_references',
        minimumPlan: PremiumTier.pro,
        isUnlocked: tier.index >= PremiumTier.pro.index,
      ),
      PremiumFeature(
        id: PremiumFeatureType.studyNotes,
        name: 'Study Notes',
        description: 'Create and save personal study notes',
        icon: 'notes',
        minimumPlan: PremiumTier.pro,
        isUnlocked: tier.index >= PremiumTier.pro.index,
      ),
      PremiumFeature(
        id: PremiumFeatureType.customThemes,
        name: 'Custom Themes',
        description: 'Personalize the app appearance with custom themes',
        icon: 'palette',
        minimumPlan: PremiumTier.pro,
        isUnlocked: tier.index >= PremiumTier.pro.index,
      ),
      PremiumFeature(
        id: PremiumFeatureType.blogPosting,
        name: 'Blog Posting',
        description: 'Post articles and devotionals on the blog',
        icon: 'blog',
        minimumPlan: PremiumTier.bishop,
        isUnlocked: role == UserRole.bishop || hasPaidToSkip,
      ),
      PremiumFeature(
        id: PremiumFeatureType.titleSelection,
        name: 'Custom Title Selection',
        description: 'Choose your custom title when you reach Bishop level',
        icon: 'title',
        minimumPlan: PremiumTier.bishop,
        isUnlocked: role == UserRole.bishop || hasPaidToSkip,
      ),
      PremiumFeature(
        id: PremiumFeatureType.followerAnalytics,
        name: 'Follower Analytics',
        description: 'View analytics about your followers',
        icon: 'analytics',
        minimumPlan: PremiumTier.bishop,
        isUnlocked: role == UserRole.bishop || hasPaidToSkip,
      ),
    ];
    
    return allFeatures;
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return '${date.month}/${date.day}/${date.year}';
  }

  Future<void> _purchaseSubscription(SubscriptionPlan plan) async {
    final user = ref.read(localCurrentUserProvider).value;
    if (user == null) return;
    
    final premiumService = ref.read(premiumServiceProvider);
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    
    try {
      final result = await premiumService.purchaseSubscription(plan);
      Navigator.of(context).pop();
      
      if (result) {
        if (mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Success!'),
              content: const Text('Your subscription has been activated. Thank you for supporting Faith Mission!'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      } else {
        if (mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Purchase Failed'),
              content: const Text('There was an error processing your purchase. Please try again.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      }
    } catch (e) {
      Navigator.of(context).pop();
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text('An error occurred: $e'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  Future<void> _purchaseBishopAccess() async {
    final user = ref.read(localCurrentUserProvider).value;
    if (user == null) return;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Bishop Access Required'),
        content: const Text('You need to reach Bishop level to access these features. You can either gain 1000+ followers or purchase the ladder skip.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _purchaseLadderSkip();
            },
            child: const Text('Purchase Ladder Skip'),
          ),
        ],
      ),
    );
  }

  Future<void> _purchaseLadderSkip() async {
    final user = ref.read(localCurrentUserProvider).value;
    if (user == null) return;
    
    final premiumService = ref.read(premiumServiceProvider);
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    
    try {
      final result = await premiumService.purchaseLadderSkip();
      Navigator.of(context).pop();
      
      if (result) {
        // Update user role
        await ref.read(localStorageServiceProvider).updateUser(user.id, {
          'role': UserRole.bishop.name,
          'hasPaidToSkipLadder': true,
          'canPostOnBlog': true,
          'premiumTier': PremiumTier.bishop.name,
          'updatedAt': DateTime.now(),
        });
        
        // Update faith journey
        await ref.read(faithJourneyServiceProvider).promoteToBishop(user.id);
        
        if (mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Congratulations!'),
              content: const Text('You are now a Bishop! You can now post on the blog and choose a custom title.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      } else {
        if (mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Purchase Failed'),
              content: const Text('There was an error processing your purchase. Please try again.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      }
    } catch (e) {
      Navigator.of(context).pop();
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text('An error occurred: $e'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  Future<void> _restorePurchases() async {
    final premiumService = ref.read(premiumServiceProvider);
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    
    try {
      final result = await premiumService.restorePurchases();
      Navigator.of(context).pop();
      
      if (result) {
        if (mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Success!'),
              content: const Text('Your purchases have been restored.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      } else {
        if (mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('No Purchases Found'),
              content: const Text('No previous purchases were found to restore.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      }
    } catch (e) {
      Navigator.of(context).pop();
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text('An error occurred: $e'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  Future<void> _showSubscriptionHistory() async {
    final user = ref.read(localCurrentUserProvider).value;
    if (user == null) return;
    
    final subscriptions = await ref.read(premiumServiceProvider).getSubscriptionHistory(user.id);
    
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Subscription History'),
        content: SizedBox(
          width: double.maxFinite,
          child: subscriptions.isEmpty
              ? const Text('No subscription history found.')
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: subscriptions.length,
                  itemBuilder: (context, index) {
                    final sub = subscriptions[index];
                    return ListTile(
                      title: Text(sub.plan.displayName),
                      subtitle: Text('${_formatDate(sub.startDate)} - ${_formatDate(sub.endDate)}'),
                      trailing: Text(
                        sub.isActive ? 'Active' : 'Expired',
                        style: TextStyle(
                          color: sub.isActive ? Colors.green : Colors.red,
                        ),
                      ),
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
