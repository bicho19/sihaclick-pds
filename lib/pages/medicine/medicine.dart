import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-page.dart';
import 'package:sihaclik/elements/medicine/action.dart';

import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/pages/search/sc-search-delegate.dart';
import 'package:sihaclik/pages/search/sc-search-types.dart';

import 'package:sihaclik/pages/search/sc-search.dart';

class MedicinePage extends StatelessWidget {
  final CameraDescription camera;
  MedicinePage({Key key, this.camera}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SCPage(
      title: context.translate('medicine'),
      notifications: true,
      searchType: SCSearchTypes.Medicine,
      searchable: true,
      canPop: false,
      children: [
        MedicineSearchAction(onPressed: () async {
          final _ = await showSCSearch(
            context: context,
            title: context.translate('search'),
            type: SCSearchTypes.Medicine,
            delegate: SCSearchDelegate(
              type: SCSearchTypes.Medicine,
            ),
          );
        }),
        SizedBox(height: 20),
        MedicineReminderAction(camera: camera),
      ],
    );
  }
}
