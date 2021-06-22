// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'writing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Writing _$WritingFromJson(Map<String, dynamic> json) {
  return Writing(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    image: json['image'] as String,
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    content: json['content'] as String,
    author: json['author'] as String,
  );
}

Map<String, dynamic> _$WritingToJson(Writing instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'date': instance.date?.toIso8601String(),
      'content': instance.content,
      'author': instance.author,
    };
