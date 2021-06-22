import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-raised-button.dart';

class BiButton extends StatelessWidget {
  final EdgeInsets margin;
  const BiButton({
    Key key,
    @required this.nextTitle,
    @required this.nextOnPressed,
    this.margin = EdgeInsets.zero,
    this.backTitle,
    this.backOnPressed,
  })  : assert((backTitle == null && backOnPressed == null) ||
            (backTitle != null && backOnPressed != null)),
        super(key: key);
  final String nextTitle;
  final String backTitle;
  final void Function() nextOnPressed;
  final void Function() backOnPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (backTitle != null) ...[
          Expanded(
            child: GestureDetector(
              onTap: backOnPressed,
              child: Container(
                height: 50,
                margin: margin,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Theme.of(context).colorScheme.background,
                  border: Border.all(
                      width: 1, color: Theme.of(context).colorScheme.primary),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.25),
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    Icon(Icons.chevron_left,
                        color: Theme.of(context).colorScheme.primary),
                    SizedBox(width: 8),
                    Text(
                      backTitle,
                      style: Theme.of(context).textTheme.button.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
        ],
        Expanded(
          flex: 2,
          child: SCRaisedButton(
            title: nextTitle,
            withIcon: true,
            margin: margin,
            onPressed: () => nextOnPressed(),
          ),
        ),
      ],
    );
  }
}
