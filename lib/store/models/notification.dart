import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable()
class Notification {
  final String id;
  final String title;
  final String description;
  final String image;
  final DateTime date;
  final String type;

  const Notification({
    @required this.id,
    @required this.title,
    @required this.description,
    this.image,
    @required this.date,
    @required this.type,
  });

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationToJson(this);
}
