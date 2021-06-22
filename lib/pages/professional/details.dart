import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-raised-button.dart';
import 'package:sihaclik/elements/controls/sc-favorite.dart';
import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/helpers/timing.dart';
import 'package:sihaclik/pages/professional/calendar.dart';
import 'package:sihaclik/store/models/pds_model.dart';
import 'package:sihaclik/utils/extensions.dart';

const double _kTabBarHeight = 50.0;

class ProfessionalDetailsPage extends StatelessWidget {
  const ProfessionalDetailsPage({this.professional});

  final ProfessionalDS professional;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: SliverAppBar(
                safeAreaPadding: MediaQuery.of(context).padding,
                professional: professional),
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.16),
                        offset: Offset(0, 2),
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Container(
                              height: 41,
                              child: SCRaisedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (_) => CalendarPage()),
                                  );
                                },
                                title: SCLocalizations.of(context)
                                    .translate('make_an_appointment'),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 41,
                              child: SCRaisedButton(
                                onPressed: () {},
                                title: SCLocalizations.of(context).translate('locate'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 20,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/icons/phone.png',
                              width: 16,
                              height: 16,
                              fit: BoxFit.contain,
                              color: Theme.of(context).colorScheme.primaryVariant,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "${professional.fixNumber} / ${professional
                                  .faxNumber}",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .subtitle2,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/icons/email.png',
                              width: 16,
                              height: 16,
                              fit: BoxFit.contain,
                              color: Theme.of(context).colorScheme.primaryVariant,
                            ),
                            SizedBox(width: 10),
                            Text(
                              professional.email,
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                      ),
                      ShrinkedColumnTile(
                        title: SCLocalizations.of(context).translate(
                            'service_parameter'),
                        subtitle:
                        professional.pdsOptions.conventions.map((
                            service) => '- $service').join('\n'),
                      ),
                      ShrinkedColumnTile(
                        title: context.translate('structure'),
                        subtitle: professional.pdsOptions.structure.name,
                      ),
                      if (professional.pdsOptions.homeConsultation == 1)
                        ShrinkedRowTile(
                          title: SCLocalizations.of(context).translate(
                              'home_consultation'),
                          subtitle: professional.pdsOptions.homeConsultation ==
                              1 ? "Yes" : "No",
                        ),
                      //todo : fix opens after
                      // ShrinkedRowTile(
                      //   title: context.translate('open_after'),
                      //   subtitle: TimeFormat.formatAgo(
                      //     context,
                      //     professional.opening,
                      //     allowFromNow: true,
                      //   ),
                      // ),
                      //todo: fix holidays
                      // ShrinkedRowTile(
                      //   title: context.translate('holidays'),
                      //   subtitle: professional.holidays.join(', '),
                      // ),
                      ShrinkedRowTile(
                        title: context.translate('week_end'),
                        subtitle: professional.pdsOptions.holidays == 1
                            ? context.translate('yes')
                            : context.translate('no'),
                      ),
                      ShrinkedColumnTile(
                        title: context.translate('agreements'),
                        subtitle: "(" +
                            professional.pdsOptions.conventions.map((e) => '${e
                                .name}').join(', ') + ")",
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${context.translate('experience')}: ",
                              style: Theme.of(context).textTheme.subtitle2.copyWith(
                                    color: Theme.of(context).colorScheme.primaryVariant,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Container(
                                width: 49,
                                height: 4,
                                color: Theme.of(context).colorScheme.primary),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(height: 16),
                                FittedBox(
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 80,
                                        width: 90,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondaryVariant
                                              .withOpacity(0.75),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Container(
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "### #########",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1
                                                      .copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primaryVariant,
                                                      ),
                                                ),
                                                Text(
                                                  "##### ###### ## \n####-####",
                                                  style: Theme.of(context).textTheme.subtitle1,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 16),
                                FittedBox(
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 80,
                                        width: 90,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primaryVariant
                                              .withOpacity(0.75),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Container(
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "### #########",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1
                                                      .copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primaryVariant,
                                                      ),
                                                ),
                                                Text(
                                                  "##### ###### ## \n####-####",
                                                  style: Theme.of(context).textTheme.subtitle1,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${context.translate('voluntary_activities')}: ",
                              style: Theme.of(context).textTheme.subtitle2.copyWith(
                                    color: Theme.of(context).colorScheme.primaryVariant,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Container(
                                width: 49,
                                height: 4,
                                color: Theme.of(context).colorScheme.primary),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(height: 16),
                                FittedBox(
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 80,
                                        width: 90,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primaryVariant
                                              .withOpacity(0.75),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Container(
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "### #########",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1
                                                      .copyWith(
                                                        fontWeight: FontWeight.bold,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primaryVariant,
                                                      ),
                                                ),
                                                Text(
                                                  "##### ###### ## \n####-####",
                                                  style: Theme.of(context).textTheme.subtitle1,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ShrinkedColumnTile(
                        title: context.translate('languages'),
                        subtitle: professional.languages.map((e) => '${e.name
                            .capitalizeFirst}').join(' - '),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: _kTabBarHeight + MediaQuery.of(context).padding.bottom,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ShrinkedRowTile extends StatelessWidget {
  const ShrinkedRowTile({
    @required this.title,
    this.subtitle,
  });
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title + (subtitle != null ? ": " : ""),
            style: Theme.of(context).textTheme.subtitle2.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primaryVariant,
                ),
          ),
          if (subtitle != null)
            Expanded(
              child: Text(
                subtitle,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
        ],
      ),
    );
  }
}

class ShrinkedColumnTile extends StatelessWidget {
  const ShrinkedColumnTile({
    @required this.title,
    this.subtitle,
  });
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "$title: ",
            style: Theme.of(context).textTheme.subtitle2.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primaryVariant,
                ),
          ),
          if (subtitle != null)
            Text(
              subtitle,
              style: Theme.of(context).textTheme.subtitle2,
            ),
        ],
      ),
    );
  }
}

class SliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight = 206;
  final double elementHeight = 62;
  final ProfessionalDS professional;

  final EdgeInsets safeAreaPadding;

  SliverAppBar({@required this.safeAreaPadding, @required this.professional});

  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        Image.asset(
          "assets/images/generic5.jpg",
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Opacity(
            opacity: shrinkOffset / expandedHeight < 1 ? 1 -
                shrinkOffset / expandedHeight : 0,
            child: ProfessionalDetailsListTile(professional: professional,),
          ),
        ),
        Align(
          alignment: Directionality.of(context) == TextDirection.rtl
              ? Alignment.topRight
              : Alignment.topLeft,
          child: SafeArea(
            bottom: false,
            child: Container(
              width: elementHeight - 10,
              height: elementHeight - 10,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
                color: Theme.of(context).colorScheme.secondary,
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

class ProfessionalDetailsListTile extends StatelessWidget {
  final ProfessionalDS professional;

  const ProfessionalDetailsListTile({Key key, @required this.professional})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 91,
            width: 91,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryVariant.withOpacity(0.75),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Dr. ${professional.name
                          .capitalizeFirst} - ${professional.lastname
                          .capitalizeFirst}",
                          style: Theme
                              .of(context)
                              .textTheme
                              .subtitle1),
                      Text("Pharmacien", style: Theme
                          .of(context)
                          .textTheme
                          .subtitle2),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Image.asset(
                            "assets/icons/location.png",
                            width: 13,
                            height: 13,
                            alignment: Alignment.topCenter,
                          ),
                          SizedBox(width: 8),
                          Text(
                            context.translate('cheraga') +
                                " - " +
                                SCLocalizations.of(context).translate('algiers'),
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(color: Theme.of(context).colorScheme.primary),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SCFavorite(),
        ],
      ),
    );
  }
}
