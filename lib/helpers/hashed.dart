import 'dart:math';

class Hashed {
  static String words(int count) => List(count)
      .map((c) => List(Random().nextInt(5) + 5).map((c) => '#').join())
      .join(' ');
  static String numbers(int count) =>
      List(count).map((c) => Random().nextInt(10)).join();
}
