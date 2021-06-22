import 'package:sihaclik/store/models/wilaya.dart';

class Town {
  final int id;
  final String code_postal;
  final String nom;
  final int wilaya_id;
  final Wilaya wilaya;

  Town({
    this.id,
    this.code_postal,
    this.nom,
    this.wilaya_id,
    this.wilaya,
  });

  factory Town.fromJson(Map<String, dynamic> json) {
    return Town(
      id: json['id'] != null ? int.parse(json["id"].toString()) : 0,
      code_postal: json['code_postal'],
      nom: json['nom'],
      wilaya_id: json['wilaya_id'] != null
          ? int.parse(json['wilaya_id'].toString())
          : 0,
      wilaya: json['wilaya'] != null
          ? Wilaya.fromJson(json['wilaya'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': this.id,
      'code_postal': this.code_postal,
      'nom': this.nom,
      'wilaya_id': this.wilaya_id,
    };
  }

  Town copyWith({
    int id,
    String code_postal,
    String nom,
    int wilaya_id,
  }) {
    return Town(
      id: id ?? this.id,
      code_postal: code_postal ?? this.code_postal,
      nom: nom ?? this.nom,
      wilaya_id: wilaya_id ?? this.wilaya_id,
    );
  }
}
