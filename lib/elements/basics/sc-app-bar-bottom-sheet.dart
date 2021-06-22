import 'package:flutter/material.dart';

class SCAppBarBottomSheet extends StatelessWidget {
  final String title;
  const SCAppBarBottomSheet({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: false,
      stretch: true,
      pinned: true,
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline6.copyWith(
              color: Theme.of(context).colorScheme.primaryVariant,
            ),
      ),
      leading: null,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.close),
          color: Theme.of(context).colorScheme.primaryVariant,
        ),
      ],
    );
  }
}
