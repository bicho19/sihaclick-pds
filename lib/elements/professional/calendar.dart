import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-raised-button.dart';
import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/helpers/timing.dart';
import 'package:sihaclik/store/abstracts/widget-view.dart';

class Calendar extends StatefulWidget {
  final List<Set<int>> unavailables;
  final DateTime date;
  final void Function(DateTime) setDate;
  final bool showTimes;

  Calendar({
    @required this.unavailables,
    @required this.date,
    @required this.setDate,
    this.showTimes = false,
  });

  @override
  _CalendarController createState() => _CalendarController();
}

class _CalendarController extends State<Calendar> {
  final now = DateTime.now();
  @override
  Widget build(BuildContext context) => _CalendarView(this);

  void setMonth(month) {
    final tempDate = DateTime(
      widget.date.year,
      month,
      widget.date.day,
    );
    if (!(tempDate.isBefore(now) && now.month == tempDate.month))
      widget.setDate(tempDate);
    else
      widget.setDate(now);
  }

  void setDay(day) {
    final tempDate = DateTime(
      widget.date.year,
      widget.date.month,
      day,
    );
    if (!(tempDate.isBefore(now) && now.month == tempDate.month))
      widget.setDate(tempDate);
  }
}

class _CalendarView extends WidgetView<Calendar, _CalendarController> {
  _CalendarView(_CalendarController state) : super(state);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MonthsView(
          month: state.widget.date.month,
          setMonth: state.setMonth,
        ),
        DaysView(
          month: state.widget.date.month,
          unavailables:
              state.widget.unavailables.length > state.widget.date.month - 1
                  ? state.widget.unavailables[state.widget.date.month]
                  : Set<int>(),
          setDay: state.setDay,
          day: state.widget.date.day,
        ),
        if (state.widget.showTimes) TimesView(),
      ],
    );
  }
}

class Day {
  final int day;
  final bool available;
  Day({@required this.day, this.available = true});
}

class DaysView extends StatefulWidget {
  final year = DateTime.now().year;
  final int month;
  final Set<int> unavailables;
  final int day;
  final void Function(int) setDay;
  DaysView({
    @required this.month,
    @required this.unavailables,
    @required this.day,
    @required this.setDay,
  });

  @override
  _DaysViewState createState() => _DaysViewState();
}

class _DaysViewState extends State<DaysView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
      child: LayoutBuilder(
        builder: (_, BoxConstraints constraints) => Wrap(
          children: [
            for (final weekDay in [
              'Saturday',
              'Sunday',
              'Monday',
              'Tuesday',
              'Wednesday',
              'Thursday',
              'Friday',
            ])
              Container(
                width: constraints.maxWidth / 7,
                height: 31,
                alignment: Alignment.center,
                child: Text(
                  SCLocalizations.of(context)
                      .translate(weekDay)
                      .substring(0, 1),
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            for (final _ in List(spaces()).asMap().keys)
              Container(
                width: constraints.maxWidth / 7,
                height: 31,
                alignment: Alignment.center,
              ),
            for (final day in List(days()).asMap().keys.map((i) => i + 1))
              GestureDetector(
                onTap: widget.unavailables.contains(day)
                    ? null
                    : () => widget.setDay(day),
                child: Container(
                  width: constraints.maxWidth / 7,
                  height: 31,
                  alignment: Alignment.center,
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: widget.unavailables.contains(day)
                          ? Theme.of(context)
                              .colorScheme
                              .secondaryVariant
                              .withOpacity(0.5)
                          : (widget.day == day
                              ? Theme.of(context).colorScheme.primary
                              : null),
                      border: today() == day
                          ? Border.all(
                              width: 1,
                              color: Theme.of(context).colorScheme.primary,
                            )
                          : null,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$day',
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                            fontWeight: FontWeight.bold,
                            color: widget.unavailables.contains(day) ||
                                    widget.day == day
                                ? Theme.of(context).colorScheme.secondary
                                : (today() == day
                                    ? Theme.of(context).colorScheme.primary
                                    : (today() > day
                                        ? Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                        : null)),
                          ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  int today() {
    final now = DateTime.now();
    if (now.month == widget.month)
      return now.day;
    else
      return -1;
  }

  int spaces() {
    final firstDay = DateTime(widget.year, widget.month, 1, 12);
    return firstDay.weekday + 1 % 7;
  }

  int days() {
    DateTime firstOfNextMonth;
    if (widget.month == 12) {
      firstOfNextMonth = DateTime(widget.year + 1, 1, 1, 12);
    } else {
      firstOfNextMonth = DateTime(widget.year, widget.month + 1, 1, 12);
    }
    int numberOfDaysInMonth = firstOfNextMonth.subtract(Duration(days: 1)).day;
    return numberOfDaysInMonth;
  }
}

class Time {
  final String title;
  final bool available;
  Time({@required this.title, this.available = true});
}

class TimesView extends StatefulWidget {
  final _times = [
    Time(title: "8:00"),
    Time(title: "9:00"),
    Time(title: "10:00"),
    Time(title: "11:00"),
    Time(title: "12:00"),
    Time(title: "13:00", available: false),
    Time(title: "14:00"),
    Time(title: "15:00"),
    Time(title: "16:00"),
    Time(title: "17:00"),
    Time(title: "18:00"),
    Time(title: "19:00"),
  ];
  @override
  _TimesViewState createState() => _TimesViewState();
}

class _TimesViewState extends State<TimesView> {
  List<Time> get times => widget._times;
  Time time;

  @override
  void initState() {
    super.initState();
    time = widget._times.first;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: [
          for (final tm in times)
            Chip(
              onPressed: tm.available
                  ? () {
                      time = tm;
                      setState(() {});
                    }
                  : null,
              title: tm.title,
              active: tm.title == time.title,
            ),
        ],
      ),
    );
  }
}

class MonthsView extends StatefulWidget {
  MonthsView({
    Key key,
    @required this.month,
    @required this.setMonth,
  }) : super(key: key);

  final int month;
  final void Function(int) setMonth;

  final PageController controller = PageController(
    viewportFraction: 0.33,
  );

  @override
  _MonthsViewState createState() => _MonthsViewState();
}

class _MonthsViewState extends State<MonthsView> {
  PageController get controller => widget.controller;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(Duration(milliseconds: 100), () {
      controller.jumpToPage(widget.month - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      color: Theme.of(context).colorScheme.onSecondary,
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: IconButton(
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                int index;
                if (widget.month > 1) {
                  index = widget.month - 1 - 1;
                  widget.setMonth(widget.month - 1);
                } else {
                  index = 12 - 1;
                  widget.setMonth(12);
                }
                controller.animateToPage(
                  index,
                  duration: Duration(
                    milliseconds: 200,
                  ),
                  curve: Curves.linear,
                );
              },
              icon: Icon(Icons.chevron_left),
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: PageView(
                controller: controller,
                onPageChanged: (index) {
                  // widget.setMonth(index + 1);
                },
                children: [
                  for (final index in Months.values.asMap().keys)
                    SCRaisedButton(
                      onPressed: () {
                        widget.setMonth(index + 1);
                        controller.animateToPage(
                          index,
                          duration: Duration(
                            milliseconds: 200,
                          ),
                          curve: Curves.linear,
                        );
                      },
                      title: context.translate(
                          Months.values[index].toString().split('.').last),
                      flat: this.widget.month != index + 1,
                      small: true,
                      bold: true,
                    ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 40,
            child: IconButton(
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                int index;
                if (widget.month < 12) {
                  index = widget.month;
                  widget.setMonth(widget.month + 1);
                } else {
                  widget.setMonth(1);
                  index = 0;
                }
                controller.animateToPage(
                  index,
                  duration: Duration(
                    milliseconds: 200,
                  ),
                  curve: Curves.linear,
                );
              },
              icon: Icon(Icons.chevron_right),
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class Chip extends StatelessWidget {
  final bool active;
  final String title;
  final void Function() onPressed;
  const Chip({
    this.active = false,
    @required this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: 70,
        height: 28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          boxShadow: onPressed == null
              ? null
              : (!active
                  ? [
                      BoxShadow(
                        blurRadius: 2,
                        offset: Offset(0, 1),
                        color: active
                            ? Theme.of(context)
                                .colorScheme
                                .primaryVariant
                                .withOpacity(0.25)
                            : Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.25),
                      )
                    ]
                  : null),
        ),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: onPressed == null
                ? Theme.of(context)
                    .colorScheme
                    .secondaryVariant
                    .withOpacity(0.5)
                : (active
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSecondary),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: active || onPressed == null
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.primaryVariant,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}
