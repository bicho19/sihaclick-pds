import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sihaclik/store/models/event.dart';
import 'package:sihaclik/store/models/writing.dart';
import 'package:sihaclik/store/services/local/writings.dart';

class WritingsNotifier with ChangeNotifier {
  List<Writing> _writings = [];
  List<Writing> get writings => _writings;
  List<Event> _events = [];
  List<Event> get events => _events;
  init() async {
    print("WritingsNotifiers init .....");
    final encodedWritings = await Writings.writings;
    final List<dynamic> decodedWritings = jsonDecode(encodedWritings);
    _writings = decodedWritings.map((d) => Writing.fromJson(d)).toList();

    final encodedEvents = await Writings.events;
    print("WritingsNotifiers events .....");
    print(encodedEvents);
    final List<dynamic> decodedEvents = jsonDecode(encodedEvents);
    _events = decodedEvents.map((d) => Event.fromJson(d)).toList();

    notifyListeners();
  }
}
