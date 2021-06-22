import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-app-bar.dart';
import 'package:sihaclik/elements/basics/sc-modal.dart';
import 'package:sihaclik/elements/basics/sc-search-bar.dart';
import 'package:sihaclik/elements/basics/sc-title.dart';
import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/helpers/timing.dart';
import 'package:sihaclik/pages/exchange/book/create.dart';
import 'package:sihaclik/pages/exchange/book/details.dart';
import 'package:sihaclik/pages/search/sc-search-types.dart';
import 'package:sihaclik/store/models/book_exchange.dart';
import 'package:sihaclik/store/notifiers/exchanges.dart';
import 'package:provider/provider.dart';

class BookExchangePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.watch<ExchangesNotifier>().getAllBookExchange(),
      builder: (_, AsyncSnapshot<List<BookExchange>> snapshots) {
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
                    type: SCSearchTypes.ExchangeBook,
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        SizedBox(height: 20),
                        SCTitle(title: context.translate('book')),
                        // Text(
                        //   context.watch<ExchangesNotifier>().filters.toString(),
                        // ),
                        SizedBox(height: 10),
                        for (final book in snapshots.data)
                          BookPreview(book: book),
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
                    builder: (_) => BookCreatePage(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class BookPreview extends StatelessWidget {
  final BookExchange book;
  const BookPreview({this.book});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => BookDetailsPage(book: book,),
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
                        "assets/icons/book.png",
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
                            book.name,
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
                          // No Description in our model YET
                          // Text(
                          //   book.description,
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
                            TimeFormat.formatAgo(context, book.createdAt),
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

                    ///If current user is the owner of the book, show delete button
                    ///
                    // if (book.user.id == currentUser.id)
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
          //Book Status, {Active, Suspended, Materialized
          if (book.bookStatus == BookStatus.SUSPENDED)
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
          if (book.bookStatus == BookStatus.MATERIALIZED)
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
                      context.translate('bookized'),
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
          if (book.bookStatus == BookStatus.ACTIVE)
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
