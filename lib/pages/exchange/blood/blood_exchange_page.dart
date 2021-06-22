import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-app-bar.dart';
import 'package:sihaclik/elements/basics/sc-modal.dart';
import 'package:sihaclik/elements/basics/sc-search-bar.dart';
import 'package:sihaclik/elements/basics/sc-title.dart';
import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/helpers/timing.dart';
import 'package:sihaclik/pages/exchange/blood/create.dart';
import 'package:sihaclik/pages/exchange/blood/details.dart';
import 'package:sihaclik/pages/search/sc-search-types.dart';
import 'package:sihaclik/store/models/blood-exchange.dart';
import 'package:sihaclik/store/notifiers/exchanges.dart';
import 'package:provider/provider.dart';

class BloodExchangePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SCAppBar(title: context.translate('exchange')),
              SCSearchBar(
                type: SCSearchTypes.ExchangeBlood,
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizedBox(height: 20),
                    SCTitle(title: context.translate('book')),
                    getBloodDonations(context),
                    SizedBox(
                      height: kBottomNavigationBarHeight +
                          MediaQuery
                              .of(context)
                              .padding
                              .bottom,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20 + MediaQuery.of(context).padding.bottom,
            right: 20,
            child: FloatingActionButton(
              child: Icon(
                Icons.add,
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
              onPressed: () =>
                  SCModal.scShowModalBottomSheet(
                    context,
                    builder: (_) => BloodCreatePage(),
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getBloodDonations(BuildContext context) {
    return FutureBuilder(
        future: context.watch<ExchangesNotifier>().getAllBloodDonation(),
        builder: (_, AsyncSnapshot<List<BloodExchange>> snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          if (!snapshots.hasData || snapshots.data == null)
            return Center(
              child: Text("No data has been retrieved"),
            );
          return ListView.builder(
            itemCount: snapshots.data.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, position) {
              return BloodPreview(
                blood: snapshots.data[position],
              );
            },
          );
          // for (final blood in snapshots.data)
          //   BloodPreview(blood: blood)
        });
  }
}

class BloodPreview extends StatelessWidget {
  final BloodExchange blood;
  final void Function() onPressed;

  const BloodPreview({this.blood, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => BloodDetailsPage(blood: blood),
          ),
        );
      },
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Padding(
            padding:
                // element.status == null
                //     ? const EdgeInsets.all(20.0)
                //     :
                const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            height: 100,
                            width: 113,
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryVariant
                                  .withOpacity(0.75),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            SCLocalizations.of(context)
                                .translate('need_blood') +
                                " Default A+",
                            style:
                            Theme
                                .of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .primaryVariant,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            (blood.user.chaab.address.commune.wilaya.nom ??
                                "Adresse") +
                                ' ' +
                                (blood.user.chaab.address.commune.nom ?? ""),
                            style:
                            Theme
                                .of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Wrap(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: Text(
                                      TimeFormat.formatAgo(
                                        context,
                                        blood.createdAt,
                                      ),
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .subtitle2
                                          .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                ],
                              ),
                              Container(
                                height: 40,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      SCLocalizations.of(context)
                                          .translate('urgent'),
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .subtitle2
                                          .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme
                                            .of(context)
                                            .colorScheme
                                            .secondaryVariant,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Image.asset(
                                      "assets/icons/heart-rate.png",
                                      color: Theme
                                          .of(context)
                                          .colorScheme
                                          .secondaryVariant,
                                    ),
                                    // if this blood belongs to crrent user, show delete option
                                    // if (blood.status != null) ...[
                                    //   Spacer(),
                                    //   Container(
                                    //     width: 40,
                                    //     height: 40,
                                    //     margin: EdgeInsets.only(bottom: 4),
                                    //     child: IconButton(
                                    //       highlightColor: Colors.transparent,
                                    //       splashColor: Colors.transparent,
                                    //       onPressed: () {},
                                    //       padding: EdgeInsets.all(0),
                                    //       icon: Icon(Icons.delete),
                                    //       color: Theme.of(context)
                                    //           .colorScheme
                                    //           .secondaryVariant,
                                    //     ),
                                    //   ),
                                    // ]
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (blood.status == BloodStatus.SUSPENDED)
            Transform.rotate(
              angle: -pi / 90.0,
              child: Container(
                height: 29,
                width: 120,
                margin: EdgeInsets.only(top: 20, left: 15),
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: () {},
                  color: Theme
                      .of(context)
                      .colorScheme
                      .secondaryVariant,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Center(
                    child: Text(
                      context.translate('suspended'),
                      style: Theme
                          .of(context)
                          .textTheme
                          .caption
                          .copyWith(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .secondary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          if (blood.status == BloodStatus.MATERIALIZED)
            Transform.rotate(
              angle: -pi / 90.0,
              child: Container(
                height: 29,
                width: 120,
                margin: EdgeInsets.only(top: 20, left: 15),
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: () {},
                  color: Theme
                      .of(context)
                      .colorScheme
                      .onBackground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Center(
                    child: Text(
                      context.translate('materialized'),
                      style: Theme
                          .of(context)
                          .textTheme
                          .caption
                          .copyWith(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .secondary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          if (blood.status == BloodStatus.ACTIVE)
            Transform.rotate(
              angle: -pi / 90.0,
              child: Container(
                height: 29,
                width: 120,
                margin: EdgeInsets.only(top: 20, left: 15),
                alignment: Alignment.centerRight,
                child: FlatButton(
                  onPressed: () {},
                  color: Theme
                      .of(context)
                      .colorScheme
                      .primaryVariant,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Center(
                    child: Text(
                      context.translate('in_progress'),
                      style: Theme
                          .of(context)
                          .textTheme
                          .caption
                          .copyWith(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .secondary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
