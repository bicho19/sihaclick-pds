// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'professional-types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfessionalTypes _$ProfessionalTypesFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['id', 'title', 'professionals']);
  return ProfessionalTypes(
    id: json['id'] as String,
    title: json['title'] as String,
    professionals: (json['professionals'] as List)
        ?.map((e) =>
            e == null ? null : Professional.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ProfessionalTypesToJson(ProfessionalTypes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'professionals': instance.professionals,
    };
