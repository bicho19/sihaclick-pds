import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sihaclik/helpers/hashed.dart';

import 'package:sihaclik/pages/search/sc-search-results.dart';

class AllSearchSuggestions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 4),
        Avatars(),
        for (final _ in List(5)) Link(),
        // SizedBottomSpacer(),
      ],
    );
  }
}

class ProfessionalSearchSuggestions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 4),
        for (final _ in List(3)) RichRoundedLink(),
        for (final _ in List(5)) Link(),
        // SizedBottomSpacer(),
      ],
    );
  }
}

class WritingSearchSuggestions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 4),
        for (final _ in List(2)) RichContentLink(),
        for (final _ in List(5)) Link(),
        // SizedBottomSpacer(),
      ],
    );
  }
}

class MedicineSearchSuggestions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 4),
        for (final _ in List(2)) RichLink(),
        for (final _ in List(5)) Link(),
        // SizedBottomSpacer(),
      ],
    );
  }
}

class ExchangeSearchSuggestions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 4),
        SearchSection(title: Hashed.words(2)),
        for (final _ in List(2)) RichLink(),
        SearchSection(title: Hashed.words(2)),
        for (final _ in List(2)) RichLink(),
        for (final _ in List(5)) Link(),
      ],
    );
  }
}
