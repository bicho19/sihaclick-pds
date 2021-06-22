import 'package:sihaclik/helpers/timing.dart';
import 'package:sihaclik/store/models/user.dart';
import 'package:intl/intl.dart' as intl;

enum MedicineStatus { ACTIVE, MATERIALIZED, SUSPENDED }

/*
{
        "id": 1,
        "type": 2,
        "created_at": "2020-09-14T20:50:30.000Z",
        "user_id": 7,
        "user": UserObject,
        "matter_donnation": {
            "id": 1,
            "donnation_id": 1,
            "name": "maxilaze",
            "image_id": 1,
            "quantity": 10,
            "type": 2,
            "approuved": 1,
            "drug_donnation": {
                "id": 1,
                "matter_donnation_id": 1,
                "expired_date": "02-01-2021",
                "molecule": "H12C6O14",
                "dose": "200mg"
            },
            "image": {
                "id": 1,
                "name": "2020-05-26T21:32:50.200Zmaxilase-maux-de-gorge-sirop-125-ml-face-1.jpg",
                "path": "uploads/2020-05-26T21:32:50.200Zmaxilase-maux-de-gorge-sirop-125-ml-face-1.jpg"
            }
        }
    }
 */

class MedicineExchange {
  final int id;
  final String name;
  final int quantity;
  final bool isApproved;
  final String imageName;
  final DateTime createdAt;
  final DateTime expirationDate;
  final User user;
  final String imgPath;
  final MedicineStatus status;
  final String molecule;
  final String dose;

  MedicineExchange({
    this.id,
    this.name,
    this.quantity,
    this.isApproved,
    this.imageName,
    this.createdAt,
    this.expirationDate,
    this.user,
    this.imgPath,
    this.status,
    this.molecule,
    this.dose,
  });

  factory MedicineExchange.publicFromJson({Map<String, dynamic> data}) {
    return MedicineExchange(
      id: data['id'] ?? 0,
      name: (data['matter_donnation'])['name'] ?? "",
      quantity: (data['matter_donnation'])['quantity'] ?? 0,
      isApproved:
          int.parse((data['matter_donnation'])['approuved'].toString()) == 0
              ? false
              : true,
      imageName:
          ((data['matter_donnation'])['image'] as Map<String, dynamic>)['name'],
      user: User.fromJson(data['user'] as Map<String, dynamic>),
      createdAt: DateTime.parse(data['created_at'].toString()),
      imgPath: "",
      status: MedicineStatus.SUSPENDED,
      expirationDate: intl.DateFormat("dd-mm-yyyy").parse(
          ((data['matter_donnation'])['drug_donnation']
                  as Map<String, dynamic>)['expired_date']
              .toString()),
      molecule: ((data['matter_donnation'])['drug_donnation']
              as Map<String, dynamic>)['molecule']
          .toString(),
      dose: ((data['matter_donnation'])['drug_donnation']
              as Map<String, dynamic>)['dose']
          .toString(),
    );
  }
}
