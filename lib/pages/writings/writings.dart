import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-page.dart';
import 'package:sihaclik/elements/basics/sc-title.dart';
import 'package:sihaclik/elements/controls/sc-segments.dart';
import 'package:sihaclik/elements/writing/preview.dart';
import 'package:sihaclik/elements/writing/slides.dart';
import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/pages/search/sc-search-types.dart';
import 'package:sihaclik/pages/writings/events.dart';
import 'package:sihaclik/store/notifiers/writings.dart';
import 'package:provider/provider.dart';

class WritingsPage extends StatefulWidget {
  final bool canPop;
  final bool events;
  WritingsPage({
    Key key,
    this.canPop = false,
    this.events = false,
  }) : super(key: key);

  final controller = PageController(keepPage: true);
  @override
  _WritingsPageState createState() => _WritingsPageState();
}

class _WritingsPageState extends State<WritingsPage> {
  PageController get controller => widget.controller;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    Timer.run(() {
      if (widget.events) setPage(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      physics: NeverScrollableScrollPhysics(),
      children: [
        IndexPage(
          canPop: widget.canPop,
          pageIndex: pageIndex,
          setPage: setPage,
        ),
        EventsPage(
          canPop: widget.canPop,
          pageIndex: pageIndex,
          setPage: setPage,
        ),
      ],
    );
  }

  void setPage(int index) {
    this.pageIndex = index;
    controller.jumpToPage(pageIndex == 0 ? 0 : 1);
    setState(() {});
  }
}

class IndexPage extends StatelessWidget {
  const IndexPage({
    Key key,
    @required this.canPop,
    @required this.pageIndex,
    @required this.setPage,
  }) : super(key: key);

  final bool canPop;
  final int pageIndex;
  final void Function(int) setPage;

  @override
  Widget build(BuildContext context) {
    return SCPage(
      title: context.translate('blog'),
      notifications: true,
      canPop: canPop,
      searchType: SCSearchTypes.Writing,
      searchable: true,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: SCSegments(
            pageIndex: pageIndex,
            setPage: setPage,
            titles: [context.translate('blog'), context.translate('events')],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            WritingSlides(),
            SizedBox(height: 20),
            SCTitle(title: context.translate('sihaclik_writings')),
            for (final writing in context.watch<WritingsNotifier>().writings)
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: WritingPreview(writing: writing),
              ),
          ],
        ),
      ],
    );
  }
}
