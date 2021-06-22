import 'package:flutter/material.dart';
import 'package:sihaclik/elements/controls/sc-drop-down.dart';

import 'package:sihaclik/helpers/sc-localization.dart';

class StageDuration extends StatelessWidget {
  final double bottom;
  StageDuration({
    Key key,
    this.bottom,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: bottom),
      children: [
        Text(
          context.translate('duration_of_internship'),
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: Theme.of(context).colorScheme.primaryVariant,
              ),
        ),
        SizedBox(height: 20),
        SCDropdown<int>(
          label: "1 - 12 " + context.translate('months'),
          options: [
            for (final idx in List(12).asMap().keys)
              if (idx == 0)
                Option(
                  text: "1 " + context.translate('month'),
                  value: idx,
                )
              else
                Option(
                  text: "${idx + 1} " + context.translate('months'),
                  value: idx,
                ),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
