import 'package:flutter/material.dart';

class ShrinkedRowTile extends StatelessWidget {
  const ShrinkedRowTile({
    @required this.title,
    this.subtitle,
    this.margin = const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
  });
  final String title;
  final String subtitle;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: margin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "$title: ",
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primaryVariant,
                ),
          ),
          if (subtitle != null)
            Text(
              subtitle,
              style: Theme.of(context).textTheme.subtitle1,
            ),
        ],
      ),
    );
  }
}

class ShrinkedColumnTile extends StatelessWidget {
  const ShrinkedColumnTile({
    @required this.title,
    this.subtitle,
    this.margin = const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
  });
  final String title;
  final String subtitle;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: margin,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "$title: ",
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primaryVariant,
                ),
          ),
          if (subtitle != null)
            Text(
              subtitle,
              style: Theme.of(context).textTheme.subtitle1,
            ),
        ],
      ),
    );
  }
}
