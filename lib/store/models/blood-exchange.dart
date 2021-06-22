import 'package:sihaclik/store/models/user.dart';
/*
{
        "id": 4,
        "type": 1,
        "created_at": "2020-09-14T20:50:41.000Z",
        "user_id": 7,
        "user": UserObject,
        "blood_donnation": {
            "id": 1,
            "donnation_id": 4,
            "require": 1,
            "emergency": 1
        }
    }
 */

enum BloodStatus { ACTIVE, MATERIALIZED, SUSPENDED }

class BloodExchange {
  final int id;
  final DateTime createdAt;
  final User user;
  final bool require;
  final bool emergency;
  final BloodStatus status;

  BloodExchange({
    this.id,
    this.createdAt,
    this.user,
    this.emergency,
    this.require,
    this.status,
  });

  factory BloodExchange.publicFromJson({Map<String, dynamic> data}) {
    return BloodExchange(
      id: data['id'] ?? 0,
      user: User.fromJson(data['user'] as Map<String, dynamic>),
      createdAt: DateTime.parse(data['created_at'].toString()),
      require:
          (data['blood_donnation'])['require'].toString() == "1" ? true : false,
      emergency: (data['blood_donnation'])['emergency'].toString() == "1"
          ? true
          : false,
      status: BloodStatus.ACTIVE,
    );
  }
}
