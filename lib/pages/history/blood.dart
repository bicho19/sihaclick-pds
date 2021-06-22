import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-app-bar.dart';
import 'package:sihaclik/elements/basics/sc-title.dart';
import 'package:sihaclik/helpers/sc-localization.dart';

class HistoryBloodPage extends StatelessWidget {
  HistoryBloodPage({Key key}) : super(key: key);
  final elements = [];
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SCAppBar(
          title: context.translate('exchange_history'),
          small: true,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              SizedBox(height: 20),
              SCTitle(
                title: context.translate('blood_donation'),
              ),
              SizedBox(height: 20),
              // for (final element in elements)
              //   BloodElementCard(
              //     element: element,
              //   ),
              // SizedBottomSpacer(),
            ],
          ),
        ),
      ],
    );
  }
}
