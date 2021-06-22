import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-card.dart';
import 'package:sihaclik/elements/basics/sc-page.dart';
import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/pages/history/medicine.dart';
import 'package:sihaclik/pages/history/book.dart';
import 'package:sihaclik/pages/history/material.dart';
import 'package:sihaclik/pages/history/blood.dart';
import 'package:sihaclik/pages/history/stage.dart';

enum Histories {
  ACTIVE,
  MATERIALIZED,
  SUSPENDED,
}

class HistoryPage extends StatelessWidget {
  HistoryPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SCPage(
      title: context.translate('exchange_history'),
      smaller: true,
      canPop: true,
      top: null,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SCCard(
                title:
                    SCLocalizations.of(context).translate('internship_request'),
                iconName: "stage",
                setPage: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => HistoryStagePage(),
                    ),
                  );
                },
              ),
              SCCard(
                title: SCLocalizations.of(context).translate('blood_donation'),
                iconName: "blood",
                setPage: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => HistoryBloodPage(),
                    ),
                  );
                },
              ),
              SCCard(
                title: context.translate('medicine'),
                iconName: "medicines",
                setPage: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => HistoryMedicinePage(),
                    ),
                  );
                },
              ),
              SCCard(
                title:
                    SCLocalizations.of(context).translate('medical_equipment'),
                iconName: "material",
                setPage: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => HistoryMaterialPage(),
                    ),
                  );
                },
              ),
              SCCard(
                title: context.translate('medical_book'),
                iconName: "book",
                setPage: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => HistoryBookPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
