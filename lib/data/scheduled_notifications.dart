import '../models/scheduled_notification_model.dart';

class ScheduledNotifications {
  static final ScheduledNotification _willItRainNotification = ScheduledNotification(
    0,
    'Weather forecast',
    'It won\'t rain today.',
    _nextInstanceOfTime(
      DateTime(
        0, // year
        0, // month
        0, // day
        8, // hour
        0 // minute
      )
    )
  );

  static final List<ScheduledNotification> scheduledNotifications = [
    _willItRainNotification,
    _dailyWeatherSummary
  ];

  static DateTime _nextInstanceOfTime(DateTime scheduleTime) {
    DateTime now = DateTime.now();

    DateTime scheduledDate = DateTime(
      now.year,
      now.month,
      now.day,
      scheduleTime.hour,
      scheduleTime.minute
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }
  /*static tz.TZDateTime _nextInstanceOfTime(DateTime scheduleTime) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      scheduleTime.hour,
      scheduleTime.minute,
    );
    
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    
    return scheduledDate;
  }*/

  static void itWillRain(bool value) {
    if (value == true) {
      _willItRainNotification.body = 'It may rain today, better take an umbrella with you!';
    }
  }
}