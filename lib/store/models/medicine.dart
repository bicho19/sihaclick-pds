import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Medicine {
  final String title;
  final String description;
  final String image;

  const Medicine({
    @required this.title,
    @required this.description,
    this.image,
  });

// factory Medicine.fromJson(Map<String, dynamic> json) =>
//     _$MedicineFromJson(json);
//
// Map<String, dynamic> toJson() => _$MedicineToJson(this);
}
