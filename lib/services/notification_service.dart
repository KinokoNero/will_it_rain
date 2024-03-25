import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:will_it_rain/data/scheduled_notifications.dart';
import 'package:will_it_rain/models/notification_model.dart';
import 'package:will_it_rain/models/scheduled_notification_model.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

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

    await _notificationsPlugin.initialize(initializationSettings);

    // Scheduling setup
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation(await FlutterTimezone.getLocalTimezone()));
  }

  /*Future<void> showNotification(Notification notification) async {
    await notificationsPlugin.show(
        notification.id,
        notification.title,
        notification.body,
        notificationDetails
    );
  }*/

  static Future<void> _scheduleNotification(Notification notification, DateTime scheduledDateTime) async {
    await _notificationsPlugin.zonedSchedule(
        notification.id,
        notification.title,
        notification.body,
        tz.TZDateTime.from(scheduledDateTime, tz.local),
        const NotificationDetails(
            android: AndroidNotificationDetails('main_channel', 'Main Channel'),
            iOS: DarwinNotificationDetails(),
        ),
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time
    );
  }

  static Future<void> scheduleNotifications() async {
    for (ScheduledNotification scheduledNotification in ScheduledNotifications.scheduledNotifications) {
      await _scheduleNotification(scheduledNotification, scheduledNotification.scheduledTime);
    }
  }
}