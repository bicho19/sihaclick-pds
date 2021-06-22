import 'package:flutter/material.dart';

class SCSegments extends StatelessWidget {
  final int pageIndex;
  final void Function(int) setPage;
  final List<String> titles;
  final bool smaller;
  final bool scrollable;
  final EdgeInsets padding;
  SCSegments({
    @required this.pageIndex,
    @required this.setPage,
    @required this.titles,
    this.smaller = false,
    this.scrollable = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            for (final idx in titles.asMap().keys)
              if (!scrollable)
                Expanded(
                  child: _SegmentsButton(
                    pageIndex: pageIndex,
                    idx: idx,
                    setPage: setPage,
                    titles: titles,
                    smaller: smaller,
                    padding: padding,
                  ),
                )
              else
                _SegmentsButton(
                  pageIndex: pageIndex,
                  idx: idx,
                  setPage: setPage,
                  titles: titles,
                  smaller: smaller,
                  padding: padding,
                ),
          ],
        ),
      ),
    );
  }
}

class _SegmentsButton extends StatelessWidget {
  final int pageIndex;
  final int idx;
  final void Function(int) setPage;
  final List<String> titles;
  final bool smaller;
  final EdgeInsets padding;

  const _SegmentsButton({
    Key key,
    @required this.pageIndex,
    @required this.idx,
    @required this.setPage,
    @required this.titles,
    @required this.smaller,
    this.padding = const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: pageIndex == idx ? Theme.of(context).colorScheme.primary : null,
      onPressed: () => setPage(idx),
      padding: padding,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Text(
        titles[idx],
        softWrap: false,
        overflow: TextOverflow.fade,
        style: Theme.of(context).textTheme.subtitle2.copyWith(
              fontSize:
                  smaller ? Theme.of(context).textTheme.caption.fontSize : null,
              height: 1.1,
              color: pageIndex == idx
                  ? Theme.of(context).colorScheme.secondary
                  : null,
            ),
      ),
    );
  }
}
