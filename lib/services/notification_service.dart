import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:justdoit/models/task.dart';
import 'package:path/path.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void initializeNotifications() {
  const InitializationSettings initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    iOS: DarwinInitializationSettings(),
  );

  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) async {
      if (response.payload != null) {
        Navigator.of(context as BuildContext).pushNamed('/taskList');
      }
    },
  );
}

void initializeTimeZones() {
  tz.initializeTimeZones();
}

Future<void> scheduleNotification(Task task) async {
  if (task.deadline != null) {
    final scheduledDate = tz.TZDateTime.from(task.deadline!, tz.local);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      task.id as int,
      'Напоминание о задаче',
      'Срок выполнения задачи "${task.title}" приближается!',
      scheduledDate,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel id',
          'your channel name',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
