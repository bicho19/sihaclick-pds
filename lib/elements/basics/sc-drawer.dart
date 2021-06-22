import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-raised-button.dart';
import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/pages/appointments/appointments.dart';
import 'package:sihaclik/pages/favorites/favorites.dart';
import 'package:sihaclik/pages/history/history.dart';
import 'package:sihaclik/pages/medicine/reminders/reminders.dart';
import 'package:sihaclik/pages/profile/profile.dart';
import 'package:sihaclik/store/services/auth_provider.dart';
import 'package:provider/provider.dart';

class SCDrawer extends StatelessWidget {
  final void Function(Widget) navigate;

  SCDrawer({this.navigate});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: SliverAppBar(
              safeAreaPadding: MediaQuery.of(context).padding,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SCListTile(
                        onTap: () => navigate(ProfilePage()),
                        title: context.translate('my_profile'),
                        iconName: "person",
                      ),
                      SCListTile(
                        onTap: () => navigate(FavoritesPage()),
                        title: SCLocalizations.of(context)
                            .translate('my_favorites_list'),
                        iconName: "heart",
                      ),
                      SCListTile(
                        onTap: () => navigate(MedicineAlertsPage()),
                        title: SCLocalizations.of(context)
                            .translate('my_medicine_alert'),
                        iconName: "reminder",
                      ),
                      SCListTile(
                        onTap: () => navigate(AppointmentsPage()),
                        title: SCLocalizations.of(context)
                            .translate('my_meetings'),
                        iconName: "paper",
                      ),
                      SCListTile(
                        onTap: () => navigate(HistoryPage()),
                        title: SCLocalizations.of(context)
                            .translate('exchange_history'),
                        iconName: "small-exchange",
                      ),
                      SCListTile(
                        title: context.translate('contact_us'),
                        iconName: "head-phone",
                      ),
                      SCListTile(
                        title: context.translate('about_us'),
                        iconName: "info",
                      ),
                      SCListTile(
                        title: SCLocalizations.of(context)
                            .translate('privacy_policy'),
                        iconName: "safe",
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Theme.of(context).colorScheme.primary,
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: SCListTile(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return SimpleDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              title: Text(
                                SCLocalizations.of(context)
                                    .translate('log_out_alert_title'),
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 24.0,
                                    bottom: 24.0,
                                    right: 24.0,
                                    top: 12,
                                  ),
                                  child: Text(
                                    SCLocalizations.of(context)
                                        .translate('log_out_alert_content'),
                                  ),
                                ),
                                Container(
                                  height: 41,
                                  child: Row(
                                    children: [
                                      SizedBox(width: 24),
                                      Expanded(
                                        child: SCRaisedButton(
                                          onPressed: () async {
                                            await context
                                                .read<AuthStateProvider>()
                                                .logout();
                                            Navigator.of(context)
                                                .pushNamedAndRemoveUntil(
                                              "/",
                                              (_) => false,
                                            );
                                          },
                                          title: SCLocalizations.of(context)
                                              .translate('confirm'),
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Expanded(
                                        child: SCRaisedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          title: SCLocalizations.of(context)
                                              .translate('cancel'),
                                          flat: true,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                        ),
                                      ),
                                      SizedBox(width: 24),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          });
                    },
                    title: context.translate('log_out'),
                    iconName: "out",
                    inverted: true,
                  ),
                ),
                // // SizedBottomSpacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SCListTile extends StatelessWidget {
  final String title;
  final String iconName;
  final bool inverted;
  final void Function() onTap;
  SCListTile({
    this.title,
    this.iconName,
    this.inverted = false,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pop(context);
        onTap?.call();
      },
      title: Container(
        child: Text(
          title,
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                color:
                    inverted ? Theme.of(context).colorScheme.secondary : null,
              ),
        ),
      ),
      leading: Container(
        width: 50,
        height: 50,
        alignment: Alignment.centerRight,
        child: Image.asset(
          "assets/icons/$iconName.png",
          alignment: Alignment.centerRight,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class SliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight = 206;
  final double elementHeight = 62;
  final EdgeInsets safeAreaPadding;
  SliverAppBar({@required this.safeAreaPadding});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {

    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        Image.asset(
          "assets/images/generic5.jpg",
          fit: BoxFit.cover,
          colorBlendMode: BlendMode.darken,
          color: Colors.black.withOpacity(0.75),
        ),
        Positioned(
          bottom: 40,
          left: 0,
          right: 0,
          child: Opacity(
            opacity: shrinkOffset / expandedHeight < 1
                ? 1 - shrinkOffset / expandedHeight
                : 0,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              height: expandedHeight,
              width: MediaQuery.of(context).size.width / 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 81,
                    width: 81,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .secondaryVariant
                          .withOpacity(0.75),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "${context
                        .read<AuthStateProvider>()
                        .currentUser
                        ?.name} ${context
                        .read<AuthStateProvider>()
                        .currentUser
                        ?.lastname}",
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline6
                        .copyWith(
                      color: Theme
                          .of(context)
                          .colorScheme
                          .secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  //TODO: TBD => show / hide username under full name in the drawer
//                  Text(
//                    "@aureliensalomon",
//                    style: Theme.of(context).textTheme.bodyText2.copyWith(
//                          color: Theme.of(context).colorScheme.surface,
//                        ),
//                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight + safeAreaPadding.top;

  @override
  double get minExtent => kToolbarHeight + safeAreaPadding.top;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
