import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-modal.dart';
import 'package:sihaclik/elements/basics/sc-page.dart';
import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/helpers/timing.dart';
import 'package:sihaclik/pages/notifications/preferences.dart';
import 'package:provider/provider.dart';
import 'package:sihaclik/store/notifiers/notifications.dart';

class NotificationsPage extends StatelessWidget {
  NotificationsPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SCPage(
      title: context.translate('notifications'),
      trailing: IconButton(
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        padding: EdgeInsets.all(0),
        onPressed: () {
          SCModal.scShowModalBottomSheet(context,
              builder: (_) => NotificationsPreferencesPage());
        },
        icon: Icon(Icons.more_horiz),
        color: Theme.of(context).colorScheme.secondary,
      ),
      children: [
        for (final notification
            in context.watch<NotificationsNotifier>().notifications)
          ListTile(
            title: Text(notification.title),
            subtitle: Text(notification.description),
            leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).colorScheme.primary,
                image: DecorationImage(
                  image: [
                    if (notification.type == 'check')
                      AssetImage("assets/icons/check-blue.png")
                    else if (notification.type == 'cancel')
                      AssetImage("assets/icons/cancel-blue.png")
                    else if (notification.type == 'new')
                      AssetImage("assets/icons/new-blue.png")
                    else
                      AssetImage("assets/icons/time-blue.png"),
                  ].first,
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                ),
              ),
            ),
            trailing: Text(
              TimeFormat.formatAgo(context, notification.date),
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        // ListTile(
        //   title: Text(context.translate('canceled_appointment')),
        //   subtitle: Text(SCLocalizations.of(context)
        //       .translate('canceled_appointment_content')),
        //   leading: Container(
        //     height: 50,
        //     width: 50,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(12),
        //       color: Theme.of(context).colorScheme.primary,
        //       image: DecorationImage(
        //         image: AssetImage("assets/icons/cancel-blue.png"),
        //         fit: BoxFit.contain,
        //         alignment: Alignment.center,
        //       ),
        //     ),
        //   ),
        //   trailing: Text(
        //     TimeFormat.formatAgo(
        //       context,
        //       DateTime.now().subtract(
        //         Duration(
        //           minutes: Random().nextInt(60),
        //         ),
        //       ),
        //     ),
        //     style: Theme.of(context).textTheme.caption,
        //   ),
        // ),
        // ListTile(
        //   title: Text(SCLocalizations.of(context)
        //       .translate('promotion')
        //       .split("#")
        //       .join("20")),
        //   subtitle: Text(context.translate('promotion_content')),
        //   leading: Container(
        //     height: 50,
        //     width: 50,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(12),
        //       color: Theme.of(context).colorScheme.primary,
        //       image: DecorationImage(
        //         image: AssetImage("assets/icons/new-blue.png"),
        //         fit: BoxFit.contain,
        //         alignment: Alignment.center,
        //       ),
        //     ),
        //   ),
        //   trailing: Text(
        //     TimeFormat.formatAgo(
        //       context,
        //       DateTime.now().subtract(
        //         Duration(
        //           minutes: Random().nextInt(60),
        //         ),
        //       ),
        //     ),
        //     style: Theme.of(context).textTheme.caption,
        //   ),
        // ),
        // ListTile(
        //   title: Text(SCLocalizations.of(context)
        //       .translate('this_is_the_processing_time')),
        //   subtitle: Text(SCLocalizations.of(context)
        //       .translate('this_is_the_processing_time_content')),
        //   leading: Container(
        //     height: 50,
        //     width: 50,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(12),
        //       color: Theme.of(context).colorScheme.primary,
        //       image: DecorationImage(
        //         image: AssetImage("assets/icons/time-blue.png"),
        //         fit: BoxFit.contain,
        //         alignment: Alignment.center,
        //       ),
        //     ),
        //   ),
        //   trailing: Text(
        //     TimeFormat.formatAgo(
        //       context,
        //       DateTime.now().subtract(
        //         Duration(
        //           minutes: Random().nextInt(60),
        //         ),
        //       ),
        //     ),
        //     style: Theme.of(context).textTheme.caption,
        //   ),
        // ),
      ],
    );
  }
}
