import 'package:flutter/material.dart';

class SCRaisedButton extends StatelessWidget {
  const SCRaisedButton({
    Key key,
    @required this.onPressed,
    @required this.title,
    this.withIcon = false,
    this.margin = EdgeInsets.zero,
    this.flat = false,
    this.small = false,
    this.bold = false,
    this.color,
  }) : super(key: key);

  final void Function() onPressed;
  final String title;
  final bool withIcon;
  final bool flat;
  final bool small;
  final Color color;
  final bool bold;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: 50,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: !flat
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSecondary,
          boxShadow: !flat
              ? [
                  BoxShadow(
                    blurRadius: 10,
                    color: Theme.of(context)
                        .colorScheme
                        .primaryVariant
                        .withOpacity(0.25),
                  )
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            if (withIcon) SizedBox(width: 55),
            Text(
              title,
              style: Theme.of(context).textTheme.button.copyWith(
                    color: color ?? Theme.of(context).colorScheme.secondary,
                    fontWeight: bold ? FontWeight.bold : null,
                    fontSize: small
                        ? Theme.of(context).textTheme.caption.fontSize
                        : null,
                  ),
            ),
            if (withIcon) SizedBox(width: 30),
            if (withIcon)
              Icon(
                Icons.chevron_right,
                color: color ?? Theme.of(context).colorScheme.secondary,
              ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
