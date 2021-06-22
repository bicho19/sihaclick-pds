import 'package:flutter/material.dart';

class Option<T> {
  final String text;
  final T value;
  Option({this.text, this.value});
}

class SCDropdown<T> extends StatefulWidget {
  const SCDropdown({
    @required this.label,
    @required this.options,
    this.soft = false,
    this.raised = false,
    this.uppercase = false,
    this.callback,
    this.color,
    this.onChange,
    this.initial,
  });

  final bool soft;
  final bool uppercase;
  final bool raised;
  final Color color;
  final String label;
  final Option<T> initial;
  final List<Option<T>> options;
  final void Function() callback;
  final void Function(Option<T>) onChange;

  @override
  _SCDropdownState<T> createState() => _SCDropdownState<T>();
}

class _SCDropdownState<T> extends State<SCDropdown> {
  Option<T> selected;
  String get label => widget.label;
  bool get soft => widget.soft;
  List<Option<T>> get options => widget.options;
  bool open = false;
  @override
  void initState() {
    super.initState();
    selected = widget.initial;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Theme.of(context).colorScheme.secondary,
        boxShadow: open
            ? [
                BoxShadow(
                  blurRadius: 6,
                  offset: Offset(0, 3),
                  color: Colors.black.withOpacity(0.16),
                ),
              ]
            : null,
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              open = !open;
              setState(() {});
              if (open && widget.callback != null) widget.callback();
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: open
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).scaffoldBackgroundColor,
                border: soft
                    ? Border.all(
                        color: open
                            ? widget.color ??
                                Theme.of(context).colorScheme.primary
                            : widget.raised
                                ? Theme.of(context).colorScheme.surface
                                : Theme.of(context).colorScheme.onSurface,
                        width: 1.0,
                      )
                    : Border.all(
                        width: 1,
                        color: widget.color ??
                            Theme.of(context).colorScheme.primaryVariant,
                      ),
                boxShadow: open
                    ? [
                        BoxShadow(
                          blurRadius: 10,
                          color: Theme.of(context)
                              .colorScheme
                              .primaryVariant
                              .withOpacity(0.25),
                        )
                      ]
                    : (widget.raised
                        ? [
                            BoxShadow(
                              blurRadius: 1,
                              offset: Offset(0, 2),
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(0.25),
                            )
                          ]
                        : null),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.uppercase
                          ? (selected?.text ?? label).toUpperCase()
                          : (selected?.text ?? label),
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: selected == null && soft
                          ? Theme.of(context)
                              .inputDecorationTheme
                              .hintStyle
                              .copyWith(
                                color: widget.color?.withOpacity(0.5) ??
                                    Theme.of(context)
                                        .colorScheme
                                        .primaryVariant
                                        .withOpacity(0.5),
                              )
                          : Theme.of(context).textTheme.subtitle1.copyWith(
                                color: widget.color ??
                                    Theme.of(context)
                                        .colorScheme
                                        .primaryVariant,
                                fontWeight:
                                    widget.raised ? null : FontWeight.bold,
                              ),
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: widget.color ??
                        Theme.of(context).colorScheme.primaryVariant,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: open ? EdgeInsets.all(20) : EdgeInsets.zero,
            child: Column(
              children: [
                if (open)
                  for (final option in options)
                    GestureDetector(
                      onTap: () {
                        selected = option;
                        open = !open;
                        if (widget.onChange != null) widget.onChange(option);
                        setState(() {});
                      },
                      child: Container(
                        height: 50,
                        color: Theme.of(context).colorScheme.secondary,
                        child: Row(
                          children: [
                            Text(
                              widget.uppercase
                                  ? option.text.toUpperCase()
                                  : option.text,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                    color: widget.color ??
                                        Theme.of(context)
                                            .colorScheme
                                            .primaryVariant,
                                    fontWeight:
                                        widget.raised ? null : FontWeight.bold,
                                  ),
                            ),
                            Spacer(),
                            if (option.value == selected?.value)
                              Container(
                                width: 11,
                                height: 11,
                                margin: EdgeInsets.all(6.5),
                                decoration: BoxDecoration(
                                  color: widget.color ??
                                      Theme.of(context)
                                          .colorScheme
                                          .primaryVariant,
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
