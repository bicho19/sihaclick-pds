import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-app-bar.dart';
import 'package:sihaclik/elements/basics/shrinked-tile.dart';
import 'package:sihaclik/helpers/hashed.dart';
import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/store/models/blood-exchange.dart';

class BloodDetailsPage extends StatelessWidget {
  final BloodExchange blood;
  BloodDetailsPage({
    this.blood,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SCAppBar(
              title: "",
              clear: true,
            ),
            SliverToBoxAdapter(
              child: Container(
                margin:
                    EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
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
                      Row(
                        children: [
                          Expanded(
                            child: ShrinkedColumnTile(
                              title: context.translate('last_name'),
                              subtitle: blood.user.lastname,
                              margin: EdgeInsets.zero,
                            ),
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            child: ShrinkedColumnTile(
                              title: context.translate('first_name'),
                              subtitle: blood.user.name,
                              margin: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ShrinkedColumnTile(
                              title: context.translate('wilaya'),
                              subtitle:
                                  blood.user.chaab.address.commune.wilaya.nom,
                              margin: EdgeInsets.zero,
                            ),
                          ),
                          SizedBox(height: 10),
                          Expanded(
                            child: ShrinkedColumnTile(
                              title: context.translate('town'),
                              subtitle: blood.user.chaab.address.commune.nom,
                              margin: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      ShrinkedColumnTile(
                        title: context.translate('need'),
                        // subtitle:
                        //     "${blood.group}, ${context.translate(blood.type.toLowerCase())}",
                        subtitle: "A, Positive + ",
                        margin: EdgeInsets.zero,
                      ),
                      SizedBox(height: 10),
                      ShrinkedColumnTile(
                        title: SCLocalizations.of(context)
                            .translate('phone_number'),
                        subtitle: blood.user.phone,
                        margin: EdgeInsets.zero,
                      ),
                      SizedBox(height: 10),
                      ShrinkedColumnTile(
                        title: "Require",
                        subtitle: blood.require ? "Yes" : "No",
                        margin: EdgeInsets.zero,
                      ),
                      SizedBox(height: 10),
                      ShrinkedColumnTile(
                        title: "Emergency",
                        subtitle: blood.emergency ? "Yes" : "No",
                        margin: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
