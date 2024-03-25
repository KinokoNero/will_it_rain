import 'package:will_it_rain/models/notification_model.dart';
import 'package:timezone/timezone.dart' as tz;

class ScheduledNotification extends Notification {
  final DateTime scheduledTime;

  ScheduledNotification(super.id, super.title, super.body, this.scheduledTime);
}