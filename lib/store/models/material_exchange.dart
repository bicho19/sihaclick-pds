import 'package:sihaclik/store/models/user.dart';

enum MaterialStatus { ACTIVE, MATERIALIZED, SUSPENDED }

class MaterialExchange {
  /*
   {
        "id": 3,
        "type": 2,
        "created_at": "2020-09-14T20:50:38.000Z",
        "user_id": 7,
        "user": UserObject,
        "matter_donnation": {
            "id": 3,
            "donnation_id": 3,
            "name": "material medical",
            "image_id": 3,
            "quantity": 15,
            "type": 0,
            "approuved": 1,
            "image": {
                "id": 3,
                "name": "2020-05-26T21:41:20.266Zmaterial.jpg",
                "path": "uploads/2020-05-26T21:41:20.266Zmaterial.jpg"
            }
        }
    }
   */
  final int id;
  final String name;
  final int quantity;
  final bool isApproved;
  final String imageName;
  final DateTime createdAt;
  final User user;
  final String imgPath;
  final MaterialStatus status;

  MaterialExchange({
    this.id,
    this.name,
    this.quantity,
    this.isApproved,
    this.imageName,
    this.createdAt,
    this.user,
    this.imgPath,
    this.status,
  });

  factory MaterialExchange.publicFromJson({Map<String, dynamic> data}) {
    return MaterialExchange(
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
      status: MaterialStatus.MATERIALIZED,
    );
  }
}
