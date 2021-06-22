import 'package:sihaclik/store/models/address.dart';
import 'package:sihaclik/store/models/blood_group.dart';
import 'package:sihaclik/store/models/language.dart';
import 'package:sihaclik/store/models/pds_options.dart';
import 'package:sihaclik/store/models/user.dart';

class ProfessionalDS {
  final int userId;
  final String name;
  final String lastname;
  final String email;
  final int type;
  final DateTime createdAt;
  final BloodGroup bloodGroup;
  final int pdsId;
  final String fixNumber;
  final String faxNumber;
  final String gender;
  final Address address;
  final List<Language> languages;
  final PDSOptions pdsOptions;

  ProfessionalDS({
    this.userId,
    this.name,
    this.lastname,
    this.email,
    this.type,
    this.createdAt,
    this.bloodGroup,
    this.pdsId,
    this.fixNumber,
    this.faxNumber,
    this.gender,
    this.address,
    this.languages,
    this.pdsOptions,
  });

  factory ProfessionalDS.fromJson({Map<String, dynamic> data}) {
    return ProfessionalDS(
        userId: data['id'] ?? 0,
        name: data['name'] ?? "",
        lastname: data['lastname'] ?? "",
        email: data['email'] ?? "",
        pdsId: (data['pds'] as Map<String, dynamic>)['id'] ?? 0,
        fixNumber: (data['pds'] as Map<String, dynamic>)['fix'] ?? "",
        faxNumber: (data['pds'] as Map<String, dynamic>)['fax'] ?? "",
        address:
            Address.fromJson((data['pds'] as Map<String, dynamic>)['address']),
        languages: ((data['pds'] as Map<String, dynamic>)["languages"] as List)
            ?.map((e) =>
                e == null ? null : Language.fromJson(e as Map<String, dynamic>))
            ?.toList(),
        pdsOptions: PDSOptions.fromJson(
            data: (data['pds'] as Map<String, dynamic>)['pds_options']));
  }

/*
     {
        "id": 5,
        "name": "mehdi",
        "lastname": "chebbah",
        "email": "mehdi@gmail.com",
        "phone": "0698428070",
        "type": 1,
        "photo_id": null,
        "blood_group_id": 3,
        "created_at": "2020-08-11T09:21:05.000Z",
        "blood_group": {
            "id": 3,
            "group": "AB",
            "rhesus": 1
        },
        "pds": {
            "id": 1,
            "address_id": 2,
            "fix": "0549086222",
            "fax": "0549086222",
            "bio": null,
            "gender": 1,
            "cover_id": 6,
            "user_id": 5,
            "pds_type_id": 1,
            "address": {
                "id": 2,
                "address": "5 juillet",
                "commune_id": 675,
                "commune": {
                    "id": 675,
                    "code_postal": "19001",
                    "nom": "Setif",
                    "wilaya_id": 19,
                    "wilaya": {
                        "id": 19,
                        "code": 19,
                        "nom": "Sétif"
                    }
                }
            },
            "cover": {
                "id": 6,
                "name": "2020-05-26T22:31:59.692Zpharmacie.jpg",
                "path": "uploads/2020-05-26T22:31:59.692Zpharmacie.jpg"
            },
            "work_time": [
                {
                    "day": "Mon",
                    "start": "07:00:00",
                    "end": "14:30:00"
                },
                {
                    "day": "Tue",
                    "start": "08:00:00",
                    "end": "14:30:00"
                },
                {
                    "day": "Wed",
                    "start": "08:00:00",
                    "end": "16:00:00"
                },
                {
                    "day": "Thu",
                    "start": "08:00:00",
                    "end": "17:00:00"
                },
                {
                    "day": "Fri",
                    "start": "08:00:00",
                    "end": "08:00:00"
                },
                {
                    "day": "Sat",
                    "start": "08:00:00",
                    "end": "17:00:00"
                },
                {
                    "day": "Sun",
                    "start": "08:00:00",
                    "end": "16:00:00"
                }
            ],
            "pds_options": PDSOption
            },
            "occupied_posts": [
                {
                    "id": 1,
                    "name": "doctor chez mahabi",
                    "start": "2012",
                    "end": "2020",
                    "pds_id": 1
                }
            ],
            "type": {
                "id": 1,
                "name": "Médecin",
                "appointment": 1
            }
        }
    }
   */
}
