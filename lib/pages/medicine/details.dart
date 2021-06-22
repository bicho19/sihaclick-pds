import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/shrinked-tile.dart';

import 'package:sihaclik/helpers/sc-localization.dart';

class MedicineDetailsPage extends StatelessWidget {
  MedicineDetailsPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate:
                SliverAppBar(safeAreaPadding: MediaQuery.of(context).padding),
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: EdgeInsets.only(bottom: 0, left: 20, right: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
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
                    SizedBox(height: 20),
                    ShrinkedRowTile(
                        title: context.translate('dosage'), subtitle: "######"),
                    ShrinkedRowTile(
                        title: context.translate('available'), subtitle: "##"),
                    ShrinkedRowTile(
                        title: context.translate('refundable'), subtitle: "##"),
                    ShrinkedRowTile(
                        title: SCLocalizations.of(context)
                            .translate('manufacturer_laboratory'),
                        subtitle: "#####"),
                    ShrinkedRowTile(
                        title: context.translate('generic'),
                        subtitle: "#######"),
                    ShrinkedRowTile(title: context.translate('setpoint')),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                        left: 20,
                        right: 20,
                        bottom: 20,
                      ),
                      child: Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
                            .replaceAll(RegExp('[^ ]'), '#'),
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    )
                  ],
                ),
              ),
              // SizedBottomSpacer(),
            ]),
          )
        ],
      ),
    );
  }
}

class SliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight = 206;
  final double elementHeight = 62;

  final EdgeInsets safeAreaPadding;
  SliverAppBar({@required this.safeAreaPadding});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          color: Theme.of(context).colorScheme.primaryVariant,
          alignment: Alignment.center,
          child: Container(
            height: 100,
            width: 113,
            margin: EdgeInsets.only(bottom: 20),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Opacity(
            opacity: shrinkOffset / expandedHeight < 1
                ? 1 - shrinkOffset / expandedHeight
                : 0,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: elementHeight,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(left: 20, top: 8),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                    ),
                  ),
                ),
                alignment: Alignment.bottomLeft,
                child: Text("Médicament Tev 100mg",
                    style: Theme.of(context).textTheme.headline5),
              ),
            ),
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
