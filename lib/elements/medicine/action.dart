import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sihaclik/pages/medicine/reminders/create-reminder.dart';

class MedicineSearchAction extends StatelessWidget {
  final void Function() onPressed;
  MedicineSearchAction({this.onPressed});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Image.asset(
        Directionality.of(context) == TextDirection.rtl
            ? "assets/images/quick-access-medicine-card-ar.png"
            : "assets/images/quick-access-medicine-card.png",
        height: 134,
        fit: BoxFit.contain,
        alignment: Alignment.center,
      ),
    );
  }
}

class MedicineReminderAction extends StatelessWidget {
  final CameraDescription camera;
  MedicineReminderAction({Key key, this.camera}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => MedicineAlertPage(
              camera: camera,
            ),
          ),
        );
      },
      child: Image.asset(
        Directionality.of(context) == TextDirection.rtl
            ? "assets/images/quick-access-clock-card-ar.png"
            : "assets/images/quick-access-clock-card.png",
        height: 134,
        fit: BoxFit.contain,
        alignment: Alignment.center,
      ),
    );
  }
}
