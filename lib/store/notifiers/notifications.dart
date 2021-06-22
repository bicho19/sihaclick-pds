import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sihaclik/store/models/notification.dart';
import 'package:sihaclik/store/services/local/notifications.dart';

class NotificationsNotifier with ChangeNotifier {
  List<Notification> _notifications = [];
  List<Notification> get notifications => _notifications;
  init() async {
    final encoded = await Notifications.notifications;
    final List<dynamic> decoded = jsonDecode(encoded);
    _notifications = decoded.map((d) => Notification.fromJson(d)).toList();
    notifyListeners();
  }
}
