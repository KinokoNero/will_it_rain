import 'package:timezone/timezone.dart' as tz;

import '../models/scheduled_notification_model.dart';

class ScheduledNotifications {
  static final List<ScheduledNotification> scheduledNotifications = [
    ScheduledNotification(
        0,
        'Prognoza pogody',
        'Dzisiaj nie będzie padać.',
        _nextInstanceOfTime(
            DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
                18,//8,
                13//0
            )
        )
    ),
  ];

  static tz.TZDateTime _nextInstanceOfTime(DateTime scheduleTime) {
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
  }
}