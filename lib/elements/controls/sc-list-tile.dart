import 'package:flutter/material.dart';

class ListTile extends StatelessWidget {
  final bool last;
  final bool bold;
  final bool shareable;
  final bool remouvable;
  final String title;
  final String subtitle;
  final Widget leading;
  final Widget trailing;
  final EdgeInsets margin;
  final void Function() onPressed;
  const ListTile({
    this.last = false,
    this.bold = false,
    @required this.title,
    @required this.subtitle,
    this.leading,
    this.trailing,
    this.onPressed,
    this.margin,
    this.remouvable = false,
    this.shareable = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: margin ?? EdgeInsets.only(left: last ? 0 : 20),
        padding: EdgeInsets.only(
            top: 20, left: last ? 20 : 0, right: 20, bottom: 20),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            leading ??
                Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .secondaryVariant
                        .withOpacity(0.75),
                    shape: BoxShape.circle,
                  ),
                ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                          fontWeight: bold ? FontWeight.bold : null,
                        ),
                  ),
                  Text(
                    subtitle,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
            if (trailing != null) ...[
              SizedBox(width: 12),
              trailing,
            ],
            if (shareable || remouvable) SizedBox(width: 8),
            if (shareable)
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.share),
                color: Theme.of(context).colorScheme.primaryVariant,
                iconSize: Theme.of(context).textTheme.headline6.fontSize,
              ),
            if (remouvable)
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.close),
                color: Theme.of(context).colorScheme.secondaryVariant,
              ),
          ],
        ),
      ),
    );
  }
}
