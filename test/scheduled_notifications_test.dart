import 'package:flutter_test/flutter_test.dart';
import 'package:will_it_rain/data/scheduled_notifications.dart';

void main() {
  group('ScheduledNotifications Tests', () {
    test('itMayRain should set correct notification body when it may rain', () {
      final notificationBodyBeforeItMayRain = ScheduledNotifications.scheduledNotifications[0].body;
      ScheduledNotifications.itMayRain(true);
      final notificationBodyAfterItMayRain = ScheduledNotifications.scheduledNotifications[0].body;

      expect(notificationBodyBeforeItMayRain.contains('It may rain today, better take an umbrella with you!'), false);

      expect(notificationBodyAfterItMayRain.contains('It is unlikely that it will rain today'), false);
      expect(notificationBodyAfterItMayRain.contains('It may rain today, better take an umbrella with you!'), true);
    });

    test('itMayRain should set correct notification body when it may not rain', () {
      final notificationBodyBeforeItMayRain = ScheduledNotifications.scheduledNotifications[0].body;
      ScheduledNotifications.itMayRain(false);
      final notificationBodyAfterItMayRain = ScheduledNotifications.scheduledNotifications[0].body;

      expect(notificationBodyBeforeItMayRain.contains('It is unlikely that it will rain today'), false);

      expect(notificationBodyAfterItMayRain.contains('It may rain today, better take an umbrella with you!'), false);
      expect(notificationBodyAfterItMayRain.contains('It is unlikely that it will rain today'), true);
    });
  });
}
