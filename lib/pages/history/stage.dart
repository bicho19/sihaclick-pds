import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-app-bar.dart';
import 'package:sihaclik/elements/basics/sc-title.dart';

import 'package:sihaclik/helpers/sc-localization.dart';

enum Stages {
  APPROUVED,
  MATERIALIZED,
  CANCELED,
}

class StageElement {
  final String title;
  final String subtitle;
  final String location;
  final Stages status;

  StageElement({
    @required this.title,
    @required this.subtitle,
    @required this.location,
    this.status,
  });
}

class HistoryStagePage extends StatelessWidget {
  HistoryStagePage({Key key}) : super(key: key);
  final elements = [
    StageElement(
      title: "########",
      subtitle: "#### ###",
      location: "",
      status: Stages.APPROUVED,
    ),
    StageElement(
      title: "########",
      subtitle: "#### ###",
      location: "",
      status: Stages.CANCELED,
    ),
    StageElement(
      title: "########",
      subtitle: "#### ###",
      location: "",
      status: Stages.MATERIALIZED,
    ),
    StageElement(
      title: "########",
      subtitle: "#### ###",
      location: "",
      status: Stages.APPROUVED,
    ),
  ];
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
              const SizedBox(height: 20),
              SCTitle(
                title: context.translate('internship_request'),
              ),
              const SizedBox(height: 20),
              for (final element in elements) StageElementCard(element: element),
              const SizedBox(height: 60.0),
            ],
          ),
        ),
        // const SizedBox(height: 20.0),
      ],
    );
  }
}

class StageElementCard extends StatelessWidget {
  final StageElement element;
  final void Function() onPressed;
  const StageElementCard({this.element, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 12, bottom: 16, top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 113,
                      width: 113,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryVariant.withOpacity(0.75),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "#### ###",
                                style: Theme.of(context).textTheme.subtitle1.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).colorScheme.primaryVariant,
                                    ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "#### #####",
                                style: Theme.of(context).textTheme.subtitle2.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/icons/location.png",
                                    width: 13,
                                    height: 13,
                                    alignment: Alignment.topCenter,
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      SCLocalizations.of(context).translate('cheraga') +
                                          " - " +
                                          SCLocalizations.of(context).translate('algiers'),
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context).textTheme.caption.copyWith(
                                          color: Theme.of(context).colorScheme.primary),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (element.status != null)
                      Container(
                        width: 40,
                        height: 40,
                        margin: EdgeInsets.only(bottom: 4),
                        child: IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: () {},
                          padding: EdgeInsets.all(0),
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).colorScheme.secondaryVariant,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          if (element.status == Stages.CANCELED)
            Transform.rotate(
              angle: -pi / 90.0,
              child: Container(
                height: 29,
                width: 120,
                margin: EdgeInsets.only(top: 20, left: 15),
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: () {},
                  color: Theme.of(context).colorScheme.secondaryVariant,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Center(
                    child: Text(
                      context.translate('canceled'),
                      style: Theme.of(context).textTheme.caption.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          if (element.status == Stages.MATERIALIZED)
            Transform.rotate(
              angle: -pi / 90.0,
              child: Container(
                height: 29,
                width: 120,
                margin: EdgeInsets.only(top: 20, left: 15),
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: () {},
                  color: Theme.of(context).colorScheme.onBackground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Center(
                    child: Text(
                      context.translate('materialized'),
                      style: Theme.of(context).textTheme.caption.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          if (element.status == Stages.APPROUVED)
            Transform.rotate(
              angle: -pi / 90.0,
              child: Container(
                height: 29,
                width: 120,
                margin: EdgeInsets.only(top: 20, left: 15),
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: () {},
                  color: Theme.of(context).colorScheme.primaryVariant,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Center(
                    child: Text(
                      context.translate('approuved'),
                      style: Theme.of(context).textTheme.caption.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
