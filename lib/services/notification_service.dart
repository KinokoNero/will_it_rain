import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:will_it_rain/data/scheduled_notifications.dart';
import 'package:will_it_rain/models/notification_model.dart';
import 'package:will_it_rain/models/scheduled_notification_model.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // Notifications setup
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings(
        'will_it_rain_icon');
    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {}
    );
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS
    );

    await notificationsPlugin.initialize(
        initializationSettings,
        //onDidReceiveBackgroundNotificationResponse: (NotificationResponse notificationResponse) async {}
    );

    // Scheduling setup
    tz.initializeTimeZones();
    scheduleNotifications();
  }

  notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails('main_channel', 'Main Channel'),
      iOS: DarwinNotificationDetails()
    );
  }

  Future<void> showNotification(Notification notification) async {
    await notificationsPlugin.show(
        notification.id,
        notification.title,
        notification.body,
        const NotificationDetails(
            android: AndroidNotificationDetails('main_channel', 'Main Channel'),
            iOS: DarwinNotificationDetails()
        )
    );
  }

  Future<void> scheduleNotification(Notification notification, DateTime scheduledDateTime) async {
    print(tz.TZDateTime.now(tz.local).add(const Duration(hours: 1, seconds: 15)));
    await notificationsPlugin.zonedSchedule(
        notification.id,
        notification.title,
        notification.body,
        tz.TZDateTime.now(tz.local).add(const Duration(hours: 1, seconds: 15)),//tz.TZDateTime.from(scheduledDateTime, tz.local),
        const NotificationDetails(
            android: AndroidNotificationDetails('main_channel', 'Main Channel'),
            iOS: DarwinNotificationDetails()
        ),
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime
    );
  }

  scheduleNotifications() async {
    for (ScheduledNotification scheduledNotification in ScheduledNotifications.scheduledNotifications) {
      await scheduleNotification(scheduledNotification, scheduledNotification.scheduledTime);
    }
  }
}