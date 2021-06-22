// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reminder _$ReminderFromJson(Map<String, dynamic> json) {
  return Reminder(
    id: json['id'] as int,
    startAt: json['startAt'] == null
        ? null
        : DateTime.parse(json['startAt'] as String),
    times: _timesFromJson(json['times'] as String),
    weeks: json['weeks'] as int,
    medicine: json['medicine'] == null ? null : null,
    // : Medicine.fromJson(json['medicine'] as Map<String, dynamic>),
    enabled: json['enabled'] as bool,
  );
}

Map<String, dynamic> _$ReminderToJson(Reminder instance) => <String, dynamic>{
      'id': instance.id,
      'startAt': instance.startAt?.toIso8601String(),
      'times': _timesToJson(instance.times),
      'weeks': instance.weeks,
      'medicine': instance.medicine,
      'enabled': instance.enabled,
    };
