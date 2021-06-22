import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'writing.g.dart';

@JsonSerializable()
class Writing {
  final String id;
  final String title;
  final String description;
  final String image;
  final DateTime date;
  final String content;
  final String author;

  const Writing({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.image,
    @required this.date,
    @required this.content,
    @required this.author,
  });

  factory Writing.fromJson(Map<String, dynamic> json) =>
      _$WritingFromJson(json);

  Map<String, dynamic> toJson() => _$WritingToJson(this);
}
