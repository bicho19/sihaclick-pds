import 'package:sihaclik/store/models/town.dart';

class Address {
  final int id;
  final String address;
  final Town commune;
  final int communeId;

  Address({this.address, this.commune, this.id, this.communeId});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'] ?? json['id'],
      address: json['address'] as String,
      communeId: json['commune_id'] ?? json['commune_id'],
      commune: json['commune'] == null
          ? null
          : Town.fromJson(json['commune'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      'address': address,
      'commune': commune.toJson(),
    };
  }
}
