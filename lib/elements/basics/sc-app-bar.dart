import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sihaclik/pages/notifications/notifications.dart';
import 'package:sihaclik/store/notifiers/notifications.dart';
import 'package:provider/provider.dart';

class SCAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool small;
  final bool smaller;
  final bool clear;
  final bool notifications;
  final bool canPop;
  final Widget trailing;
  final Widget bottom;
  final bool pinned;
  SCAppBar({
    @required this.title,
    this.small = false,
    this.smaller = false,
    this.clear = false,
    this.notifications = false,
    this.canPop = true,
    this.trailing,
    this.bottom,
    this.pinned = true,
  });
  @override
  Widget build(context) {
    return SliverAppBar(
      centerTitle: false,
      stretch: true,
      pinned: pinned,
      bottom: bottom,
      title: Text(
        title,
        style: small
            ? GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              )
            : (smaller
                ? GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                  )
                : (clear
                    ? TextStyle(
                        color: Theme.of(context).colorScheme.primaryVariant)
                    : null)),
      ),
      backgroundColor: clear ? Theme.of(context).colorScheme.background : null,
      leading: canPop
          ? IconButton(
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              padding: EdgeInsets.all(0),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
              color:
                  clear ? Theme.of(context).colorScheme.primaryVariant : null,
            )
          : IconButton(
              icon: Image.asset(
                "assets/icons/menu.png",
                color:
                    clear ? Theme.of(context).colorScheme.primaryVariant : null,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
      actions: [
        if (notifications)
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => NotificationsPage(),
                  ),
                ),
                icon: Container(
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: Theme.of(context).textTheme.overline.fontSize,
                            right:
                                Theme.of(context).textTheme.overline.fontSize /
                                    2),
                        child: Image.asset(
                          "assets/icons/notification.png",
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryVariant,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          context
                              .watch<NotificationsNotifier>()
                              .notifications
                              .length
                              .toString(),
                          style: Theme.of(context).textTheme.overline.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        else if (trailing != null)
          trailing
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
