import 'package:will_it_rain/models/notification_model.dart';

class ScheduledNotification extends Notification {
  final DateTime scheduledTime;

  ScheduledNotification(super.id, super.title, super.body, this.scheduledTime);
}