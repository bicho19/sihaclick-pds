import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-app-bar.dart';
import 'package:sihaclik/elements/basics/sc-modal.dart';
import 'package:sihaclik/elements/basics/sc-search-bar.dart';
import 'package:sihaclik/elements/basics/sc-title.dart';
import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/helpers/timing.dart';
import 'package:sihaclik/pages/exchange/material/create.dart';
import 'package:sihaclik/pages/exchange/material/details.dart';
import 'package:sihaclik/pages/search/sc-search-types.dart';
import 'package:sihaclik/store/models/material_exchange.dart';
import 'package:sihaclik/store/notifiers/exchanges.dart';
import 'package:provider/provider.dart';

class MedicalMaterialExchangePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.watch<ExchangesNotifier>().getAllMaterialExchange(),
        builder: (_, AsyncSnapshot<List<MaterialExchange>> snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          return Container(
            color: Theme.of(context).colorScheme.background,
            child: Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    SCAppBar(title: context.translate('exchange')),
                    SCSearchBar(
                      type: SCSearchTypes.ExchangeMaterial,
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          SizedBox(height: 20),
                          SCTitle(title: context.translate('material')),
                          // Text(
                          //   context.watch<ExchangesNotifier>().filters.toString(),
                          // ),
                          SizedBox(height: 10),
                          for (final material in snapshots.data)
                            MaterialPreview(material: material),
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
                      builder: (_) => MaterialCreatePage(),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class MaterialPreview extends StatelessWidget {
  final MaterialExchange material;
  const MaterialPreview({this.material});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => MaterialDetailsPage(material: material,),
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
                        "assets/icons/material.png",
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
                            material.name,
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
                          //This material does not have description in the backend ?
                          // Text(
                          //   material.description,
                          //   textAlign: TextAlign.center,
                          //   style:
                          //       Theme.of(context).textTheme.subtitle1.copyWith(
                          //             fontWeight: FontWeight.bold,
                          //             color: Theme.of(context)
                          //                 .colorScheme
                          //                 .primaryVariant,
                          //           ),
                          // ),
                          SizedBox(height: 8),
                          Text(
                            TimeFormat.formatAgo(context, material.createdAt),
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

                    /// If this material belongs to the current user, show delete option
                    ///
                    // if (material.status != null)
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
          if (material.status == MaterialStatus.SUSPENDED)
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
          if (material.status == MaterialStatus.MATERIALIZED)
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
          if (material.status == MaterialStatus.ACTIVE)
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
