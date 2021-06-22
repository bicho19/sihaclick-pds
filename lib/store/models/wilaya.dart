import 'package:flutter/foundation.dart';
import 'package:sihaclik/store/models/town.dart';

class Wilaya {
  final int id;
  final int code;
  final String nom;
  final List<Town> communes;

  Wilaya({
    @required this.id,
    @required this.code,
    @required this.nom,
    @required this.communes,
  });

  factory Wilaya.fromJson(Map<String, dynamic> json) {
    if (json != null && json['id'] != null)
      return Wilaya(
        id: int.parse(json['id'].toString()),
        code: int.parse(json['code'].toString()),
        nom: json['nom'],
        communes: (json['communes'] as List)
            ?.map((e) =>
                e == null ? null : Town.fromJson(e as Map<String, dynamic>))
            ?.toList(),
      );
    else
      return null;
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': this.id,
      'code': this.code,
      'nom': this.nom,
      'communes': this.communes?.map((e) => e?.toJson())?.toList(),
    };
  }
}
