import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-app-bar-bottom-sheet.dart';
import 'package:sihaclik/elements/basics/sc-app-bar.dart';
import 'package:sihaclik/elements/basics/sc-raised-button.dart';
import 'package:sihaclik/elements/controls/sc-favorite.dart';
import 'package:sihaclik/elements/professional/calendar.dart';
import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/helpers/timing.dart';
import 'package:sihaclik/pages/professional/submition.dart';

final List<Set<int>> unavailables = [
  for (final _ in Months.values)
    Set<int>.from([
      for (final _ in List(Random().nextInt(4))) Random().nextInt(30),
    ])
];

class CalendarPage extends StatefulWidget {
  final void Function() setPage;
  final bool update;
  CalendarPage({this.setPage, this.update = false});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  Months month = Months.values[DateTime.now().month - 1];
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        if (!widget.update)
          SCAppBar(
            title: context.translate('make_an_appointment'),
            clear: true,
            canPop: true,
          )
        else
          SCAppBarBottomSheet(
              title: context.translate('modify_my_appointment')),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.16),
                            offset: Offset(0, 2),
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          ProfessionalDetailsListTile(),
                          SizedBox(height: 8),
                          Calendar(
                            date: DateTime.now(),
                            setDate: (DateTime date) {},
                            unavailables: <Set<int>>[],
                            showTimes: true,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    SCRaisedButton(
                      onPressed: () {
                        if (widget.update)
                          Navigator.of(context).pop();
                        else
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => AppointmentSubmitionPage(),
                            ),
                          );
                      },
                      title: widget.update
                          ? SCLocalizations.of(context)
                              .translate('modify_my_appointment')
                          : SCLocalizations.of(context)
                              .translate('make_an_appointment'),
                    ),
                  ],
                ),
              ),
              // SizedBottomSpacer(),
            ],
          ),
        ),
      ],
    );
  }
}

class ProfessionalDetailsListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 61,
            width: 61,
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .secondaryVariant
                  .withOpacity(0.75),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Dr. Mohamed Achouri",
                          style: Theme.of(context).textTheme.subtitle1),
                      Text("Pharmacien",
                          style: Theme.of(context).textTheme.subtitle2),
                      SizedBox(height: 4),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SCFavorite(),
        ],
      ),
    );
  }
}
