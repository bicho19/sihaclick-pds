import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sihaclik/store/models/medicine.dart';

part 'reminder.g.dart';

@JsonSerializable()
class Reminder {
  final int id;
  final DateTime startAt;
  @JsonKey(fromJson: _timesFromJson, toJson: _timesToJson)
  final List<TimeOfDay> times;
  final int weeks;
  final Medicine medicine;
  bool enabled;

  Reminder({
    @required this.id,
    @required this.startAt,
    @required this.times,
    @required this.weeks,
    @required this.medicine,
    this.enabled = true,
  });

  factory Reminder.fromJson(Map<String, dynamic> json) =>
      _$ReminderFromJson(json);

  Map<String, dynamic> toJson() => _$ReminderToJson(this);
}

List<TimeOfDay> _timesFromJson(String json) => jsonDecode(json).map(
      (time) => TimeOfDay(
        hour: time['hour'],
        minute: time['minute'],
      ),
    );

String _timesToJson(List<TimeOfDay> times) => jsonEncode(
      times.map(
        (time) => {
          'hour': time.hour,
          'minute': time.hour,
        },
      ),
    );
