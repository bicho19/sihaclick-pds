import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-page.dart';
import 'package:sihaclik/elements/controls/sc-segments.dart';
import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/pages/appointments/appointments.dart';

class AppointmentsWaitingsPage extends StatelessWidget {
  const AppointmentsWaitingsPage({
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
      title: context.translate('waiting_appointment'),
      canPop: canPop,
      smaller: true,
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
            AppointmentsPreview(),
            AppointmentsPreview(),
            AppointmentsPreview(),
          ],
        ),
      ],
    );
  }
}
