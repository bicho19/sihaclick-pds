import 'package:flutter/material.dart';

class SCTimePicker extends StatefulWidget {
  final String label;
  final bool smaller;
  final TimeOfDay value;
  final void Function(TimeOfDay) onChange;
  const SCTimePicker({
    Key key,
    this.label,
    this.smaller = false,
    this.onChange,
    this.value,
  }) : super(key: key);

  @override
  _SCTimePickerState createState() => _SCTimePickerState();
}

class _SCTimePickerState extends State<SCTimePicker> {
  @override
  Widget build(BuildContext context) {
    final _minute = widget.value != null
        ? (widget.value.minute < 10
            ? "0${widget.value.minute}"
            : widget.value.minute)
        : "--";
    final _hour = widget.value != null ? widget.value.hour : "--";
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null)
          Expanded(
            child: Text(
              widget.label,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        SizedBox(
          width: 120,
          child: GestureDetector(
            onTap: () async {
              widget.onChange(
                await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                  useRootNavigator: true,
                ),
              );
            },
            child: Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Theme.of(context).colorScheme.background,
                border: Border.all(
                    width: 1, color: Theme.of(context).colorScheme.surface),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1,
                    offset: Offset(0, 2),
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.25),
                  )
                ],
              ),
              child: Text(
                (Directionality.of(context) == TextDirection.rtl
                    ? "$_minute : $_hour"
                    : "$_hour : $_minute"),
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
