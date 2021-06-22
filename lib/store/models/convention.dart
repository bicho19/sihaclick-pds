import 'package:flutter/material.dart';

class Convention {
  /*
    {
        "id": 3,
        "name": "CAMSSP"
    }
   */
  final int id;
  final String name;

  Convention({
    @required this.id,
    @required this.name,
  });

  factory Convention.fromJson({Map<String, dynamic> data}) {
    return Convention(
      id: data['id'] ?? 0,
      name: data['name'] ?? "",
    );
  }

  @override
  String toString() {
    return "Convention: {'id': $id, 'name': $name } ";
  }
}
