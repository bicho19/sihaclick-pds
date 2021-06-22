import 'dart:convert';
import 'dart:math';

import 'package:sihaclik/helpers/hashed.dart';

class Notifications {
  static Future<String> get notifications async => jsonEncode([
        for (final _ in List(11).asMap().keys)
          {
            'id': '#' + Random().nextInt(100000).toString(),
            'title': Hashed.words(2),
            'description': Hashed.words(3),
            'type': [
              'check',
              'cancel',
              'new',
              'time',
            ][Random().nextInt(4)],
            'date': DateTime.now()
                .subtract(
                  Duration(
                    days: Random().nextInt(10),
                  ),
                )
                .toIso8601String(),
          }
      ]);
}
