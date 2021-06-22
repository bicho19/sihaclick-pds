import 'package:flutter/material.dart';
import 'package:sihaclik/helpers/sizing.dart';

class SCFloatingActionButton extends StatelessWidget {
  final Color backgroundColor;
  final void Function() onPressed;
  SCFloatingActionButton({
    this.onPressed,
    this.backgroundColor,
  });
  @override
  Widget build(BuildContext context) {
    final _pureHeight = MediaQuery.of(context).size.height -
        kToolbarHeight -
        kTabBarHeight -
        MediaQuery.of(context).padding.bottom;
    return Positioned(
      top: _pureHeight + 30,
      right: 20,
      child: FloatingActionButton(
        onPressed: onPressed,
        child: Icon(Icons.add),
        backgroundColor:
            backgroundColor ?? Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
