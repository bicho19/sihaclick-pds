import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-app-bar-bottom-sheet.dart';
import 'package:sihaclik/helpers/sizing.dart';

class SCModal extends StatelessWidget {
  SCModal({
    Key key,
    @required this.title,
    @required this.children,
  }) : super(key: key);

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final _pureHeight = MediaQuery.of(context).size.height -
        20 -
        MediaQuery.of(context).padding.bottom;

    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(8.0),
      ),
      child: Container(
        height: _pureHeight,
        color: Theme.of(context).colorScheme.background,
        child: CustomScrollView(
          slivers: [
            SCAppBarBottomSheet(title: title),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ...children,
                        SizedBox(
                          height: kTabBarHeight +
                              MediaQuery.of(context).padding.bottom,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void scShowModalBottomSheet(context,
          {@required Widget Function(BuildContext) builder}) =>
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        barrierColor:
            Theme.of(context).colorScheme.onBackground.withOpacity(0.75),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(8.0),
          ),
        ),
        builder: builder,
      );
}
