import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

class Notifications {
  Future<void> createNotification(BuildContext context, String title,
      String description, NotificationCalendar calendar) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'basic_channel',
        title: title,
        body: description,
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: calendar,
    );
  }
}
