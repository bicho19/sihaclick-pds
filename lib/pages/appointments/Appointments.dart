import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-page.dart';
import 'package:sihaclik/elements/controls/sc-segments.dart';
import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/helpers/timing.dart';
import 'package:sihaclik/pages/appointments/waitings.dart';
import 'package:sihaclik/pages/professional/calendar.dart';

class AppointmentsPage extends StatefulWidget {
  final bool canPop;
  AppointmentsPage({
    Key key,
    this.canPop = true,
  }) : super(key: key);
  final controller = PageController(
    keepPage: true,
  );
  @override
  _AppointmentsPageState createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  PageController get controller => widget.controller;
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      physics: NeverScrollableScrollPhysics(),
      children: [
        AppointmentsWaitingsPage(
          canPop: widget.canPop,
          pageIndex: pageIndex,
          setPage: setPage,
        ),
        IndexPage(
          canPop: widget.canPop,
          pageIndex: pageIndex,
          setPage: setPage,
        ),
      ],
    );
  }

  void setPage(int index) {
    this.pageIndex = index;
    controller.jumpToPage(pageIndex == 0 ? 0 : 1);
    setState(() {});
  }
}

class IndexPage extends StatelessWidget {
  const IndexPage({
    Key key,
    @required this.canPop,
    @required this.pageIndex,
    @required this.setPage,
  }) : super(key: key);

  final bool canPop;
  final int pageIndex;
  final void Function(int) setPage;

  @override
  Widget build(BuildContext context) {
    return SCPage(
      title: context.translate('recent_meeting'),
      smaller: true,
      canPop: canPop,
      top: null,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: SCSegments(
            pageIndex: pageIndex,
            setPage: setPage,
            smaller: true,
            titles: [
              context.translate('waiting_appointment'),
              context.translate('recent_meeting'),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppointmentsPreview(status: Appointments.REPORTED),
            AppointmentsPreview(status: Appointments.CANCELED),
            AppointmentsPreview(status: Appointments.REPORTED),
            AppointmentsPreview(status: Appointments.OLD),
          ],
        ),
      ],
    );
  }
}

enum Appointments {
  CANCELED,
  OLD,
  ACTIVE,
  REPORTED,
}

class AppointmentsPreview extends StatelessWidget {
  final Appointments status;
  AppointmentsPreview({this.status = Appointments.ACTIVE});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () {},
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Padding(
            padding: EdgeInsets.only(top: 12, left: 16, right: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Theme.of(context)
                            .colorScheme
                            .primaryVariant
                            .withOpacity(0.75),
                      ),
                      margin: EdgeInsets.only(top: 4),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Mohamed Chafik",
                            style:
                                Theme.of(context).textTheme.subtitle1.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          Text(
                            context.translate('pharmacist'),
                            style: Theme.of(context).textTheme.caption,
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Image.asset(
                                "assets/icons/phone.png",
                                width: 13,
                                height: 13,
                                alignment: Alignment.topCenter,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryVariant,
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  "0552123456 - 0552123456",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primaryVariant,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Image.asset(
                                "assets/icons/location.png",
                                width: 13,
                                height: 13,
                                alignment: Alignment.topCenter,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryVariant,
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  SCLocalizations.of(context)
                                          .translate('cheraga') +
                                      " - " +
                                      SCLocalizations.of(context)
                                          .translate('algiers'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primaryVariant,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            TimeFormat.formatAgo(
                              context,
                              DateTime.now().add(
                                Duration(
                                  days: Random().nextInt(10),
                                ),
                              ),
                              allowFromNow: true,
                            ).toString().replaceAll('منذ ', ''),
                            style: Theme.of(context).textTheme.caption,
                          ),
                          Text(
                            TimeFormat.format(
                              context,
                              DateTime.now().add(
                                Duration(
                                  days: Random().nextInt(10),
                                ),
                              ),
                            ),
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryVariant,
                                  fontWeight: FontWeight.bold,
                                  // fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                AnimatedOpacity(
                  opacity: status == Appointments.ACTIVE ? 1 : 0.8,
                  duration: Duration(milliseconds: 200),
                  child: Row(
                    children: [
                      if (status == Appointments.ACTIVE) ...[
                        Expanded(
                          child: Container(
                            height: 29,
                            alignment: Alignment.centerRight,
                            child: FlatButton(
                              onPressed: () {
                                final _pureHeight =
                                    MediaQuery.of(context).size.height -
                                        20 -
                                        MediaQuery.of(context).padding.bottom;
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  barrierColor: Theme.of(context)
                                      .colorScheme
                                      .onBackground
                                      .withOpacity(0.75),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(10.0),
                                    ),
                                  ),
                                  builder: (_) => Container(
                                    height: _pureHeight,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(10.0),
                                      ),
                                      child: CalendarPage(
                                        update: true,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              color: Theme.of(context).colorScheme.primary,
                              child: Center(
                                child: Text(
                                  SCLocalizations.of(context)
                                      .translate('update'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            height: 29,
                            alignment: Alignment.centerRight,
                            child: FlatButton(
                              onPressed: () {},
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondaryVariant,
                              child: Center(
                                child: Text(
                                  SCLocalizations.of(context)
                                      .translate('cancel'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ] else ...[
                        Expanded(
                          child: Opacity(
                            opacity: status == Appointments.OLD ||
                                    status == Appointments.ACTIVE
                                ? 1
                                : 0.3,
                            child: Container(
                              height: 29,
                              alignment: Alignment.centerRight,
                              child: FlatButton(
                                onPressed: () {},
                                color: Theme.of(context).colorScheme.surface,
                                child: Center(
                                  child: Text(
                                    SCLocalizations.of(context)
                                        .translate('passed'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Opacity(
                            opacity: status == Appointments.REPORTED ||
                                    status == Appointments.ACTIVE
                                ? 1
                                : 0.3,
                            child: Container(
                              height: 29,
                              alignment: Alignment.centerRight,
                              child: FlatButton(
                                onPressed: () {},
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryVariant,
                                child: Center(
                                  child: Text(
                                    SCLocalizations.of(context)
                                        .translate('reported'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Opacity(
                            opacity: status == Appointments.CANCELED ||
                                    status == Appointments.ACTIVE
                                ? 1
                                : 0.3,
                            child: Container(
                              height: 29,
                              alignment: Alignment.centerRight,
                              child: FlatButton(
                                onPressed: () {},
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryVariant,
                                child: Center(
                                  child: Text(
                                    SCLocalizations.of(context)
                                        .translate('canceled'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
