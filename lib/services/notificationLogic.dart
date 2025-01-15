import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification/screens/HomeScreen.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationLogic {
  static final FlutterLocalNotificationsPlugin _notification = FlutterLocalNotificationsPlugin();
  static final BehaviorSubject<String?> onNotifications = BehaviorSubject<String?>();

  static Future<NotificationDetails> _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        "schedule_reminder", // channelId
        "Water Reminder", // channel name
        channelDescription: "Channel for water reminder notifications",
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
      ),
    );
  }

  static Future init(BuildContext context, String uid) async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings android = AndroidInitializationSettings("time_workout"); // Ensure this icon exists in res/drawable
    final InitializationSettings settings = InitializationSettings(android: android);

    await _notification.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Check if the payload is not null and cast correctly
        final String? payload = response.payload;
        if (payload != null) {
          onNotifications.add(payload);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        }
      },
    );
  }

  static Future showNotifications({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime dateTime,
  }) async {
    // Adjust dateTime to tomorrow if it is in the past
    if (dateTime.isBefore(DateTime.now())) {
      dateTime = dateTime.add(Duration(days: 1));
    }

    await _notification.zonedSchedule(
      id,
      title ?? "Reminder",
      body ?? "Don't forget to drink water",
      tz.TZDateTime.from(dateTime, tz.local),
      await _notificationDetails(),
      payload: payload,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
