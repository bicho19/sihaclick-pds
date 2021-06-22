import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-title.dart';
import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/pages/exchange/blood/blood_exchange_page.dart';
import 'package:sihaclik/pages/exchange/book/book_exchange_page.dart';
import 'package:sihaclik/pages/exchange/material/material_exchange.dart';
import 'package:sihaclik/pages/exchange/medicine/medicine_exchange_page.dart';
import 'package:sihaclik/pages/stage/stage.dart';
import 'package:sihaclik/store/notifiers/professionals.dart';
import 'package:provider/provider.dart';

class QuickAccess {
  final String title;
  final List<int> colors;
  final String imageName;
  final void Function() onPressed;

  const QuickAccess({
    this.title,
    this.colors = const [0xFF13C2D4, 0xFF13C2D4],
    this.imageName,
    this.onPressed,
  });
}

class QuickAccessCard extends StatelessWidget {
  final String title;
  final List<int> colors;
  final String imageName;
  final void Function() onPressed;
  const QuickAccessCard({
    @required this.title,
    this.colors = const [0xFF13C2D4, 0xFF13C2D4],
    @required this.imageName,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 110,
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(colors.first),
                    Color(colors.last),
                  ],
                ),
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: Color(colors.last).withOpacity(0.45),
                    offset: Offset(0, 3.0),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              width: 115,
              height: 104,
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.all(8),
              child: Container(
                width: double.infinity,
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: Theme.of(context).textTheme.caption.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ),
              ),
            ),
          ),
          Image.asset(
            "assets/images/$imageName.png",
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}

class QuickAccessSection extends StatelessWidget {
  const QuickAccessSection({
    @required this.title,
    @required this.quickAccessList,
  });

  final String title;
  final List<QuickAccess> quickAccessList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SCTitle(title: title),
        Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                for (final quickAccess in quickAccessList) ...[
                  QuickAccessCard(
                    title: quickAccess.title,
                    imageName: quickAccess.imageName,
                    colors: quickAccess.colors,
                    onPressed: quickAccess.onPressed,
                  ),
                  SizedBox(width: 16),
                ]
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class QuickAccessExchange extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return QuickAccessSection(
      title: context.translate('exchange_type'),
      quickAccessList: [
        QuickAccess(
          title: context.translate('medicine'),
          imageName: "quick-access-medicine",
          colors: [0xFF80F96A, 0xFF1BA765],
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => MedicinePage(),
            ),
          ),
        ),
        QuickAccess(
          title: context.translate('blood'),
          imageName: "quick-access-blood",
          colors: [0xFFFF195E, 0xFFBC1574],
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BloodExchangePage(),
            ),
          ),
        ),
        QuickAccess(
          title: context.translate('medical_equipment'),
          imageName: "quick-access-material",
          colors: [0xFF13C2D4, 0xFF114C98],
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => MedicalMaterialExchangePage(),
              ),
            );
          },
        ),
        QuickAccess(
          title: context.translate('medical_book'),
          imageName: "quick-access-book",
          colors: [0xFFFFBDA7, 0xFFFF3131],
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BookExchangePage(),
            ),
          ),
        ),
        QuickAccess(
          title: context.translate('internship_request'),
          imageName: "quick-access-internship",
          colors: [0xFFCAAAF9, 0xFF301BB1],
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => StagePage(),
            ),
          ),
        ),
      ],
    );
  }
}

class QuickAccessProfessionals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final professionals = context.watch<ProfessionalsNotifier>().professionals;
    List<Color> colors = [
      Color(0xFF13C2D4),
      Color(0xFF3F13D4),
      Color(0xFF13D433),
      Color(0xFFB294ED),
      Color(0xFFFFA895),
      Color(0xFFD4C113),
      Color(0xFFFF500E),
      Color(0xFF1360D4),
      Color(0xFF85C8ED),
      Color(0xFFF43B79),
    ];
    final difference = professionals.length - colors.length;
    if (difference > 0)
      for (final _ in List(difference))
        colors.add(colors[Random().nextInt(colors.length)]);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SCTitle(
          title: SCLocalizations.of(context)
              .translate('health_professional_partners'),
        ),
        Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                for (final index in professionals.asMap().keys) ...[
                  GestureDetector(
                    onTap: () {},
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: colors[index],
                            borderRadius: BorderRadius.circular(2),
                            boxShadow: [
                              BoxShadow(
                                color: colors[index].withOpacity(0.45),
                                offset: Offset(0, 3.0),
                                blurRadius: 4.0,
                              ),
                            ],
                          ),
                          child: Text(
                            professionals[index].title,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                ]
              ],
            ),
          ),
        ),
      ],
    );
  }
}
