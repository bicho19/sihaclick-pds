import 'package:flutter/material.dart';
import 'package:sihaclik/elements/controls/sc-drop-down.dart';

import 'package:sihaclik/helpers/sc-localization.dart';

class StageStudent extends StatelessWidget {
  final double bottom;
  final ScrollController controller = ScrollController();
  StageStudent({
    Key key,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: controller,
      padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: bottom),
      children: [
        Text(
          context.translate('you_are_a_student_in'),
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: Theme.of(context).colorScheme.primaryVariant,
              ),
        ),
        SizedBox(height: 20),
        SCDropdown<String>(
          label: context.translate('specialty'),
          options: [
            context.translate('medicine'),
            context.translate('pharmacy'),
            context.translate('dental_medicine'),
            context.translate('biology'),
            context.translate('veterinary_medicine'),
            context.translate('paramedical'),
          ].map((e) => Option(text: e, value: e)).toList(),
        ),
        SizedBox(height: 20),
        Text(
          SCLocalizations.of(context)
              .translate('you_wish_to_carry_out_this_internship_as_part_of'),
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: Theme.of(context).colorScheme.primaryVariant,
              ),
        ),
        SizedBox(height: 20),
        SCDropdown<String>(
          label: context.translate('frame'),
          options: [
            context.translate('end_of_study_internship'),
            context.translate('university_internship'),
          ].map((e) => Option(text: e, value: e)).toList(),
        ),
        SizedBox(height: 20),
        Text(
          context.translate('specify_the_year'),
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: Theme.of(context).colorScheme.primaryVariant,
              ),
        ),
        SizedBox(height: 20),
        SCDropdown<String>(
          label: context.translate('specify_the_year'),
          options: ["1", "2", "3", "4", "5", "6", "7"]
              .map((e) => Option(text: e, value: e))
              .toList(),
          callback: () async {
            await Future.delayed(Duration(milliseconds: 200));
            controller.animateTo(
              controller.position.maxScrollExtent,
              duration: Duration(milliseconds: 200),
              curve: Curves.easeOut,
            );
          },
        ),
      ],
    );
  }
}
