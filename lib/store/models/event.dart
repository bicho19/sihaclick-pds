import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable()
class Event {
  final String id;
  final String title;
  final String description;
  final String image;
  final DateTime date;
  final String location;

  const Event({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.image,
    @required this.date,
    @required this.location,
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}
