import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-page.dart';
import 'package:sihaclik/elements/controls/sc-favorite.dart';
import 'package:sihaclik/elements/controls/sc-segments.dart';
import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/store/abstracts/widget-view.dart';
import 'package:provider/provider.dart';
import 'package:sihaclik/store/models/professional-types.dart';
import 'package:sihaclik/store/notifiers/professionals.dart';

class FavoritesPage extends StatefulWidget {
  final controller = PageController(keepPage: true);
  @override
  _FavoritesPageController createState() => _FavoritesPageController();
}

class _FavoritesPageController extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) => _FavoritesPageView(this);
  PageController get controller => widget.controller;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    // Timer.run(() {
    //   if (widget.events) setPage(1);
    // });
  }

  void setPage(int index) {
    this.pageIndex = index;
    controller.jumpToPage(pageIndex == 0 ? 0 : 1);
    setState(() {});
  }
}

class _FavoritesPageView extends WidgetView<FavoritesPage, _FavoritesPageController> {
  _FavoritesPageView(_FavoritesPageController state) : super(state);

  @override
  Widget build(BuildContext context) {
    final types = context.watch<ProfessionalsNotifier>().favorites;
    return PageView(
      controller: state.controller,
      physics: NeverScrollableScrollPhysics(),
      children: [
        for (final _ in types)
          IndexPage(
            canPop: true,
            pageIndex: state.pageIndex,
            setPage: state.setPage,
            types: types,
          ),
      ],
    );
  }
}

class IndexPage extends StatelessWidget {
  const IndexPage({
    Key key,
    @required this.canPop,
    @required this.pageIndex,
    @required this.setPage,
    @required this.types,
  }) : super(key: key);

  final bool canPop;
  final int pageIndex;
  final void Function(int) setPage;
  final List<ProfessionalTypes> types;

  @override
  Widget build(BuildContext context) {
    return SCPage(
      title: context.translate('my_favorites_list'),
      canPop: canPop,
      small: true,
      bottom: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 65),
        child: Column(
          children: [
            Container(
              color: Theme.of(context).colorScheme.primary,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                child: Container(
                  height: 41,
                  child: SCSegments(
                    smaller: true,
                    pageIndex: pageIndex,
                    scrollable: true,
                    padding: EdgeInsets.all(4),
                    setPage: setPage,
                    titles: [
                      for (final type in types) type.title,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      children: [
        for (final professional in types[pageIndex].professionals)
          Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFE5ECF3),
                  blurRadius: 4,
                  offset: Offset(0, 1),
                ),
              ],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Container(
                  height: 91,
                  width: 90,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryVariant.withOpacity(0.75),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(professional.id ?? 'no-id'),
                      Text(professional.title),
                      SizedBox(height: 8),
                      FittedBox(
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/icons/location.png",
                              width: 13,
                              height: 13,
                              alignment: Alignment.topCenter,
                            ),
                            SizedBox(width: 8),
                            Text(
                              context.translate('cheraga') +
                                  " - " +
                                  SCLocalizations.of(context).translate('algiers'),
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(color: Theme.of(context).colorScheme.primary),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                SCFavorite(
                  initial: true,
                  onChange: (_) {
                    context.read<ProfessionalsNotifier>().removeFavorite(
                          type: types[pageIndex],
                          professional: professional,
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

// class TypePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     CustomScrollView(
//       slivers: [
//         SCAppBar(
//           title: context.translate('my_favorites_list'),
//           clear: true,
//         ),
//         SliverList(
//           delegate: SliverChildListDelegate(
//             [
//               SizedBox(height: 20),
//               SCTitle(title: context.translate('doctor')),
//               SCListTile(
//                 title: "Dr. Mohamed Achouri",
//                 // subtitle: context.translate('doctor'),
//                 // shareable: true,
//                 // remouvable: true,
//               ),
//               SCListTile(
//                 title: "Dr. Mohamed Achouri",
//                 // subtitle: context.translate('doctor'),
//                 // shareable: true,
//                 // remouvable: true,
//               ),
//               SCListTile(
//                 title: "Dr. Mohamed Achouri",
//                 // subtitle: context.translate('doctor'),
//                 // shareable: true,
//                 // remouvable: true,
//                 // last: true,
//               ),
//               SizedBox(height: 20),
//               SCTitle(title: context.translate('pharmacist')),
//               SCListTile(
//                 title: "Dr. Mohamed Achouri",
//                 // subtitle: context.translate('pharmacist'),
//                 // shareable: true,
//                 // remouvable: true,
//               ),
//               SCListTile(
//                 title: "Dr. Mohamed Achouri",
//                 // subtitle: context.translate('pharmacist'),
//                 // shareable: true,
//                 // remouvable: true,
//               ),
//               SCListTile(
//                 title: "Dr. Mohamed Achouri",
//                 // subtitle: context.translate('pharmacist'),
//                 // shareable: true,
//                 // remouvable: true,
//                 // last: true,
//               ),
//               // SizedBottomSpacer(),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
