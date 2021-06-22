import 'package:sihaclik/store/models/address.dart';

class Chaab {
  final int id;
  // ignore: non_constant_identifier_names
  final bool blood_notification;
  final bool language;
  final Address address;
  final bool banned;

  Chaab(
      {this.id,
      // ignore: non_constant_identifier_names
      this.blood_notification,
      this.language,
      this.address,
      this.banned});

  factory Chaab.fromJson(Map<String, dynamic> json) {
    return Chaab(
      id: json['id'] ?? json['id'],
      blood_notification: json['blood_notification'] == 0 ? false : true,
      language: json['language'] == 0 ? false : true,
      banned: json['banned'] == 0 ? false : true,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'blood_notification': this.blood_notification,
      'language': this.language,
      'address': this.address.toJson(),
    };
  }

  Chaab copyWith({bool bloodNotification, bool language, Address address}) {
    return Chaab(
      blood_notification: bloodNotification ?? this.blood_notification,
      language: language ?? this.language,
      address: address ?? this.address,
    );
  }
}
