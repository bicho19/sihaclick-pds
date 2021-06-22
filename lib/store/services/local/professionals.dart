import 'dart:convert';
import 'dart:math';

import 'package:sihaclik/helpers/hashed.dart';

class Professionals {
  static Future<String> get professionals async => jsonEncode([
        for (final _ in List(7).asMap().keys)
          {
            'id': '#' + Random().nextInt(100000).toString(),
            'title': Hashed.words(1),
            'professionals': [
              for (final _ in List(Random().nextInt(10) + 5).asMap().keys)
                {
                  'id': '#' + Random().nextInt(100000).toString(),
                  'title': Hashed.words(2),
                  'description': Hashed.words(5),
                  'phone': '0' + Hashed.numbers(9),
                  'fax': '0' + Hashed.numbers(9),
                  'email': '#####@######.##',
                  'services': [
                    Hashed.words(2),
                    Hashed.words(1),
                    Hashed.words(1),
                  ],
                  'homeConsultation': Random().nextBool(),
                  'opening': DateTime.now()
                      .add(
                        Duration(
                          hours: Random().nextInt(24),
                        ),
                      )
                      .toIso8601String(),
                  'holidays': [
                    Hashed.words(1),
                    Hashed.words(1),
                  ],
                  'weekend': Random().nextBool(),
                  'agreements': [
                    Hashed.words(1),
                    Hashed.words(1),
                    Hashed.words(1)
                  ],
                  'experience': [
                    for (final _ in List(3))
                      {
                        'title': Hashed.words(2),
                        'description': Hashed.words(4),
                        'image': null,
                      }
                  ],
                  'voluntaryActivities': [
                    for (final _ in List(1))
                      {
                        'title': Hashed.words(2),
                        'description': Hashed.words(4),
                        'image': null,
                      }
                  ],
                  'languages': [
                    Hashed.words(1),
                    Hashed.words(1),
                    Hashed.words(1),
                  ],
                }
            ]
          }
      ]);

  static Future<String> get favorites async => jsonEncode([
        for (final _ in List(5).asMap().keys)
          {
            'id': '#' + Random().nextInt(100000).toString(),
            'title': Hashed.words(1),
            'professionals': [
              for (final _ in List(Random().nextInt(5)).asMap().keys)
                {
                  'id': '#' + Random().nextInt(100000).toString(),
                  'title': Hashed.words(2),
                  'description': Hashed.words(5),
                  'phone': '0' + Hashed.numbers(9),
                  'fax': '0' + Hashed.numbers(9),
                  'email': '#####@######.##',
                  'services': [
                    Hashed.words(2),
                    Hashed.words(1),
                    Hashed.words(1),
                  ],
                  'homeConsultation': Random().nextBool(),
                  'opening': DateTime.now()
                      .add(
                        Duration(
                          hours: Random().nextInt(24),
                        ),
                      )
                      .toIso8601String(),
                  'holidays': [
                    Hashed.words(1),
                    Hashed.words(1),
                  ],
                  'weekend': Random().nextBool(),
                  'agreements': [
                    Hashed.words(1),
                    Hashed.words(1),
                    Hashed.words(1)
                  ],
                  'experience': [
                    for (final _ in List(3))
                      {
                        'title': Hashed.words(2),
                        'description': Hashed.words(4),
                        'image': null,
                      }
                  ],
                  'voluntaryActivities': [
                    for (final _ in List(1))
                      {
                        'title': Hashed.words(2),
                        'description': Hashed.words(4),
                        'image': null,
                      }
                  ],
                  'languages': [
                    Hashed.words(1),
                    Hashed.words(1),
                    Hashed.words(1),
                  ],
                }
            ]
          }
      ]);
}
