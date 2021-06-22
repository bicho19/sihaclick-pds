import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-page.dart';
import 'package:sihaclik/elements/controls/sc-segments.dart';
import 'package:sihaclik/elements/writing/event-preview.dart';
import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/pages/search/sc-search-types.dart';
import 'package:sihaclik/store/notifiers/writings.dart';
import 'package:provider/provider.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({
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
      title: context.translate('events'),
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
            for (final event in context.watch<WritingsNotifier>().events)
              EventPreview(event: event),
          ],
        ),
      ],
    );
  }
}
