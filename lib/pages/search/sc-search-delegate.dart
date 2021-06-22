import 'package:flutter/material.dart';
import 'package:sihaclik/pages/search/sc-search-results.dart';
import 'package:sihaclik/pages/search/sc-search-suggestions.dart';
import 'package:sihaclik/pages/search/sc-search-types.dart';
import 'package:sihaclik/pages/search/sc-search.dart';

class SCSearchDelegate extends SCAbstractSearchDelegate {
  final SCSearchTypes type;
  final bool titles;
  SCSearchDelegate({
    this.titles = true,
    this.type,
  });
  @override
  List<Widget> buildActions(BuildContext context) {
    return null;
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      padding: EdgeInsets.all(0),
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.arrow_back),
      color: Theme.of(context).colorScheme.background,
    );
  }

  @override
  Widget buildResults(BuildContext context, SCSearchTypes defaultType) {
    switch (defaultType != null ? defaultType : type) {
      case SCSearchTypes.All:
        return AllSearchResults();
        break;
      case SCSearchTypes.Professional:
        return ProfessionalSearchResults();
        break;
      case SCSearchTypes.Writing:
        return WritingSearchResults();
        break;
      case SCSearchTypes.Medicine:
        return MedicineSearchResults();
        break;
      // case SCSearchTypes.Exchange:
      //   return ExchangeSearchResults();
      //   break;
      default:
        return ExchangeSearchResults();
    }
  }

  @override
  Widget buildSuggestions(BuildContext context, SCSearchTypes defaultType) {
    switch (defaultType != null ? defaultType : type) {
      case SCSearchTypes.All:
        return AllSearchSuggestions();
        break;
      case SCSearchTypes.Professional:
        return ProfessionalSearchSuggestions();
        break;
      case SCSearchTypes.Writing:
        return WritingSearchSuggestions();
        break;
      case SCSearchTypes.Medicine:
        return MedicineSearchSuggestions();
        break;
      // case SCSearchTypes.Exchange:
      //   return ExchangeSearchSuggestions();
      //   break;
      default:
        return ExchangeSearchSuggestions();
    }
  }
}
