// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'professional.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Professional _$ProfessionalFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const [
    'id',
    'title',
    'description',
    'phone',
    'fax',
    'email',
    'services',
    'homeConsultation',
    'opening',
    'holidays',
    'weekend',
    'agreements',
    'experience',
    'voluntaryActivities',
    'languages'
  ]);
  return Professional(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    phone: json['phone'] as String,
    fax: json['fax'] as String,
    email: json['email'] as String,
    services: (json['services'] as List)?.map((e) => e as String)?.toList(),
    homeConsultation: json['homeConsultation'] as bool,
    opening: json['opening'] == null
        ? null
        : DateTime.parse(json['opening'] as String),
    holidays: (json['holidays'] as List)?.map((e) => e as String)?.toList(),
    weekend: json['weekend'] as bool,
    agreements: (json['agreements'] as List)?.map((e) => e as String)?.toList(),
    experience: (json['experience'] as List)
        ?.map((e) => e as Map<String, dynamic>)
        ?.toList(),
    voluntaryActivities: (json['voluntaryActivities'] as List)
        ?.map((e) => e as Map<String, dynamic>)
        ?.toList(),
    languages: (json['languages'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ProfessionalToJson(Professional instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'phone': instance.phone,
      'fax': instance.fax,
      'email': instance.email,
      'services': instance.services,
      'homeConsultation': instance.homeConsultation,
      'opening': instance.opening?.toIso8601String(),
      'holidays': instance.holidays,
      'weekend': instance.weekend,
      'agreements': instance.agreements,
      'experience': instance.experience,
      'voluntaryActivities': instance.voluntaryActivities,
      'languages': instance.languages,
    };
