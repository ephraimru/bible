import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

import 'local_storage_service.dart';

// Notification Service Provider
final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService(
    localStorageService: ref.read(localStorageServiceProvider),
  );
});

class NotificationService {
  final LocalStorageService _localStorageService;
  final FlutterLocalNotificationsPlugin _notificationsPlugin;

  NotificationService({
    required LocalStorageService localStorageService,
  })  : _localStorageService = localStorageService,
        _notificationsPlugin = FlutterLocalNotificationsPlugin();

  // Initialize notifications
  Future<void> initialize() async {
    // Initialize timezone
    tz_data.initializeTimeZones();
    
    // Android initialization
    const androidInitSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    
    // iOS initialization
    const iosInitSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: null,
    );
    
    const initSettings = InitializationSettings(
      android: androidInitSettings,
      iOS: iosInitSettings,
    );
    
    await _notificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        _handleNotificationTap(details.payload);
      },
    );
    
    // Request permissions
    await _requestPermissions();
  }

  // Request notification permissions
  Future<void> _requestPermissions() async {
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  // Handle notification tap
  Future<void> _handleNotificationTap(String? payload) async {
    if (payload == null) return;
    
    // Parse payload
    final data = _parsePayload(payload);
    
    // Handle different notification types
    switch (data['type']) {
      case 'reading_reminder':
        // Open Bible screen
        break;
      case 'milestone':
        // Open faith journey screen
        break;
      case 'role_progress':
        // Open faith journey screen
        break;
      case 'bishop_eligibility':
        // Open profile or settings
        break;
      case 'new_message':
        // Open chat room
        break;
      case 'new_post':
        // Open blog
        break;
      default:
        break;
    }
  }

  // Parse notification payload
  Map<String, dynamic> _parsePayload(String payload) {
    try {
      // Simple JSON parsing
      // In production, use proper JSON parsing
      final parts = payload.split('&');
      final data = <String, dynamic>{};
      
      for (final part in parts) {
        final keyValue = part.split('=');
        if (keyValue.length == 2) {
          data[keyValue[0]] = keyValue[1];
        }
      }
      
      return data;
    } catch (e) {
      return {};
    }
  }

  // ============ NOTIFICATION METHODS ============

  /// Show immediate notification
  Future<void> showNotification({
    required String title,
    required String body,
    Map<String, dynamic>? data,
    int id = 0,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'faith_mission_channel',
      'Faith Mission Notifications',
      channelDescription: 'Notifications for Faith Mission app',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      icon: '@mipmap/ic_launcher',
    );
    
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      badgeNumber: 1,
    );
    
    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    
    final payload = data != null ? _buildPayload(data) : null;
    
    await _notificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  /// Build notification payload
  String _buildPayload(Map<String, dynamic> data) {
    return data.entries
        .map((entry) => '${entry.key}=${entry.value}')
        .join('&');
  }

  /// Send notification to user (stores locally and shows notification)
  Future<void> sendNotification({
    required String userId,
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    // For local mode, we just show the notification
    // In Firebase mode, we would also store it in Firestore
    
    // Show local notification
    await showNotification(
      title: title,
      body: body,
      data: data,
    );
  }

  /// Schedule a notification
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
    Map<String, dynamic>? data,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'faith_mission_channel',
      'Faith Mission Notifications',
      channelDescription: 'Notifications for Faith Mission app',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      icon: '@mipmap/ic_launcher',
    );
    
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      badgeNumber: 1,
    );
    
    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
    
    final payload = data != null ? _buildPayload(data) : null;
    
    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      notificationDetails,
      payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: 
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  /// Schedule daily notification
  Future<void> scheduleDailyNotification({
    required String userId,
    required int hour,
    required int minute,
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    final now = DateTime.now();
    final scheduledTime = DateTime(
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    
    // If scheduled time is in the past, schedule for tomorrow
    if (scheduledTime.isBefore(now)) {
      scheduledTime.add(Duration(days: 1));
    }
    
    await scheduleNotification(
      id: _generateNotificationId(userId, 'daily', hour, minute),
      title: title,
      body: body,
      scheduledTime: scheduledTime,
      data: data,
    );
  }

  /// Generate unique notification ID
  int _generateNotificationId(String userId, String type, int hour, int minute) {
    return userId.hashCode + type.hashCode + hour * 100 + minute;
  }

  /// Schedule weekly notification
  Future<void> scheduleWeeklyNotification({
    required String userId,
    required int dayOfWeek, // 1-7 (Monday-Sunday)
    required int hour,
    required int minute,
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    final now = DateTime.now();
    final daysToAdd = (dayOfWeek - now.weekday + 7) % 7;
    
    final scheduledTime = DateTime(
      now.year,
      now.month,
      now.day + daysToAdd,
      hour,
      minute,
    );
    
    await scheduleNotification(
      id: _generateNotificationId(userId, 'weekly', dayOfWeek, hour * 100 + minute),
      title: title,
      body: body,
      scheduledTime: scheduledTime,
      data: data,
    );
  }

  /// Cancel a notification
  Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id);
  }

  /// Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }

  /// Get pending notifications
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return _notificationsPlugin.pendingNotificationRequests();
  }

  // ============ READING REMINDERS ============

  /// Setup default reading reminders
  Future<void> setupDefaultReadingReminders(String userId) async {
    // Morning reminder (9 AM)
    await scheduleDailyNotification(
      userId: userId,
      hour: 9,
      minute: 0,
      title: 'Good Morning!',
      body: 'Start your day with God\'s Word. Read your Bible now!',
      data: {'type': 'reading_reminder', 'time': 'morning'},
    );
    
    // Evening reminder (6 PM)
    await scheduleDailyNotification(
      userId: userId,
      hour: 18,
      minute: 0,
      title: 'Evening Bible Reading',
      body: 'Take time to read the Bible before the day ends!',
      data: {'type': 'reading_reminder', 'time': 'evening'},
    );
    
    // Night reminder (9 PM)
    await scheduleDailyNotification(
      userId: userId,
      hour: 21,
      minute: 0,
      title: 'Bedtime Bible Reading',
      body: 'End your day with God\'s Word. Read before you sleep!',
      data: {'type': 'reading_reminder', 'time': 'night'},
    );
  }

  /// Setup custom reading reminders based on user's preferred times
  Future<void> setupCustomReadingReminders({
    required String userId,
    required List<int> hours,
    required List<int> minutes,
  }) async {
    // Cancel existing reminders
    await cancelUserReadingReminders(userId);
    
    // Setup new reminders
    for (int i = 0; i < hours.length; i++) {
      await scheduleDailyNotification(
        userId: userId,
        hour: hours[i],
        minute: minutes[i],
        title: 'Bible Reading Time',
        body: 'It\'s time for your daily Bible reading!',
        data: {'type': 'reading_reminder', 'index': i},
      );
    }
  }

  /// Cancel all reading reminders for a user
  Future<void> cancelUserReadingReminders(String userId) async {
    final pending = await getPendingNotifications();
    
    for (final notification in pending) {
      if (notification.payload != null) {
        final data = _parsePayload(notification.payload!);
        if (data['type'] == 'reading_reminder') {
          await cancelNotification(notification.id);
        }
      }
    }
  }

  /// Send reading streak notification
  Future<void> sendReadingStreakNotification(String userId, int streak) async {
    String title;
    String body;
    
    switch (streak) {
      case 3:
        title = '3-Day Streak!';
        body = 'You have read the Bible for 3 consecutive days. Keep going!';
        break;
      case 7:
        title = '7-Day Streak!';
        body = 'You have read the Bible for 7 consecutive days. You are now a Believer!';
        break;
      case 14:
        title = '2-Week Streak!';
        body = 'You have read the Bible for 14 consecutive days. Amazing!';
        break;
      case 30:
        title = '30-Day Streak!';
        body = 'You have read the Bible for 30 consecutive days. You are now a Preacher!';
        break;
      case 90:
        title = '3-Month Streak!';
        body = 'You have read the Bible for 90 consecutive days. Incredible!';
        break;
      case 365:
        title = '1-Year Streak!';
        body = 'You have read the Bible for 1 year. You are now a Shepherd!';
        break;
      default:
        if (streak % 30 == 0) {
          title = '${streak}-Day Streak!';
          body = 'You have read the Bible for $streak consecutive days. Keep up the great work!';
        } else {
          return; // Don't notify for every single day
        }
    }
    
    await sendNotification(
      userId: userId,
      title: title,
      body: body,
      data: {'type': 'streak', 'streak': streak.toString()},
    );
  }

  /// Send milestone notification
  Future<void> sendMilestoneNotification({
    required String userId,
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    await sendNotification(
      userId: userId,
      title: title,
      body: body,
      data: {
        ...?data,
        'type': 'milestone',
      },
    );
  }

  /// Send role promotion notification
  Future<void> sendRolePromotionNotification({
    required String userId,
    required String newRole,
  }) async {
    await sendNotification(
      userId: userId,
      title: 'Congratulations!',
      body: 'You have been promoted to $newRole!',
      data: {
        'type': 'role_promotion',
        'role': newRole,
      },
    );
  }

  /// Send bishop eligibility notification
  Future<void> sendBishopEligibilityNotification(String userId) async {
    await sendNotification(
      userId: userId,
      title: 'Bishop Eligibility!',
      body: 'You now have 1000+ followers and are eligible to become a Bishop!',
      data: {
        'type': 'bishop_eligibility',
      },
    );
  }

  /// Send new message notification
  Future<void> sendNewMessageNotification({
    required String userId,
    required String roomId,
    required String senderName,
    required String messagePreview,
  }) async {
    await sendNotification(
      userId: userId,
      title: 'New Message',
      body: '$senderName: $messagePreview',
      data: {
        'type': 'new_message',
        'roomId': roomId,
        'senderName': senderName,
      },
    );
  }

  /// Send new blog post notification
  Future<void> sendNewBlogPostNotification({
    required String userId,
    required String postId,
    required String authorName,
    required String postTitle,
  }) async {
    await sendNotification(
      userId: userId,
      title: 'New Blog Post',
      body: '$authorName published: $postTitle',
      data: {
        'type': 'new_post',
        'postId': postId,
        'authorName': authorName,
      },
    );
  }

  // ============ NOTIFICATION PREFERENCES ============

  /// Update notification preferences
  Future<void> updateNotificationPreferences({
    required String userId,
    required Map<String, bool> preferences,
  }) async {
    await _localStorageService.updateUser(userId, {
      'preferences': {'notifications': preferences},
      'updatedAt': DateTime.now(),
    });
  }

  /// Get notification preferences
  Future<Map<String, bool>> getNotificationPreferences(String userId) async {
    final user = await _localStorageService.getUser(userId);
    
    if (user == null) {
      return {
        'readingReminders': true,
        'milestones': true,
        'rolePromotions': true,
        'newMessages': true,
        'newPosts': true,
        'dailyVerse': true,
      };
    }
    
    final preferences = user.preferences['notifications'] as Map<String, dynamic>?;
    
    return {
      'readingReminders': preferences?['readingReminders'] as bool? ?? true,
      'milestones': preferences?['milestones'] as bool? ?? true,
      'rolePromotions': preferences?['rolePromotions'] as bool? ?? true,
      'newMessages': preferences?['newMessages'] as bool? ?? true,
      'newPosts': preferences?['newPosts'] as bool? ?? true,
      'dailyVerse': preferences?['dailyVerse'] as bool? ?? true,
    };
  }

  // ============ DAILY VERSE NOTIFICATIONS ============

  /// Send daily verse notification
  Future<void> sendDailyVerseNotification({
    required String userId,
    required String reference,
    required String text,
  }) async {
    final preferences = await getNotificationPreferences(userId);
    if (!preferences['dailyVerse']!) return;
    
    await sendNotification(
      userId: userId,
      title: 'Daily Bible Verse',
      body: '$reference - $text',
      data: {
        'type': 'daily_verse',
        'reference': reference,
      },
    );
  }

  /// Schedule daily verse notifications for user
  Future<void> scheduleDailyVerseNotification(String userId) async {
    final preferences = await getNotificationPreferences(userId);
    if (!preferences['dailyVerse']!) return;
    
    // Schedule for 8 AM
    await scheduleDailyNotification(
      userId: userId,
      hour: 8,
      minute: 0,
      title: 'Daily Bible Verse',
      body: 'Check out today\'s daily verse!',
      data: {'type': 'daily_verse'},
    );
  }
}

// Notification types
enum NotificationType {
  readingReminder,
  milestone,
  rolePromotion,
  bishopEligibility,
  newMessage,
  newPost,
  dailyVerse,
  streak,
  warning,
  suspension,
}
