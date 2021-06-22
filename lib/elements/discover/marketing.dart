import 'dart:async';

import 'package:flutter/material.dart';

class Marketing extends StatefulWidget {
  final PageController _controller = PageController(initialPage: 0);
  Marketing({
    Key key,
  }) : super(key: key);

  @override
  _MarketingState createState() => _MarketingState();
}

class _MarketingState extends State<Marketing> {
  PageController get controller => widget._controller;
  int page = 0;
  Timer timer;

  final pubs = [
    const AssetImage("assets/images/pub.png"),
    const AssetImage("assets/images/pub2.png"),
    const AssetImage("assets/images/pub3.png")
  ];

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 2100), (timer) {
      if (!this.mounted) return;
      controller.nextPage(
        duration: Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
      page = controller.page.toInt() % pubs.length;
      setState(() {});
    });
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 174,
          child: PageView.builder(
            controller: controller,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: pubs[index % pubs.length],
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 14,
          margin: EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (final index in pubs.asMap().keys)
                AnimatedContainer(
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  duration: Duration(milliseconds: 200),
                  width: page == index ? 14 : 6,
                  height: page == index ? 14 : 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: page == index
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context)
                            .colorScheme
                            .background
                            .withOpacity(0.85),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
