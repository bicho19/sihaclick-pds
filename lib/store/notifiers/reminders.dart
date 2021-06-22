import 'package:flutter/material.dart';
import 'package:sihaclik/store/models/reminder.dart';
import 'package:sihaclik/store/services/local/local-notifications.dart';

class RemindersNotifier with ChangeNotifier {
  List<Reminder> _reminders = [];
  List<Reminder> get reminders => _reminders;
  LocalNotifications _localNotifications = LocalNotifications();
  init() async {
    await _localNotifications.init(select: select, receive: receive);
  }

  Future select(String payload) async {}
  Future receive(int id, String title, String body, String payload) async {}

  Future<bool> addReminder(Reminder reminder) async {
    _reminders.add(reminder);
    notifyListeners();
    _localNotifications.showDailyAtTimes(
      id: reminder.id,
      title: reminder.medicine.title,
      content: reminder.medicine.description,
      times: reminder.times,
    );
    return true;
  }

  Future<bool> updateReminder(Reminder reminder) async {
    final index = reminders.indexWhere((element) => element.id == reminder.id);
    if (index > -1) {
      _localNotifications.cancel(reminders[index].id,
          times: reminders[index].times);
      reminders[index] = reminder;
      _localNotifications.showDailyAtTimes(
        id: reminder.id,
        title: reminder.medicine.title,
        content: reminder.medicine.description,
        times: reminder.times,
      );
      notifyListeners();
      return true;
    } else
      return false;
  }

  Future<bool> toggleReminder(Reminder reminder) async {
    final enabled = !reminder.enabled;
    if (enabled) {
      //
      _localNotifications.showDailyAtTimes(
        id: reminder.id,
        title: reminder.medicine.title,
        content: reminder.medicine.description,
        times: reminder.times,
      );
    } else {
      //
      _localNotifications.cancel(reminder.id, times: reminder.times);
    }

    reminders.singleWhere((element) => element.id == reminder.id).enabled =
        enabled;
    notifyListeners();
    return enabled;
  }

  Future<List<String>> get notifications async =>
      _localNotifications.notifications;

  Future cancelAll() async {
    await _localNotifications.cancelAll();
  }
}
