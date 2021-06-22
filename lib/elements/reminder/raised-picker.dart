import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sihaclik/elements/reminder/camera.dart';
import 'package:sihaclik/pages/medicine/reminders/create-reminder-medicine.dart';
import 'package:sihaclik/store/models/medicine.dart';

class RaisedPicker extends StatelessWidget {
  final String title;
  final CameraDescription camera;
  final void Function() onPressed;
  final void Function(Medicine) setMedicine;
  const RaisedPicker({
    Key key,
    this.camera,
    this.onPressed,
    @required this.title,
    @required this.setMedicine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Theme.of(context).colorScheme.background,
          border: Border.all(
              width: 1, color: Theme.of(context).colorScheme.surface),
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              offset: Offset(0, 2),
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.25),
            )
          ],
        ),
        child: Row(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.50)),
            ),
            Spacer(),
            IconButton(
              onPressed: () async {
                final path = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => TakePictureScreen(
                      camera: camera,
                    ),
                  ),
                );
                if (path == null) return;
                final medicine = await showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  barrierColor: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.75),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10.0),
                    ),
                  ),
                  builder: (_) => ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10.0),
                    ),
                    child: CreateReminderMedicine(
                      path: path,
                    ),
                  ),
                );
                setMedicine(medicine);
              },
              icon: Icon(
                Icons.camera,
                color: Theme.of(context)
                    .colorScheme
                    .onBackground
                    .withOpacity(0.75),
              ),
            ),
            // Image.asset(
            //   "assets/icons/search.png",
            //   color:
            //       Theme.of(context).colorScheme.onBackground.withOpacity(0.75),
            //   width: Theme.of(context).textTheme.headline6.fontSize,
            //   height: Theme.of(context).textTheme.headline6.fontSize,
            // ),
          ],
        ),
      ),
    );
  }
}
