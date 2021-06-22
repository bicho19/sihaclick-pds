import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'professional.g.dart';

@JsonSerializable()
class Professional {
  @JsonKey(required: true)
  final String id;
  @JsonKey(required: true)
  final String title;
  @JsonKey(required: true)
  final String description;
  @JsonKey(required: true)
  final String phone;
  @JsonKey(required: true)
  final String fax;
  @JsonKey(required: true)
  final String email;
  @JsonKey(required: true)
  final List<String> services;
  @JsonKey(required: true)
  final bool homeConsultation;
  @JsonKey(required: true)
  final DateTime opening;
  @JsonKey(required: true)
  final List<String> holidays;
  @JsonKey(required: true)
  final bool weekend;
  @JsonKey(required: true)
  final List<String> agreements;
  @JsonKey(required: true)
  final List<Map> experience;
  @JsonKey(required: true)
  final List<Map> voluntaryActivities;
  @JsonKey(required: true)
  final List<String> languages;

  const Professional({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.phone,
    @required this.fax,
    @required this.email,
    @required this.services,
    @required this.homeConsultation,
    @required this.opening,
    @required this.holidays,
    @required this.weekend,
    @required this.agreements,
    @required this.experience,
    @required this.voluntaryActivities,
    @required this.languages,
  });

  factory Professional.fromJson(Map<String, dynamic> json) =>
      _$ProfessionalFromJson(json);

  Map<String, dynamic> toJson() => _$ProfessionalToJson(this);
}
