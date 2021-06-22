import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sihaclik/elements/basics/sc-app-bar.dart';
import 'package:sihaclik/elements/basics/sc-search-bar.dart';
import 'package:sihaclik/elements/controls/sc-segments.dart';
import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/pages/search/sc-search-types.dart';

Future<T> showSCSearch<T>({
  @required BuildContext context,
  @required SCAbstractSearchDelegate<T> delegate,
  String query = '',
  String title = '',
  bool smaller = false,
  SCSearchTypes type,
}) {
  assert(delegate != null);
  assert(context != null);
  delegate.query = query ?? delegate.query;
  delegate.currentBody = SearchBody.suggestions;
  return Navigator.of(context).push(SearchPageRoute<T>(
    delegate: delegate,
    title: title,
    smaller: smaller,
    type: type,
  ));
}

abstract class SCAbstractSearchDelegate<T> {
  SCAbstractSearchDelegate({
    this.searchFieldLabel,
    this.searchFieldStyle,
    this.keyboardType,
    this.textInputAction = TextInputAction.search,
  });

  Widget buildSuggestions(BuildContext context, SCSearchTypes type);

  Widget buildResults(BuildContext context, SCSearchTypes type);

  Widget buildLeading(BuildContext context);

  List<Widget> buildActions(BuildContext context);

  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      primaryColor: Colors.white,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
      primaryColorBrightness: Brightness.light,
      primaryTextTheme: theme.textTheme,
    );
  }

  String get query => queryTextController.text;
  set query(String value) {
    assert(query != null);
    queryTextController.text = value;
  }

  void showResults(BuildContext context) {
    focusNode?.unfocus();
    currentBody = SearchBody.results;
  }

  void showSuggestions(BuildContext context) {
    assert(focusNode != null,
        'focusNode must be set by route before showSuggestions is called.');
    focusNode.requestFocus();
    currentBody = SearchBody.suggestions;
  }

  void close(BuildContext context, T result) {
    currentBody = null;
    focusNode?.unfocus();
    Navigator.of(context)
      ..popUntil((Route<dynamic> route) => route == route)
      ..pop(result);
  }

  final String searchFieldLabel;

  final TextStyle searchFieldStyle;

  final TextInputType keyboardType;

  final TextInputAction textInputAction;

  Animation<double> get transitionAnimation => proxyAnimation;

  FocusNode focusNode;

  final TextEditingController queryTextController = TextEditingController();

  final ProxyAnimation proxyAnimation =
      ProxyAnimation(kAlwaysDismissedAnimation);

  final ValueNotifier<SearchBody> currentBodyNotifier =
      ValueNotifier<SearchBody>(null);

  SearchBody get currentBody => currentBodyNotifier.value;
  set currentBody(SearchBody value) {
    currentBodyNotifier.value = value;
  }

  SearchPageRoute<T> route;
}

enum SearchBody {
  suggestions,

  results,
}

class SearchPageRoute<T> extends PageRoute<T> {
  final String title;
  final bool smaller;
  final SCSearchTypes type;

  SearchPageRoute({
    @required this.delegate,
    this.title,
    this.smaller,
    this.type,
  }) : assert(delegate != null) {
    assert(
      delegate.route == null,
      'The ${delegate.runtimeType} instance is currently used by another active '
      'search. Please close that search by calling close() on the SCAbstractSearchDelegate '
      'before openening another search with the same delegate instance.',
    );
    delegate.route = this;
  }

  final SCAbstractSearchDelegate<T> delegate;

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get maintainState => false;

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  @override
  Animation<double> createAnimation() {
    final Animation<double> animation = super.createAnimation();
    delegate.proxyAnimation.parent = animation;
    return animation;
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return SearchPage<T>(
      delegate: delegate,
      animation: animation,
      title: title,
      smaller: smaller,
      type: type,
    );
  }

  @override
  void didComplete(T result) {
    super.didComplete(result);
    assert(delegate.route == this);
    delegate.route = null;
    delegate.currentBody = null;
  }
}

class SearchPage<T> extends StatefulWidget {
  final String title;
  final bool smaller;
  final SCSearchTypes type;

  const SearchPage({
    this.delegate,
    this.animation,
    this.title,
    this.smaller,
    this.type,
  });

  final SCAbstractSearchDelegate<T> delegate;
  final Animation<double> animation;

  @override
  State<StatefulWidget> createState() => SearchPageState<T>(
        title: title,
        smaller: smaller,
      );
}

class SearchPageState<T> extends State<SearchPage<T>> {
  final String title;
  final bool smaller;
  bool showSegments = false;

  ScrollController segmentsScrollController = ScrollController();

  SearchPageState({
    this.title,
    this.smaller,
  });

  FocusNode focusNode = FocusNode();
  SCSearchTypes type;

  @override
  void initState() {
    super.initState();
    widget.delegate.queryTextController.addListener(onQueryChanged);
    widget.animation.addStatusListener(onAnimationStatusChanged);
    widget.delegate.currentBodyNotifier.addListener(onSearchBodyChanged);
    focusNode.addListener(onFocusChanged);
    widget.delegate.focusNode = focusNode;
    type = widget.type;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Timer.run(() {
      if (SCSearchTypes.values.indexOf(widget.type) >
          SCSearchTypes.values.length / 2)
        segmentsScrollController.animateTo(
          segmentsScrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        );
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.delegate.queryTextController.removeListener(onQueryChanged);
    widget.animation.removeStatusListener(onAnimationStatusChanged);
    widget.delegate.currentBodyNotifier.removeListener(onSearchBodyChanged);
    widget.delegate.focusNode = null;
    focusNode.dispose();
  }

  void onAnimationStatusChanged(AnimationStatus status) {
    if (status != AnimationStatus.completed) {
      return;
    }
    widget.animation.removeStatusListener(onAnimationStatusChanged);
    if (widget.delegate.currentBody == SearchBody.suggestions) {
      focusNode.requestFocus();
    }
  }

  @override
  void didUpdateWidget(SearchPage<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.delegate != oldWidget.delegate) {
      oldWidget.delegate.queryTextController.removeListener(onQueryChanged);
      widget.delegate.queryTextController.addListener(onQueryChanged);
      oldWidget.delegate.currentBodyNotifier
          .removeListener(onSearchBodyChanged);
      widget.delegate.currentBodyNotifier.addListener(onSearchBodyChanged);
      oldWidget.delegate.focusNode = null;
      widget.delegate.focusNode = focusNode;
    }
  }

  void onFocusChanged() {
    if (focusNode.hasFocus &&
        widget.delegate.currentBody != SearchBody.suggestions) {
      showSegments = false;
      widget.delegate.showSuggestions(context);
    }
  }

  void onQueryChanged() {
    setState(() {});
  }

  void onSearchBodyChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    final ThemeData theme = widget.delegate.appBarTheme(context);
    final String searchFieldLabel = widget.delegate.searchFieldLabel ??
        MaterialLocalizations.of(context).searchFieldLabel;
    Widget body;
    switch (widget.delegate.currentBody) {
      case SearchBody.suggestions:
        body = KeyedSubtree(
          key: const ValueKey<SearchBody>(SearchBody.suggestions),
          child: widget.delegate.buildSuggestions(context, type),
        );
        break;
      case SearchBody.results:
        body = KeyedSubtree(
          key: const ValueKey<SearchBody>(SearchBody.results),
          child: widget.delegate.buildResults(context, type),
        );
        break;
    }
    String routeName;
    switch (theme.platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        routeName = '';
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        routeName = searchFieldLabel;
    }

    return Semantics(
      explicitChildNodes: true,
      scopesRoute: true,
      namesRoute: true,
      label: routeName,
      child: CustomScrollView(
        slivers: [
          SCAppBar(
            pinned: false,
            title: title ?? context.translate('search'),
            bottom: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width,
                  showSegments ? 61 + 60.0 : 60),
              child: Column(
                children: [
                  SCSearchBar(
                    controller: widget.delegate.queryTextController,
                    focusNode: focusNode,
                    textInputAction: widget.delegate.textInputAction,
                    keyboardType: widget.delegate.keyboardType,
                    onSubmitted: (String _) {
                      showSegments = true;
                      widget.delegate.showResults(context);
                    },
                    smaller: true,
                    sliver: false,
                    type: type,
                  ),
                  if (showSegments)
                    Container(
                      color: Theme.of(context).colorScheme.primary,
                      child: SingleChildScrollView(
                        controller: segmentsScrollController,
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
                            pageIndex: SCSearchTypes.values.indexOf(type),
                            scrollable: true,
                            padding: EdgeInsets.all(4),
                            setPage: (selected) {
                              type = SCSearchTypes.values[selected];
                              setState(() {});
                            },
                            titles: [
                              for (final searchType in SCSearchTypes.values)
                                searchType.toString().split('.').last,
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: body,
            ),
          ),
        ],
      ),
    );
  }
}
