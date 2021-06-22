import 'package:flutter/material.dart';
import 'package:sihaclik/elements/controls/sc-drop-down.dart';

import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/helpers/timing.dart';

class StagePeriod extends StatefulWidget {
  final double bottom;
  final ScrollController controller = ScrollController();
  StagePeriod({
    Key key,
    this.bottom,
  }) : super(key: key);
  @override
  _StagePeriodState createState() => _StagePeriodState();
}

class _StagePeriodState extends State<StagePeriod> {
  bool open = false;
  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: widget.controller,
      padding:
          EdgeInsets.only(top: 20, left: 20, right: 20, bottom: widget.bottom),
      children: [
        Text(
          context.translate('desired_period') + ":",
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: Theme.of(context).colorScheme.primaryVariant,
              ),
        ),
        SizedBox(height: 20),
        SCDropdown<String>(
          label: context.translate('non_flexible_period') +
              ", " +
              context.translate('flexible_period'),
          options: [
            context.translate('non_flexible_period'),
            context.translate('flexible_period'),
          ].map((e) => Option(text: e, value: e)).toList(),
        ),
        if (open) ...[
          SizedBox(height: 20),
          Text(
            context.translate('desired_period') + ":",
            style: Theme.of(context).textTheme.headline6.copyWith(
                  color: Theme.of(context).colorScheme.primaryVariant,
                ),
          ),
          SizedBox(height: 20),
          ToggleGroupeWrapped(
            options: [
              for (final mth in Months.values)
                context.translate(
                  mth.toString().split('.').last,
                )
            ],
          ),
        ],
      ],
    );
  }
}

class ToggleGroupeWrapped extends StatefulWidget {
  const ToggleGroupeWrapped({
    this.options,
    this.light = false,
    this.small = false,
    this.full = false,
  });
  final List<String> options;
  final bool light;
  final bool small;
  final bool full;

  @override
  _ToggleGroupeWrappedState createState() => _ToggleGroupeWrappedState();
}

class _ToggleGroupeWrappedState extends State<ToggleGroupeWrapped> {
  Set<String> selected = Set<String>();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        for (final option in widget.options)
          ToggleWrapped(
            selected: selected.contains(option),
            onTap: () {
              if (selected.contains(option))
                selected.remove(option);
              else
                selected.add(option);
              setState(() {});
            },
            light: widget.light,
            label: option,
            full: widget.full,
          ),
      ],
    );
  }
}

class ToggleWrapped extends StatelessWidget {
  const ToggleWrapped({
    Key key,
    @required this.selected,
    this.light = false,
    this.color,
    this.full = false,
    @required this.onTap,
    @required this.label,
  }) : super(key: key);

  final bool selected;
  final bool light;
  final bool full;
  final Color color;
  final String label;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: LayoutBuilder(
        builder: (_, constraints) => Container(
          padding:
              EdgeInsets.symmetric(vertical: 12, horizontal: full ? 15 : 20),
          width: full ? null : constraints.biggest.width / 2 - 5,
          decoration: BoxDecoration(
            border: Border.all(
              color: (color ?? Theme.of(context).colorScheme.primaryVariant)
                  .withOpacity(selected ? 1 : 0.25),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(4),
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: selected
                ? [
                    BoxShadow(
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.25),
                    )
                  ]
                : null,
          ),
          child: Row(
            children: [
              Container(
                width: Theme.of(context).textTheme.headline6.fontSize,
                height: Theme.of(context).textTheme.headline6.fontSize,
                decoration: BoxDecoration(
                  color:
                      light ? Theme.of(context).scaffoldBackgroundColor : null,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    width: 1,
                    color:
                        (color ?? Theme.of(context).colorScheme.primaryVariant)
                            .withOpacity(selected ? 1 : 0.75),
                  ),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.check,
                  size: Theme.of(context).textTheme.subtitle1.fontSize,
                  color: selected
                      ? (color ?? Theme.of(context).colorScheme.primaryVariant)
                      : Colors.transparent,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: light
                            ? Theme.of(context).scaffoldBackgroundColor
                            : Theme.of(context).colorScheme.primaryVariant,
                        fontWeight: selected ? FontWeight.bold : null,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
