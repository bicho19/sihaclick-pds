import 'package:flutter/foundation.dart';
import 'package:sihaclik/store/models/user.dart';

class BookExchange {
  /*
{
        "id": 2,
        "type": 2,
        "created_at": "2020-09-14T20:50:35.000Z",
        "user_id": 7,
        "user": USER Object,
        "matter_donnation": {
            "id": 2,
            "donnation_id": 2,
            "name": "livre de medecin",
            "image_id": 2,
            "quantity": 1,
            "type": 1,
            "approuved": 1,
            "image": {
                "id": 2,
                "name": "2020-05-26T21:41:10.650Zd3e9acf1c6e858ca94bdf5e1b20e06d0.jpg",
                "path": "uploads/2020-05-26T21:41:10.650Zd3e9acf1c6e858ca94bdf5e1b20e06d0.jpg"
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
  final BookStatus bookStatus;
  final String imgPath;

  BookExchange({
    this.id,
    @required this.name,
    @required this.quantity,
    this.isApproved,
    @required this.imageName,
    @required this.user,
    @required this.createdAt,
    this.bookStatus,
    this.imgPath,
  });

  factory BookExchange.publicFromJson({Map<String, dynamic> data}) {
    return BookExchange(
        id: data['id'] ?? 0,
        name: (data['matter_donnation'])['name'] ?? "",
        quantity: (data['matter_donnation'])['quantity'] ?? 0,
        isApproved:
            int.parse((data['matter_donnation'])['approuved'].toString()) == 0
                ? false
                : true,
        imageName: ((data['matter_donnation'])['image']
            as Map<String, dynamic>)['name'],
        user: User.fromJson(data['user'] as Map<String, dynamic>),
        createdAt: DateTime.parse(data['created_at'].toString()),
        bookStatus: BookStatus.ACTIVE,
        imgPath: "");
  }
}

enum BookStatus { ACTIVE, MATERIALIZED, SUSPENDED }
