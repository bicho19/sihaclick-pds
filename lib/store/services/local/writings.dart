import 'dart:convert';
import 'dart:math';

import 'package:sihaclik/helpers/hashed.dart';

class Writings {
  static Future<String> get writings async => jsonEncode([
        for (final index in List(7).asMap().keys)
          {
            'id': '$index',
            'title': Hashed.words(3),
            'description': Hashed.words(6),
            'image': "assets/images/generic5.jpg",
            'date': DateTime.now()
                .add(
                  Duration(days: Random().nextInt(99)),
                )
                .toIso8601String(),
            'content': Hashed.words(300),
            'author': Hashed.words(2),
          }
      ]);
  static Future<String> get events async => jsonEncode([
        for (final index in List(7).asMap().keys)
          {
            'id': '$index',
            'title': Hashed.words(3),
            'description': Hashed.words(6),
            'image': "assets/images/generic5.jpg",
            'date': DateTime.now()
                .add(
                  Duration(days: Random().nextInt(99)),
                )
                .toIso8601String(),
            'location': Hashed.words(3),
          }
      ]);
}
