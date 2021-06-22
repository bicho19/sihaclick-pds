import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-app-bar.dart';
// import 'package:sihaclik/elements/basics/wrapper-sliver.dart';

import 'package:sihaclik/helpers/sc-localization.dart';

class HistoryMaterialPage extends StatelessWidget {
  final elements = [];
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SCAppBar(
          title: context.translate('exchange_history'),
          small: true,
        ),
        // WrapperSliver(
        //   title: context.translate('medical_equipment'),
        //   iconName: "material",
        //   elements: elements,
        //   onPressed: () {
        //     // showGeneralDialog(
        //     //   context: context,
        //     //   barrierDismissible: true,
        //     //   barrierLabel:
        //     //       MaterialLocalizations.of(context).modalBarrierDismissLabel,
        //     //   barrierColor: Colors.black45,
        //     //   transitionDuration: const Duration(milliseconds: 200),
        //     //   pageBuilder: (BuildContext buildContext, Animation animation,
        //     //       Animation secondaryAnimation) {
        //     //     return FullscreenDialogMaterial();
        //     //   },
        //     // );
        //   },
        // ),
      ],
    );
  }
}
