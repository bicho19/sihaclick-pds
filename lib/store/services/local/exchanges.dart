import 'dart:convert';
import 'dart:math';

import 'package:sihaclik/helpers/hashed.dart';

class Exchanges {
  static Future<String> get bloods async => jsonEncode([
        for (final index in List(Random().nextInt(90) + 9).asMap().keys)
          {
            'group': ['A', 'B', 'AB', 'O'][Random().nextInt(3)],
            'type': ['Positive', 'Negative'][Random().nextInt(1)],
            'wilaya': {
              'id': '$index',
              'code': '$index',
              'name': Hashed.words(1),
            },
            'town': {
              'id': '$index',
              'code': '$index',
              'name': Hashed.words(1),
            },
            'date': DateTime.now()
                .subtract(
                  Duration(days: Random().nextInt(99)),
                )
                .toIso8601String(),
            'phone': '0' + Hashed.numbers(9),
            'urgent': false,
          }
      ]);
  static Future<String> get medicines async => jsonEncode([
        for (final index in List(Random().nextInt(90) + 9).asMap().keys)
          {
            'title': Hashed.words(1),
            'image': null,
            'date': DateTime.now()
                .subtract(
                  Duration(days: Random().nextInt(99)),
                )
                .toIso8601String(),
            'molecule': Hashed.words(1),
            'dosage': Hashed.words(1),
            'experation': DateTime.now()
                .add(
                  Duration(days: Random().nextInt(99)),
                )
                .toIso8601String(),
            'wilaya': {
              'id': '$index',
              'code': '$index',
              'name': Hashed.words(1),
            },
            'town': {
              'id': '$index',
              'code': '$index',
              'name': Hashed.words(1),
            },
            'phone': '+' + Hashed.numbers(9),
          }
      ]);

  static Future<String> get books async {
    return jsonEncode([
      for (final index in List(Random().nextInt(90) + 9).asMap().keys)
        {
          'title': Hashed.words(1),
          'description': Hashed.words(3),
          'image': null,
          'date': DateTime.now()
              .subtract(
                Duration(days: Random().nextInt(99)),
              )
              .toIso8601String(),
          'quantity': Random().nextInt(5),
          'wilaya': {
            'id': '$index',
            'code': '$index',
            'name': Hashed.words(1),
          },
          'town': {
            'id': '$index',
            'code': '$index',
            'name': Hashed.words(1),
          },
          'phone': '+' + Hashed.words(1),
        }
    ]);
  }

  static Future<String> get materials async => jsonEncode([
        for (final index in List(Random().nextInt(90) + 9).asMap().keys)
          {
            'title': Hashed.words(1),
            'description': Hashed.words(3),
            'image': null,
            'date': DateTime.now()
                .subtract(
                  Duration(days: Random().nextInt(99)),
                )
                .toIso8601String(),
            'quantity': Random().nextInt(5),
            'wilaya': {
              'id': '$index',
              'code': '$index',
              'name': Hashed.words(1),
            },
            'town': {
              'id': '$index',
              'code': '$index',
              'name': Hashed.words(1),
            },
            'phone': '+' + Hashed.words(1),
          }
      ]);
}
