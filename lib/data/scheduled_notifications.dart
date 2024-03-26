import '../models/scheduled_notification_model.dart';

class ScheduledNotifications {
  static final ScheduledNotification _willItRainNotification = ScheduledNotification(
    0,
    'Will it rain today?',
    '',
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

  static final ScheduledNotification _dailyWeatherSummary = ScheduledNotification(
    1,
    'Today\'s weather summary',
    '',
    _nextInstanceOfTime(
      DateTime(
        0, // year
        0, // month
        0, // day
        9, // hour
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

  static void itMayRain(bool value) {
    if (value == true) {
      _willItRainNotification.body = 'It may rain today, better take an umbrella with you!';
    }
    else {
      _willItRainNotification.body = 'It is unlikely that it will rain today';
    }
  }
  
  static void setDailyWeatherSummaryHeadlineText(String text) {
    _dailyWeatherSummary.body = text;
  }
}