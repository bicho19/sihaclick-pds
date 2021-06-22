import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sihaclik/store/models/professional.dart';

part 'professional-types.g.dart';

@JsonSerializable()
class ProfessionalTypes {
  @JsonKey(required: true)
  final String id;

  @JsonKey(required: true)
  final String title;

  @JsonKey(required: true)
  final List<Professional> professionals;

  ProfessionalTypes({
    @required this.id,
    @required this.title,
    @required this.professionals,
  });

  factory ProfessionalTypes.fromJson(Map<String, dynamic> json) =>
      _$ProfessionalTypesFromJson(json);

  Map<String, dynamic> toJson() => _$ProfessionalTypesToJson(this);
}
