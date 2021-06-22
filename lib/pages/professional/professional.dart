import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-page.dart';
import 'package:sihaclik/elements/basics/sc-title.dart';

import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/pages/professional/calendar.dart';
import 'package:sihaclik/pages/professional/details.dart';
import 'package:sihaclik/pages/search/sc-search-types.dart';
import 'package:provider/provider.dart';
import 'package:sihaclik/store/models/pds_model.dart';
import 'package:sihaclik/store/models/professional.dart';
import 'package:sihaclik/store/notifiers/pds_notifier.dart';
import 'package:sihaclik/store/notifiers/professionals.dart';
import 'package:sihaclik/utils/extensions.dart';

class ProfessionalPage extends StatelessWidget {
  final bool back;
  ProfessionalPage({
    Key key,
    this.back = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.watch<PDSNotifier>().getListOfPDS(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProfessionalDS>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        return SCPage(
          title: context.translate('health_professional_short'),
          searchType: SCSearchTypes.Professional,
          canPop: false,
          notifications: true,
          searchable: true,
          children: [
            ProfessionalSection(
              title: "Les Medecin",
              professionals: snapshot.data,
            ),
            SizedBox(height: 40),
          ],
        );
        // todo: Old design with sections
        /*
        SCPage(
        title: context.translate('health_professional_short'),
        searchType: SCSearchTypes.Professional,
        canPop: false,
        notifications: true,
        searchable: true,
        children: [
          for (final type in context.watch<ProfessionalsNotifier>().professionals) ...[
            ProfessionalSection(
              title: "Les Medecin",
              professionals: type.professionals,
            ),
            SizedBox(height: 40),
          ]
        ],
      );
         */
      },
    );
  }
}

class ProfessionalSection extends StatelessWidget {
  final String title;
  final List<ProfessionalDS> professionals;

  ProfessionalSection({this.title, this.professionals});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SCTitle(title: title),
        for (final index in professionals.asMap().keys)
          ProfessionalListTile(
            type: title,
            professional: professionals[index],
            last: professionals.length == index + 1,
          ),
      ],
    );
  }
}

class ProfessionalListTile extends StatelessWidget {
  final bool last;
  final ProfessionalDS professional;
  final String type;

  const ProfessionalListTile({
    this.last = false,
    this.professional,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Directionality.of(context) == TextDirection.rtl
          ? EdgeInsets.only(right: last ? 0 : 20)
          : EdgeInsets.only(left: last ? 0 : 20),
      padding: Directionality.of(context) == TextDirection.rtl
          ? EdgeInsets.only(
              top: 20,
              right: last ? 20 : 0,
              left: 10,
              bottom: 20,
            )
          : EdgeInsets.only(
              top: 20,
              left: last ? 20 : 0,
              right: 10,
              bottom: 20,
            ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 91,
            width: 90,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryVariant.withOpacity(0.75),
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("#${professional.pdsId.toString()}",
                              overflow: TextOverflow.ellipsis,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .subtitle1),
                          Text("${professional.name
                              .capitalizeFirst} ${professional.lastname
                              .capitalizeFirst}",
                              overflow: TextOverflow.ellipsis,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .subtitle1),
                          Text(type,
                              overflow: TextOverflow.ellipsis,
                              style: Theme
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
                                professional.address.address +
                                    " - " +
                                    professional.address.commune.wilaya.nom,
                                overflow: TextOverflow.ellipsis,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(color: Theme
                                    .of(context)
                                    .colorScheme
                                    .primary),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      height: 29,
                      child: OutlineButton(
                        highlightedBorderColor: Theme.of(context).colorScheme.primary,
                        borderSide: BorderSide(
                          width: 1,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  ProfessionalDetailsPage(professional: professional),
                            ),
                          );
                        },
                        child: Text(
                          context.translate('profile'),
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 29,
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => CalendarPage()),
                            );
                          },
                          color: Theme.of(context).colorScheme.primary,
                          child: Center(
                            child: Text(
                              context.translate('make_an_appointment'),
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: Theme.of(context).textTheme.caption.copyWith(
                                    color: Theme.of(context).colorScheme.secondary,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
