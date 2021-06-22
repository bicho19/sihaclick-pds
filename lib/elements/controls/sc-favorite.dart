import 'package:flutter/material.dart';

class SCFavorite extends StatelessWidget {
  const SCFavorite({
    Key key,
    this.initial = false,
    this.onChange,
  }) : super(key: key);

  final bool initial;
  final void Function(bool) onChange;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChange?.call(!initial);
      },
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(
          initial ? Icons.favorite : Icons.favorite_border,
          size: 18,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
