import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sihaclik/helpers/sizing.dart';

class SCCupertinoTabBar extends CupertinoTabBar {
  SCCupertinoTabBar({
    Key key,
    ValueChanged<int> onTap,
    @required int tabs,
  }) : super(
          items: List<BottomNavigationBarItem>(tabs),
          onTap: onTap,
        );

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    return Container(
      height: kTabBarHeight + bottomPadding,
      decoration: BoxDecoration(
        border: border,
      ),
      child: BNBar(setPageIndex: onTap),
    );
  }

  @override
  CupertinoTabBar copyWith(
      {Key key,
      List<BottomNavigationBarItem> items,
      Color backgroundColor,
      Color activeColor,
      Color inactiveColor,
      double iconSize,
      Border border,
      int currentIndex,
      onTap}) {
    return SCCupertinoTabBar(
      key: key ?? this.key,
      tabs: items ?? this.items.length,
      onTap: onTap ?? this.onTap,
    );
  }
}

class BNBar extends StatefulWidget {
  final void Function(int) setPageIndex;
  BNBar({this.setPageIndex});

  @override
  _BNBarState createState() => _BNBarState();
}

class _BNBarState extends State<BNBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BNBButton(
            title: "home",
            active: currentIndex == 0,
            onPressed: () {
              widget.setPageIndex(0);
              currentIndex = 0;
              setState(() {});
            },
          ),
          BNBButton(
            title: "doctor",
            active: currentIndex == 1,
            onPressed: () {
              widget.setPageIndex(1);
              currentIndex = 1;
              setState(() {});
            },
          ),
          BNBButton(
            title: "medicine",
            active: currentIndex == 2,
            onPressed: () {
              widget.setPageIndex(2);
              currentIndex = 2;
              setState(() {});
            },
          ),
          BNBButton(
            title: "exchange",
            active: currentIndex == 3,
            onPressed: () {
              widget.setPageIndex(3);
              currentIndex = 3;
              setState(() {});
            },
          ),
          BNBButton(
            title: "writing",
            active: currentIndex == 4,
            onPressed: () {
              widget.setPageIndex(4);
              currentIndex = 4;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}

class BNBButton extends StatelessWidget {
  final String title;
  final bool active;
  final void Function() onPressed;
  BNBButton({this.title, this.active, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: active
              ? BorderSide(
                  width: 2,
                  color: Theme.of(context).colorScheme.primary,
                )
              : BorderSide(
                  width: 2,
                  color: Colors.white,
                ),
        ),
      ),
      child: IconButton(
        icon: Image.asset(
          "assets/icons/$title.png",
          width: 27,
          height: 27,
          fit: BoxFit.contain,
          color: active ? Theme.of(context).colorScheme.primary : null,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
