import 'package:timezone/timezone.dart' as tz;
import 'package:will_it_rain/providers/weather_provider.dart';

import '../models/scheduled_notification_model.dart';

class ScheduledNotifications {
  static final ScheduledNotification _willItRainNotification = ScheduledNotification(
      0,
      'Prognoza pogody',
      '',//() ? 'Dzisiaj nie będzie padać.' : 'Dzisiaj może padać, lepiej weź ze sobą parasol!', // TODO
      _nextInstanceOfTime(
          DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              8,
              0
          )
      )
  );

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
                8,
                0
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