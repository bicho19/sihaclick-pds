import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-page.dart';
import 'package:sihaclik/elements/basics/sc-title.dart';
import 'package:sihaclik/elements/discover/marketing.dart';
import 'package:sihaclik/elements/discover/quick-access.dart';
import 'package:sihaclik/elements/medicine/action.dart';
import 'package:sihaclik/elements/writing/event-preview.dart';
import 'package:sihaclik/elements/writing/slides.dart';
import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/pages/writings/writings.dart';
import 'package:provider/provider.dart';
import 'package:sihaclik/store/notifiers/writings.dart';

class DiscoverPage extends StatelessWidget {
  final CameraDescription camera;
  DiscoverPage({Key key, this.camera}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SCPage(
      title: context.translate('discover'),
      canPop: false,
      notifications: true,
      top: null,
      searchable: true,
      children: [
        Marketing(),
        SizedBox(height: 20),
        QuickAccessProfessionals(),
        SizedBox(height: 20),
        QuickAccessExchange(),
        SizedBox(height: 30),
        MedicineSearchAction(),
        SizedBox(height: 20),
        MedicineReminderAction(camera: camera),
        SizedBox(height: 30),
        SCTitle(
          title: context.translate('events'),
          more: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => WritingsPage(canPop: true, events: true),
              ),
            );
          },
        ),
        EventPreview(event: context.watch<WritingsNotifier>().events.first),
        SizedBox(height: 20),
        SCTitle(
          title: context.translate('blog'),
          more: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => WritingsPage(canPop: true),
              ),
            );
          },
        ),
        WritingSlides(clean: true),
      ],
    );
  }
}
