import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sihaclik/elements/basics/sc-page.dart';
import 'package:sihaclik/elements/reminder/preview.dart';

import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/store/notifiers/reminders.dart';

class MedicineAlertsPage extends StatelessWidget {
  MedicineAlertsPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SCPage(
      title: context.translate('my_medicine_alert'),
      smaller: true,
      children: <Widget>[
        for (final reminder in context.watch<RemindersNotifier>().reminders)
          ReminderPreview(
            reminder: reminder,
            toggle: () =>
                context.read<RemindersNotifier>().toggleReminder(reminder),
          ),
        FutureBuilder(
          future: context.watch<RemindersNotifier>().notifications,
          builder: (_, AsyncSnapshot<List<String>> snapshot) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (snapshot.hasData) ...[
                  for (final notification in snapshot.data) Text(notification),
                  if (snapshot.data.length > 0)
                    FlatButton(
                      onPressed: () =>
                          context.read<RemindersNotifier>().cancelAll(),
                      child: Text("Cancel All"),
                    ),
                ]
              ],
            ),
          ),
        ),
      ],
    );
  }
}
