import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-app-bar.dart';
import 'package:sihaclik/elements/basics/sc-search-bar.dart';
import 'package:sihaclik/pages/search/sc-search-types.dart';

const double _kTabBarHeight = 50.0;

class SCPage extends StatelessWidget {
  SCPage({
    this.title,
    this.header,
    this.canPop = true,
    this.searchable = false,
    this.searchType = SCSearchTypes.All,
    this.notifications = false,
    this.trailing,
    this.top = const SizedBox(height: 20),
    this.bottom,
    this.smaller = false,
    this.small = false,
    @required this.children,
  }) : assert((header != null || title != null) &&
            !(header == null && title == null));

  final Widget header;
  final Widget bottom;
  final String title;
  final bool smaller;
  final bool small;
  final bool canPop;
  final bool searchable;
  final bool notifications;
  final SCSearchTypes searchType;
  final List<Widget> children;
  final Widget top;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: CustomScrollView(
        slivers: [
          if (header != null)
            header
          else ...[
            SCAppBar(
              title: title,
              notifications: notifications,
              canPop: canPop,
              trailing: trailing,
              smaller: smaller,
              small: small,
              bottom: bottom,
            ),
            if (searchable)
              SCSearchBar(
                title: title,
                type: searchType,
              ),
          ],
          SliverList(
            delegate: SliverChildListDelegate(
              [
                if (top != null) top,
                ...children,
                SizedBox(
                  height:
                      _kTabBarHeight + MediaQuery.of(context).padding.bottom,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
