import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotifications {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  static final LocalNotifications _localNotifications =
      LocalNotifications._internal();

  factory LocalNotifications() {
    return _localNotifications;
  }

  LocalNotifications._internal();

  Future init({
    Future Function(String) select,
    Future Function(int id, String title, String body, String payload) receive,
  }) async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    final initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/sihaclik_icon');
    final initializationSettingsIOS =
        IOSInitializationSettings(onDidReceiveLocalNotification: receive);
    final initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: select,
    );
  }

  Future showDailyAtTimes({
    @required int id,
    @required List<TimeOfDay> times,
    @required String title,
    @required String content,
  }) async {
    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'daily_at_time',
      'Daily at time channel',
      '',
    );
    final iOSPlatformChannelSpecifics = IOSNotificationDetails();
    final platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    for (final time in times)
      await flutterLocalNotificationsPlugin.showDailyAtTime(
        id + time.hour * 60 + time.minute,
        title,
        content + " ${time.hour} ${time.minute}",
        Time(time.hour, time.minute, 0),
        platformChannelSpecifics,
      );
  }

  Future<List<String>> get notifications async =>
      (await flutterLocalNotificationsPlugin.pendingNotificationRequests())
          .map((notification) =>
              "#${notification.id}: ${notification.title} - ${notification.body}")
          .toList();

  Future cancelAll() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future cancel(int id, {@required List<TimeOfDay> times}) async {
    for (final time in times)
      await flutterLocalNotificationsPlugin.cancel(
        id + time.hour * 60 + time.minute,
      );
  }
}
