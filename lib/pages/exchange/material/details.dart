import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-app-bar.dart';
import 'package:sihaclik/elements/basics/shrinked-tile.dart';
import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/helpers/timing.dart';
import 'package:sihaclik/store/models/material_exchange.dart';

class MaterialDetailsPage extends StatelessWidget {
  final MaterialExchange material;
  const MaterialDetailsPage({this.material});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: CustomScrollView(
        slivers: [
          SCAppBar(
            title: "Details of material",
            smaller: true,
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: kBottomNavigationBarHeight +
                    MediaQuery.of(context).padding.bottom,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Theme.of(context)
                        .colorScheme
                        .primaryVariant
                        .withOpacity(0.25),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (material.imageName != null &&
                        material.imgPath.isNotEmpty)
                      Image.network(
                        material.imgPath,
                        fit: BoxFit.contain,
                        height: 222,
                      )
                    else
                      Container(
                        height: 222,
                        width: 113,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primaryVariant
                              .withOpacity(0.75),
                        ),
                      ),
                    SizedBox(height: 20),
                    ShrinkedColumnTile(
                      title: SCLocalizations.of(context)
                          .translate('material_name'),
                      subtitle: material.name,
                      margin: EdgeInsets.zero,
                    ),
                    SizedBox(height: 10),
                    ShrinkedColumnTile(
                      title: SCLocalizations.of(context)
                          .translate('expiration_date'),
                      subtitle: TimeFormat.format(context, material.createdAt),
                      margin: EdgeInsets.zero,
                    ),
                    SizedBox(height: 10),
                    ShrinkedColumnTile(
                      title: context.translate('wilaya') +
                          " - " +
                          context.translate('town'),
                      subtitle:
                          "${material.user.chaab.address.commune.wilaya.nom} - ${material.user.chaab.address.commune.nom}",
                      margin: EdgeInsets.zero,
                    ),
                    SizedBox(height: 10),
                    ShrinkedColumnTile(
                      title: context.translate('quantity'),
                      subtitle: material.quantity.toString(),
                      margin: EdgeInsets.zero,
                    ),
                    SizedBox(height: 10),
                    ShrinkedColumnTile(
                      title: context.translate('phone_number'),
                      subtitle: material.user.phone,
                      margin: EdgeInsets.zero,
                    ),
                    SizedBox(height: 10),
                    ShrinkedColumnTile(
                      title: "Approved:",
                      subtitle: material.isApproved ? "Yes" : "No",
                      margin: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
