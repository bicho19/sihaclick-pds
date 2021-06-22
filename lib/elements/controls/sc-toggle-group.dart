import 'package:flutter/material.dart';

class SCToggleGroupe extends StatefulWidget {
  const SCToggleGroupe({
    this.options,
    this.light = false,
    this.small = false,
  });
  final List<String> options;
  final bool light;
  final bool small;

  @override
  _SCToggleGroupeState createState() => _SCToggleGroupeState();
}

class _SCToggleGroupeState extends State<SCToggleGroupe> {
  Set<String> selected = Set<String>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final option in widget.options)
          SCToggle(
            selected: selected.contains(option),
            onTap: () {
              if (selected.contains(option))
                selected.remove(option);
              else
                selected.add(option);
              setState(() {});
            },
            light: widget.light,
            child: Expanded(
              child: Text(
                option,
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: widget.light
                          ? Theme.of(context).scaffoldBackgroundColor
                          : Theme.of(context).colorScheme.primaryVariant,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
      ],
    );
  }
}

class SCToggle extends StatelessWidget {
  const SCToggle({
    Key key,
    @required this.selected,
    this.light = false,
    this.color,
    @required this.onTap,
    @required this.child,
  }) : super(key: key);

  final bool selected;
  final bool light;
  final Color color;
  final Widget child;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        margin: EdgeInsets.symmetric(vertical: 2),
        color: Colors.transparent,
        child: Row(
          children: [
            Container(
              width: Theme.of(context).textTheme.headline6.fontSize,
              height: Theme.of(context).textTheme.headline6.fontSize,
              decoration: BoxDecoration(
                color: light ? Theme.of(context).scaffoldBackgroundColor : null,
                border: Border.all(
                  width: 1,
                  color: color ?? Theme.of(context).colorScheme.primaryVariant,
                ),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 100),
                width: Theme.of(context).textTheme.overline.fontSize,
                height: Theme.of(context).textTheme.overline.fontSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected
                      ? (color ?? Theme.of(context).colorScheme.primaryVariant)
                      : Colors.transparent,
                ),
              ),
            ),
            SizedBox(width: 10),
            Container(
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

class SCCheckbox extends StatelessWidget {
  const SCCheckbox({
    Key key,
    @required this.selected,
    this.light = false,
    this.color,
    @required this.onTap,
    @required this.child,
  }) : super(key: key);

  final bool selected;
  final bool light;
  final Color color;
  final Widget child;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        margin: EdgeInsets.symmetric(vertical: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: Theme.of(context).textTheme.headline6.fontSize - 2,
              height: Theme.of(context).textTheme.headline6.fontSize - 2,
              margin: EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                color: light ? Theme.of(context).scaffoldBackgroundColor : null,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  width: 1,
                  color: color ?? Theme.of(context).colorScheme.primaryVariant,
                ),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.check,
                size: Theme.of(context).textTheme.subtitle2.fontSize,
                color: selected
                    ? (color ?? Theme.of(context).colorScheme.primaryVariant)
                    : Colors.transparent,
              ),
            ),
            SizedBox(width: 10),
            Container(
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
