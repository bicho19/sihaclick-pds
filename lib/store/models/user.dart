import 'package:json_annotation/json_annotation.dart';
import 'package:sihaclik/store/models/blood_group.dart';
import 'package:sihaclik/store/models/chaab.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String name;
  final String lastname;
  final String email;
  final String phone;
  final String password;
  final String confirm;
  final Chaab chaab;
  final int type;
  final int photoId;
  final DateTime createdAt;
  final BloodGroup bloodGroup;

  User({
    this.id,
    this.name,
    this.lastname,
    this.email,
    this.phone,
    this.password,
    this.confirm,
    this.chaab,
    this.type,
    this.photoId,
    this.createdAt,
    this.bloodGroup,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'] != null ? int.parse(json['id'].toString()) : 0,
        name: json['name'] != null ? json['name'] : "",
        lastname: json['lastname'] != null ? json['lastname'] : "",
        email: json['email'] != null ? json['email'] : "",
        phone: json['phone'] != null ? json['phone'] : "No Phone",
        password: json['password'] != null ? json['password'] : "",
        confirm: json['confirm'] != null ? json['confirm'] : "",
        photoId: json['photo_id'] != null ? json["photo_id"] : 0,
        type: json['type'] != null ? json['type'] : 0,
        chaab: json['chaab'] == null
            ? null
            : Chaab.fromJson(json['chaab'] as Map<String, dynamic>),
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json["created_at"]),
        bloodGroup: json['blood_group'] == null
            ? null
            : BloodGroup.fromJson(json['blood_group'] as Map<String, dynamic>));
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': this.id,
      'name': this.name,
      'lastname': this.lastname,
      'email': this.email,
      'phone': this.phone,
      'password': this.password,
      'confirm': this.confirm,
      'chaab': this.chaab?.toJson(),
    };
  }

  User copyWith({
    String id,
    String name,
    String lastname,
    String email,
    String phone,
    String password,
    String confirm,
    Chaab chaab,
  }) {
    return User(
      name: name ?? this.name,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      confirm: confirm ?? this.confirm,
      chaab: chaab ?? this.chaab,
    );
  }

  Map<String, dynamic> saveToJson() {
    return <String, dynamic>{
      "name": this.name,
      "lastname": this.lastname,
      "email": this.email,
      "phone": this.phone
    };
  }
}
