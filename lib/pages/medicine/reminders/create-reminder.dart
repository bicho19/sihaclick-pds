import 'dart:io';
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-app-bar-bottom-sheet.dart';
import 'package:sihaclik/elements/basics/sc-app-bar.dart';
import 'package:sihaclik/elements/basics/sc-raised-button.dart';
import 'package:sihaclik/elements/controls/sc-dialog.dart';
import 'package:sihaclik/elements/controls/sc-drop-down.dart';
import 'package:sihaclik/elements/controls/sc-time-picker.dart';
import 'package:sihaclik/elements/professional/calendar.dart';
import 'package:sihaclik/elements/reminder/raised-picker.dart';
import 'package:sihaclik/helpers/hashed.dart';
import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/pages/medicine/reminders/reminders.dart';
import 'package:sihaclik/pages/search/sc-search-delegate.dart';
import 'package:sihaclik/pages/search/sc-search-types.dart';
import 'package:sihaclik/pages/search/sc-search.dart';

import 'package:sihaclik/store/abstracts/widget-view.dart';
import 'package:sihaclik/store/models/medicine.dart';
import 'package:sihaclik/store/models/reminder.dart';
import 'package:sihaclik/store/notifiers/reminders.dart';
import 'package:provider/provider.dart';

class MedicineAlertPage extends StatefulWidget {
  final CameraDescription camera;
  final Reminder reminder;
  MedicineAlertPage({Key key, this.reminder, this.camera}) : super(key: key);
  @override
  _MedicineAlertPageController createState() => _MedicineAlertPageController();
}

class _MedicineAlertPageController extends State<MedicineAlertPage> {
  Medicine medicine;
  List<TimeOfDay> times = List<TimeOfDay>(3);
  int weeks = 4;
  DateTime startAt = DateTime.now();

  @override
  Widget build(BuildContext context) => _MedicineAlertPageView(this);

  @override
  void initState() {
    super.initState();
    if (widget.reminder != null) {
      setStartAt(widget.reminder.startAt);
      setMedicine(widget.reminder.medicine);
      setTimes(Option(value: widget.reminder.times.length));
      for (var index in widget.reminder.times.asMap().keys) {
        addTime(widget.reminder.times[index], index: index);
      }
      setWeeks(Option(value: widget.reminder.weeks));
    }
  }

  void setWeeks(option) {
    this.weeks = option.value;
    setState(() {});
  }

  void setStartAt(DateTime date) {
    this.startAt = date;
    setState(() {});
  }

  void setMedicine(medicine) {
    this.medicine = medicine;
    setState(() {});
  }

  void searchMedicine() async {
    final _ = await showSCSearch(
      context: context,
      title: context.translate('search'),
      type: SCSearchTypes.Medicine,
      delegate: SCSearchDelegate(
        type: SCSearchTypes.Medicine,
      ),
    );
    medicine = Medicine(
      title: Hashed.words(2),
      description: Hashed.words(4),
    );
    setState(() {});
  }

  void setTimes(Option<dynamic> option) {
    final List<TimeOfDay> tempTimes = List<TimeOfDay>(option.value);
    for (final idx in tempTimes.asMap().keys)
      if (idx < times.length) tempTimes[idx] = times[idx];
    times = tempTimes;
    setState(() {});
  }

  void addTime(TimeOfDay time, {int index = 0}) {
    times[index] = time;
    setState(() {});
  }

  void mainAction() async {
    if (widget.reminder != null) {
      context.read<RemindersNotifier>().updateReminder(
            Reminder(
              id: widget.reminder.id,
              startAt: startAt,
              times: times,
              weeks: weeks,
              medicine: medicine,
            ),
          );
      Navigator.of(context).pop();
    } else {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SCDialog(
            title: context.translate('medicine_alert_title'),
            subtitle: context.translate('medicine_alert_content'),
            imageName: "dialog-alarm",
            label: context.translate('next'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          );
        },
      );
      context.read<RemindersNotifier>().addReminder(
            Reminder(
              id: Random().nextInt(100000),
              startAt: startAt,
              times: times,
              weeks: weeks,
              medicine: medicine,
            ),
          );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => MedicineAlertsPage(),
        ),
      );
    }
  }
}

class _MedicineAlertPageView
    extends WidgetView<MedicineAlertPage, _MedicineAlertPageController> {
  _MedicineAlertPageView(_MedicineAlertPageController state) : super(state);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        if (widget.reminder == null)
          SCAppBar(
            title: context.translate('alarm'),
          )
        else
          SCAppBarBottomSheet(
            title: context.translate('modify_my_reminder'),
          ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (state.widget.reminder == null)
                      Text(
                        SCLocalizations.of(context)
                            .translate('schedule_a_medicine_alarm')
                            .toUpperCase(),
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(context).colorScheme.primaryVariant,
                            ),
                      )
                    else
                      Text(
                        Hashed.words(3),
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(context).colorScheme.primaryVariant,
                            ),
                      ),
                    AlertSectionTitle(
                      title: SCLocalizations.of(context)
                          .translate('choose_a_medicine'),
                    ),
                    RaisedPicker(
                      camera: widget.camera,
                      setMedicine: state.setMedicine,
                      onPressed: state.searchMedicine,
                      title: "##### ###",
                    ),
                    if (state.medicine != null)
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.16),
                              offset: Offset(0, 2),
                              blurRadius: 1,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 64,
                              width: 64,
                              decoration: BoxDecoration(
                                color: state.medicine.image != null
                                    ? Theme.of(context).colorScheme.onSurface
                                    : Theme.of(context)
                                        .colorScheme
                                        .primaryVariant
                                        .withOpacity(0.75),
                                image: state.medicine.image != null
                                    ? DecorationImage(
                                        image: FileImage(
                                          File(state.medicine.image),
                                        ),
                                        fit: BoxFit.contain,
                                      )
                                    : null,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${state.medicine.title}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primaryVariant,
                                            fontWeight: FontWeight.bold,
                                          )),
                                  Text(
                                    "${state.medicine.description}",
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    AlertSectionTitle(
                        title: SCLocalizations.of(context)
                            .translate('choose_the_date')),
                    Container(
                      padding: EdgeInsets.only(top: 20),
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
                      child: Calendar(
                        date: state.startAt,
                        setDate: state.setStartAt,
                        unavailables: <Set<int>>[],
                      ),
                    ),
                    AlertSectionTitle(
                      title: context.translate(
                        'take_the_medicine',
                      ),
                    ),
                    SCDropdown<int>(
                      raised: true,
                      soft: true,
                      label: "",
                      uppercase: false,
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.75),
                      onChange: state.setTimes,
                      initial: Option<int>(
                        value: state.times.length,
                        text: "${state.times.length} " +
                            context.translate(
                              state.times.length == 1
                                  ? 'time_a_day'
                                  : 'times_a_day',
                            ),
                      ),
                      options: [
                        for (final idx in List(9).asMap().keys)
                          Option<int>(
                            value: idx + 1,
                            text: "${idx + 1} " +
                                context.translate(
                                  idx + 1 == 1 ? 'time_a_day' : 'times_a_day',
                                ),
                          ),
                      ],
                    ),
                    AlertSectionTitle(
                      title: context.translate(
                        'choose_the_time',
                      ),
                    ),
                    for (final idx in state.times.asMap().keys) ...[
                      SCTimePicker(
                        label: "${idx + 1} ${context.translate('time_at')} :",
                        value: state.times[idx],
                        onChange: (time) => state.addTime(time, index: idx),
                      ),
                      if (idx < state.times.length) SizedBox(height: 10),
                    ],
                    AlertSectionTitle(title: context.translate('during')),
                    SCDropdown(
                      raised: true,
                      soft: true,
                      label: '',
                      // "# " +context.translate('weeks'),
                      uppercase: false,
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.75),
                      initial: Option(
                        value: state.weeks,
                        text: "${state.weeks} " +
                            context.translate(
                              state.weeks == 1 ? 'week' : 'weeks',
                            ),
                      ),
                      onChange: state.setWeeks,
                      options: [
                        for (final idx in List(9).asMap().keys)
                          Option<int>(
                            value: idx + 1,
                            text: "${idx + 1} " +
                                context.translate(
                                  idx + 1 == 1 ? 'week' : 'weeks',
                                ),
                          ),
                      ],
                    ),
                    SCRaisedButton(
                      title: widget.reminder != null
                          ? SCLocalizations.of(context)
                              .translate('modify_my_reminder')
                          : context.translate('confirm'),
                      withIcon: true,
                      margin: EdgeInsets.only(top: 40),
                      onPressed: state.mainAction,
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

class AlertSectionTitle extends StatelessWidget {
  final String title;
  const AlertSectionTitle({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 20),
        Text(
          title,
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: Theme.of(context).colorScheme.primaryVariant,
              ),
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
