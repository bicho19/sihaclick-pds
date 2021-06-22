import 'package:flutter/material.dart';
import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/pages/medicine/reminders/create-reminder.dart';
import 'package:sihaclik/store/models/reminder.dart';

class ReminderPreview extends StatefulWidget {
  final Reminder reminder;
  final void Function() toggle;
  const ReminderPreview({
    @required this.reminder,
    @required this.toggle,
  });

  @override
  _ReminderPreviewState createState() => _ReminderPreviewState();
}

class _ReminderPreviewState extends State<ReminderPreview> {
  int times = 3;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AnimatedOpacity(
                opacity: widget.reminder.enabled ? 1 : 0.3,
                duration: Duration(milliseconds: 200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 100,
                          width: 113,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .primaryVariant
                                .withOpacity(0.75),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Image.asset(
                                  "assets/icons/medicine.png",
                                  width: 21,
                                  height: 21,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      widget.reminder.medicine.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primaryVariant,
                                          ),
                                    ),
                                    Text(
                                      widget.reminder.medicine.description,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primaryVariant,
                                          ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.start,
                            runAlignment: WrapAlignment.center,
                            runSpacing: 8,
                            spacing: 8,
                            children: [
                              Text(
                                context.translate('hour') + ": ",
                              ),
                              for (final time in widget.reminder.times) ...[
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 200),
                                  width: 70,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      (Directionality.of(context) ==
                                                  TextDirection.rtl
                                              ? "${(time.minute < 10 ? "0${time.minute}" : time.minute)} : ${time.hour}"
                                              : "${time.hour} : ${(time.minute < 10 ? "0${time.minute}" : time.minute)}") +
                                          SCLocalizations.of(context)
                                              .translate('hour')
                                              .substring(0, 1),
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ),
                              ]
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
              Row(
                children: [
                  if (widget.reminder.enabled)
                    Expanded(
                      child: Container(
                        height: 29,
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          onPressed: () {
                            // _reminderState = ReminderState.Editable;
                            // setState(() {});

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
                                  child: MedicineAlertPage(
                                    reminder: widget.reminder,
                                  ),
                                ),
                              ),
                            );
                          },
                          color: Theme.of(context).colorScheme.primary,
                          child: Center(
                            child: Text(
                              context.translate('update'),
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (!widget.reminder.enabled)
                    Expanded(
                      child: Container(
                        height: 29,
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          onPressed: () => widget.toggle(),
                          color: Theme.of(context).colorScheme.primary,
                          child: Center(
                            child: Text(
                              context.translate('renew'),
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  SizedBox(width: 8),
                  if (widget.reminder.enabled)
                    Expanded(
                      child: Container(
                        height: 29,
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          onPressed: () => widget.toggle(),
                          color: Theme.of(context).colorScheme.secondaryVariant,
                          child: Center(
                            child: Text(
                              context.translate('cancel'),
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
