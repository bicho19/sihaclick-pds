import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sihaclik/store/models/professional-types.dart';
import 'package:sihaclik/store/models/professional.dart';
import 'package:sihaclik/store/services/local/professionals.dart';

class ProfessionalsNotifier with ChangeNotifier {
  List<ProfessionalTypes> _professionals = [];
  List<ProfessionalTypes> get professionals => _professionals;
  init() async {
    final encoded = await Professionals.professionals;
    final List<dynamic> decoded = jsonDecode(encoded);
    _professionals = decoded.map((d) => ProfessionalTypes.fromJson(d)).toList();

    final encodedFavorites = await Professionals.favorites;
    final List<dynamic> decodedFavorites = jsonDecode(encodedFavorites);
    _favorites =
        decodedFavorites.map((d) => ProfessionalTypes.fromJson(d)).toList();

    notifyListeners();
  }

  List<ProfessionalTypes> _favorites = [];
  List<ProfessionalTypes> get favorites => _favorites;
  void removeFavorite({
    ProfessionalTypes type,
    Professional professional,
  }) {
    print("""
      type:
        - id: ${type.id}
        - title: ${type.title}
    """);
    print("""
      professional:
        - id: ${professional.id}
        - title: ${professional.title}
    """);
    notifyListeners();
  }
}
