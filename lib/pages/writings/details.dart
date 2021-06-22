import 'package:flutter/material.dart';
import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/store/models/writing.dart';

const double _kTabBarHeight = 50.0;

class WritingDetailsPage extends StatelessWidget {
  final Writing writing;
  WritingDetailsPage({@required this.writing});
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: SliverAppBar(
              safeAreaPadding: MediaQuery.of(context).padding,
              title: writing.title,
            ),
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //     top: 20.0,
                    //     left: 20.0,
                    //     right: 20.0,
                    //   ),
                    //   child: Text(
                    //     "Nous sommes les premiers qui ont presenter cette solution.",
                    //     style: Theme.of(context).textTheme.subtitle1.copyWith(
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        writing.description,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    Image.asset(
                      writing.image,
                      fit: BoxFit.fitWidth,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        writing.content,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 20,
                        left: 20,
                        right: 20,
                      ),
                      child: Text(
                        "${context.translate('written_by')}: ${writing.author}",
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(context).textTheme.bodyText2.color,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: _kTabBarHeight + MediaQuery.of(context).padding.bottom,
              ),
            ]),
          )
        ],
      ),
    );
  }
}

class SliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight = 206;
  final double elementHeight = 85;
  final String title;
  final EdgeInsets safeAreaPadding;
  SliverAppBar({@required this.safeAreaPadding, @required this.title});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.red,
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          Image.asset(
            "assets/images/generic5.jpg",
            fit: BoxFit.cover,
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
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 8),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: Theme.of(context).colorScheme.background,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text(
                      //       "Santé",
                      //       style: Theme.of(context).textTheme.headline6.copyWith(
                      //             height: 1.35,
                      //           ),
                      //     ),
                      //     Text(
                      //       "Maladies chroniques",
                      //       style: Theme.of(context).textTheme.subtitle2.copyWith(
                      //             color: Theme.of(context).colorScheme.primary,
                      //           ),
                      //     ),
                      //   ],
                      // ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: Text(
                            "Nous sommes les premiers qui ont presenter cette solution.",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      // IconButton(
                      //   onPressed: () {},
                      //   icon: Icon(Icons.favorite_border),
                      // )
                    ],
                  ),
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
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight + safeAreaPadding.top;

  @override
  double get minExtent => kToolbarHeight + safeAreaPadding.top;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
