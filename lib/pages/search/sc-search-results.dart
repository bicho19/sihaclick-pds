import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sihaclik/helpers/hashed.dart';

class AllSearchResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 4),
        Avatars(),
        for (final _ in List(2)) RichLink(),
        RichContentLink(),
        SearchSection(
          title: Hashed.words(2),
        ),
        for (final _ in List(2)) RichLink(),
        SearchSection(title: Hashed.words(2)),
        for (final _ in List(2)) RichLink(),
        // SizedBottomSpacer(),
      ],
    );
  }
}

class ProfessionalSearchResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 4),
        for (final _ in List(3)) RichRoundedLink(),
        SearchSection(title: Hashed.words(3)),
        for (final _ in List(2)) RichLink(),
        RichContentLink(),
        SearchSection(
          title: Hashed.words(2),
        ),
        for (final _ in List(2)) RichLink(),
        SearchSection(title: Hashed.words(2)),
        for (final _ in List(2)) RichLink(),
        // SizedBottomSpacer(),
      ],
    );
  }
}

class WritingSearchResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 4),
        for (final _ in List(2)) RichContentLink(),
        SearchSection(title: Hashed.words(3)),
        Avatars(),
        for (final _ in List(2)) RichLink(),
        SearchSection(
          title: Hashed.words(2),
        ),
        for (final _ in List(2)) RichLink(),
        SearchSection(title: Hashed.words(2)),
        for (final _ in List(2)) RichLink(),
        // SizedBottomSpacer(),
      ],
    );
  }
}

class MedicineSearchResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 4),
        for (final _ in List(2)) RichLink(),
        SearchSection(title: Hashed.words(2)),
        Avatars(),
        RichContentLink(),
        SearchSection(
          title: Hashed.words(2),
        ),
        for (final _ in List(2)) RichLink(),
        SearchSection(title: Hashed.words(2)),
        for (final _ in List(2)) RichLink(),
        // SizedBottomSpacer(),
      ],
    );
  }
}

class ExchangeSearchResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 4),
        SearchSection(
          title: Hashed.words(2),
        ),
        for (final _ in List(2)) RichLink(),
        SearchSection(title: Hashed.words(2)),
        for (final _ in List(2)) RichLink(),
        SearchSection(title: Hashed.words(2)),
        Avatars(),
        for (final _ in List(2)) RichLink(),
        RichContentLink(),
        // SizedBottomSpacer(),
      ],
    );
  }
}

class RichContentLink extends StatelessWidget {
  const RichContentLink({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Hashed.words(4),
                  ),
                  SizedBox(height: 4),
                  Text(
                    Hashed.words(7),
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.open_in_new,
              color: Theme.of(context).colorScheme.primary,
              size: 19,
            ),
          ],
        ),
      ),
    );
  }
}

class RichRoundedLink extends StatelessWidget {
  const RichRoundedLink({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Row(
          children: [
            Container(
              width: 51,
              height: 51,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(List(Random().nextInt(10) + 5)
                      .map((e) => '#')
                      .toList()
                      .join()),
                  Text(
                    List(Random().nextInt(10) + 5)
                        .map((e) => '#')
                        .toList()
                        .join(),
                    style: Theme.of(context).textTheme.overline,
                  ),
                ],
              ),
            ),
            Spacer(),
            Icon(
              Icons.open_in_new,
              color: Theme.of(context).colorScheme.primary,
              size: 19,
            ),
          ],
        ),
      ),
    );
  }
}

class SearchSection extends StatelessWidget {
  final String title;
  const SearchSection({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      child: Text(title),
    );
  }
}

class RichLink extends StatelessWidget {
  const RichLink({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Row(
          children: [
            Container(
              width: 51,
              height: 51,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(List(Random().nextInt(10) + 5)
                      .map((e) => '#')
                      .toList()
                      .join()),
                  Text(
                    List(Random().nextInt(10) + 5)
                        .map((e) => '#')
                        .toList()
                        .join(),
                    style: Theme.of(context).textTheme.overline,
                  ),
                ],
              ),
            ),
            Spacer(),
            Icon(
              Icons.open_in_new,
              color: Theme.of(context).colorScheme.primary,
              size: 19,
            ),
          ],
        ),
      ),
    );
  }
}

class Avatars extends StatelessWidget {
  const Avatars({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              for (final _ in List(5))
                Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Container(
                        width: 51,
                        height: 51,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onSurface,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "#### ##",
                        style: Theme.of(context).textTheme.caption.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                      ),
                      Text(
                        "#####",
                        style: Theme.of(context).textTheme.overline,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class Link extends StatelessWidget {
  const Link({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Row(
        children: [
          Text(List(Random().nextInt(10) + 3).map((e) => '#').toList().join()),
          Spacer(),
          Icon(
            Icons.open_in_new,
            color: Theme.of(context).colorScheme.primary,
            size: 19,
          ),
        ],
      ),
    );
  }
}

class RecentSearches extends StatefulWidget {
  const RecentSearches({
    Key key,
  }) : super(key: key);

  @override
  _RecentSearchesState createState() => _RecentSearchesState();
}

class _RecentSearchesState extends State<RecentSearches> {
  bool active = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 20),
          Text("Recent searches"),
          Spacer(),
          GestureDetector(
            onTap: () {
              active = !active;
              setState(() {});
            },
            child: Container(
              color: Theme.of(context).colorScheme.background,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  if (active)
                    Container(
                      height: 21,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(21),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "clear",
                        style: Theme.of(context).textTheme.caption.copyWith(
                              color: Theme.of(context).colorScheme.background,
                            ),
                      ),
                    )
                  else
                    Container(
                      width: 21,
                      height: 21,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        color: Theme.of(context).colorScheme.background,
                        size: 15,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
