import 'package:flutter/material.dart';
import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/pages/stage/period.dart';

class Stagetype extends StatelessWidget {
  final double bottom;
  Stagetype({
    Key key,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: bottom),
      children: [
        Text(
          context.translate('type_of_internship'),
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: Theme.of(context).colorScheme.primaryVariant,
              ),
        ),
        SizedBox(height: 20),
        ToggleGroupeWrapped(
          full: true,
          options: [
            context.translate('pharmaceutical_dispensary'),
            context.translate('medical_laboratory'),
            context.translate('medical_clinic'),
            context.translate('surgical_clinic'),
            context.translate('medico_surgical_clinic'),
            context.translate('medical_imaging_center'),
            context.translate('pharmaceutical_laboratory'),
            context.translate('private_medical_practice'),
            context.translate('university_hospital_center'),
            context.translate('fitness_center'),
            context.translate('thalassotherapy'),
            SCLocalizations.of(context)
                .translate('rehabilitation_center_and_physical_medicine'),
          ],
        ),
      ],
    );
  }
}
