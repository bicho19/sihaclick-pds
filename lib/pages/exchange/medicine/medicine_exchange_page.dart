import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-app-bar.dart';
import 'package:sihaclik/elements/basics/sc-modal.dart';
import 'package:sihaclik/elements/basics/sc-search-bar.dart';
import 'package:sihaclik/elements/basics/sc-title.dart';
import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/helpers/timing.dart';
import 'package:sihaclik/pages/exchange/medicine/create.dart';
import 'package:sihaclik/pages/exchange/medicine/details.dart';
import 'package:sihaclik/pages/search/sc-search-types.dart';
import 'package:sihaclik/store/models/medicine-exchange.dart';
import 'package:sihaclik/store/notifiers/exchanges.dart';
import 'package:provider/provider.dart';

class MedicinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.watch<ExchangesNotifier>().getAllMedicineExchange(),
        builder: (_, AsyncSnapshot<List<MedicineExchange>> snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          if (snapshots.hasData && snapshots.data != null)
            return Container(
              color: Theme.of(context).colorScheme.background,
              child: Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      SCAppBar(title: context.translate('exchange')),
                      SCSearchBar(
                        type: SCSearchTypes.ExchangeMedicine,
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            SizedBox(height: 20),
                            SCTitle(title: context.translate('medicine')),
                            // Text(
                            //   context.watch<ExchangesNotifier>().filters.toString(),
                            // ),
                            SizedBox(height: 10),
                            for (final medicine in snapshots.data)
                              MedicinePreview(medicine: medicine),
                            SizedBox(
                              height: kBottomNavigationBarHeight +
                                  MediaQuery.of(context).padding.bottom,
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
                      onPressed: () => SCModal.scShowModalBottomSheet(
                        context,
                        builder: (_) => MedicineCreatePage(),
                      ),
                    ),
                  ),
                ],
              ),
            );
          else
            return Center(
              child: Text("Test ${snapshots.data}"),
            );
        });
  }
}

class MedicinePreview extends StatelessWidget {
  final MedicineExchange medicine;

  const MedicinePreview({this.medicine});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => MedicineDetailsPage(medicine: medicine),
          ),
        );
      },
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  children: [
                    Container(
                      height: 100,
                      width: 113,
                      decoration: BoxDecoration(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primaryVariant
                            .withOpacity(0.75),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    SizedBox(width: 16),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Image.asset(
                        "assets/icons/medicine.png",
                        width: 21,
                        height: 21,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            medicine.name,
                            textAlign: TextAlign.center,
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
                          Text(
                            medicine.dose,
                            textAlign: TextAlign.center,
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
                            TimeFormat.formatAgo(context, medicine.createdAt),
                            textAlign: TextAlign.center,
                            style: Theme
                                .of(context)
                                .textTheme
                                .caption
                                .copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .primary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// If this medicine belongs to current User, show delete option
                    ///
                    // if (medicine.status != null)
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
                    //       color: Theme.of(context).colorScheme.secondaryVariant,
                    //     ),
                    //   ),
                  ],
                ),
              ),
            ),
          ),
          if (medicine.status == MedicineStatus.SUSPENDED)
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
          if (medicine.status == MedicineStatus.MATERIALIZED)
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
          if (medicine.status == MedicineStatus.ACTIVE)
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
