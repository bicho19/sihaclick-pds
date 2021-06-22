import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-app-bar.dart';

import 'package:sihaclik/elements/controls/sc-dialog.dart';
import 'package:sihaclik/elements/controls/sc-drop-down.dart';
import 'package:sihaclik/elements/stage/bi-button.dart';

import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/helpers/sizing.dart';

import 'package:sihaclik/pages/history/stage.dart';
import 'package:sihaclik/pages/stage/duration.dart';
import 'package:sihaclik/pages/stage/period.dart';
import 'package:sihaclik/pages/stage/student.dart';
import 'package:sihaclik/pages/stage/type.dart';
import 'package:sihaclik/pages/stage/zone.dart';

class StagePage extends StatefulWidget {
  StagePage({Key key}) : super(key: key);
  final PageController _controller = PageController();
  @override
  _StagePageState createState() => _StagePageState();
}

class _StagePageState extends State<StagePage> {
  int pageIndex = 0;
  PageController get controller => widget._controller;
  @override
  Widget build(BuildContext context) {
    final _pureBottom =
        kTabBarHeight + MediaQuery.of(context).padding.bottom + 50 + 40;
    final _pureHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight -
        kTabBarHeight -
        MediaQuery.of(context).padding.bottom;
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: CustomScrollView(
        physics: NeverScrollableScrollPhysics(),
        slivers: [
          SCAppBar(
            title: context.translate('internship'),
          ),
          SliverFillRemaining(
            child: Stack(
              children: [
                PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: controller,
                  children: [
                    StageIndex(bottom: _pureBottom),
                    StageStudent(bottom: _pureBottom),
                    Stagetype(bottom: _pureBottom),
                    StageDuration(bottom: _pureBottom),
                    StagePeriod(bottom: _pureBottom),
                    StageZone(bottom: _pureBottom),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: _pureHeight - 40,
                    left: 20,
                    right: 20,
                  ),
                  alignment: Alignment.topCenter,
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: BiButton(
                      margin: EdgeInsets.zero,
                      nextTitle: context.translate('next'),
                      nextOnPressed: next,
                      backTitle:
                          pageIndex > 0 ? context.translate('back') : null,
                      backOnPressed: pageIndex > 0 ? back : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void next() async {
    if (pageIndex > 4) {
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return SCDialog(
              title: context.translate(
                  'the_internship_request_was_successfully_published'),
              subtitle: context.translate(
                  'the_internship_request_was_successfully_published_content'),
              imageName: "dialog-stage",
              label: context.translate('next'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => HistoryStagePage(),
        ),
      );
      return;
    }
    pageIndex = pageIndex + 1;
    controller.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
    setState(() {});
  }

  void back() {
    if (pageIndex < 1) return;
    pageIndex = pageIndex - 1;
    controller.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
    setState(() {});
  }
}

class StageIndex extends StatelessWidget {
  final double bottom;
  const StageIndex({
    Key key,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: bottom),
      children: [
        Text(
          SCLocalizations.of(context)
              .translate('are_you_looking_for_an_internship'),
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: Theme.of(context).colorScheme.primaryVariant,
              ),
        ),
        SizedBox(height: 4),
        Text(
          SCLocalizations.of(context)
              .translate('are_you_looking_for_an_internship_content'),
          style: Theme.of(context).textTheme.caption,
        ),
        SizedBox(height: 20),
        SCDropdown<String>(
          label: context.translate('status'),
          options: [
            context.translate('student'),
            context.translate('diploma'),
            context.translate('resident')
          ].map((e) => Option(text: e, value: e)).toList(),
        ),
      ],
    );
  }
}
