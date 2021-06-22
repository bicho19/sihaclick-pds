import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-card.dart';
import 'package:sihaclik/elements/basics/sc-page.dart';
import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/pages/exchange/blood/blood_exchange_page.dart';
import 'package:sihaclik/pages/exchange/book/book_exchange_page.dart';
import 'package:sihaclik/pages/exchange/material/material_exchange.dart';
import 'package:sihaclik/pages/exchange/medicine/medicine_exchange_page.dart';
import 'package:sihaclik/pages/search/sc-search-types.dart';
import 'package:sihaclik/pages/stage/stage.dart';

class ExchangePage extends StatelessWidget {
  ExchangePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SCPage(
      title: context.translate('exchange'),
      canPop: false,
      notifications: true,
      searchable: true,
      searchType: SCSearchTypes.All,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SCCard(
                title: context.translate('internship_request'),
                iconName: "stage",
                setPage: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => StagePage(),
                  ),
                ),
              ),
              SCCard(
                title: context.translate('blood_donation'),
                iconName: "blood",
                setPage: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => BloodExchangePage(),
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
                      builder: (_) => MedicinePage(),
                    ),
                  );
                },
              ),
              SCCard(
                title: context.translate('medical_equipment'),
                iconName: "material",
                setPage: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => MedicalMaterialExchangePage(),
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
                      builder: (_) => BookExchangePage(),
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
