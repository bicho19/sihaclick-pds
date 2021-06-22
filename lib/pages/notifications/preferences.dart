import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-modal.dart';
import 'package:sihaclik/elements/controls/sc-drop-down.dart';
import 'package:sihaclik/helpers/hashed.dart';
import 'package:sihaclik/helpers/sc-localization.dart';

class NotificationsPreferencesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SCModal(
      title: context.translate('notifications_preferences'),
      children: [
        SizedBox(height: 20),
        SwitchListTile(
          activeColor: Theme.of(context).colorScheme.primaryVariant,
          value: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 0),
          onChanged: (_) {
            // notifications = !notifications;
            // setState(() {});
          },
          title: Text(
            context.translate('professional_appointments_notifications'),
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: Theme.of(context).colorScheme.primaryVariant,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        SizedBox(height: 20),
        SwitchListTile(
          activeColor: Theme.of(context).colorScheme.primaryVariant,
          value: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 0),
          onChanged: (_) {
            // notifications = !notifications;
            // setState(() {});
          },
          title: Text(
            context.translate('medicine_reminders_notifications'),
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: Theme.of(context).colorScheme.primaryVariant,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 0),
          child: Text(
            context.translate('notifications_frequency'),
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: Theme.of(context).colorScheme.primaryVariant,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        SizedBox(height: 4),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 0),
          child: SCDropdown(
            soft: true,
            label: "",
            options: [
              for (final index in List(4).asMap().keys)
                Option(text: Hashed.words(1), value: index)
            ],
          ),
        ),
        SizedBox(height: 20),
        SwitchListTile(
          activeColor: Theme.of(context).colorScheme.primaryVariant,
          value: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 0),
          onChanged: (_) {
            // notifications = !notifications;
            // setState(() {});
          },
          title: Text(
            context.translate('blood_donation_notifications'),
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: Theme.of(context).colorScheme.primaryVariant,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        SizedBox(height: 40),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Theme.of(context).colorScheme.primary,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.25),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                SizedBox(width: 45),
                Text(
                  context.translate('confirm'),
                  style: Theme.of(context).textTheme.button.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ),
                Spacer(),
                Icon(Icons.chevron_right,
                    color: Theme.of(context).colorScheme.secondary),
                SizedBox(width: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
