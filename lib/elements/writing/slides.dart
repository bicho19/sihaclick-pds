import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-title.dart';
import 'package:sihaclik/elements/writing/preview.dart';
import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:provider/provider.dart';
import 'package:sihaclik/store/notifiers/writings.dart';

class WritingSlides extends StatelessWidget {
  final controller = PageController(viewportFraction: 0.85);
  final bool clean;

  WritingSlides({this.clean = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (!clean) SCTitle(title: context.translate('novelty')),
        Container(
          height: 200,
          width: 400,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: PageScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 10),
            children: [
              for (final writing in context.watch<WritingsNotifier>().writings)
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: WritingPreview(writing: writing, large: true),
                )
            ],
          ),
        ),
      ],
    );
  }
}
