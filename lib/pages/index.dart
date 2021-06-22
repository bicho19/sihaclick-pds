import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sihaclik/elements/basics/sc-cupertino-tab-bar.dart';
import 'package:sihaclik/elements/basics/sc-drawer.dart';
import 'package:sihaclik/pages/discover/discover.dart';
import 'package:sihaclik/pages/medicine/medicine.dart';
import 'package:sihaclik/pages/exchange/exchange.dart';
import 'package:sihaclik/pages/professional/professional.dart';
import 'package:sihaclik/pages/writings/writings.dart';

class IndexPage extends StatefulWidget {
  final CameraDescription camera;
  IndexPage({this.camera});
  final GlobalKey _scafoldPageKey = GlobalKey();
  final GlobalKey _discoverPageKey = GlobalKey();
  final GlobalKey _professionalPageKey = GlobalKey();
  final GlobalKey _medicinePageKey = GlobalKey();
  final GlobalKey _exchangePageKey = GlobalKey();
  final GlobalKey _writingPageKey = GlobalKey();
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int currentIndex = 0;

  GlobalKey get currentKey {
    switch (currentIndex) {
      case 0:
        return widget._discoverPageKey;
        break;
      case 1:
        return widget._professionalPageKey;
        break;
      case 2:
        return widget._medicinePageKey;
        break;
      case 3:
        return widget._exchangePageKey;
        break;
      case 4:
        return widget._writingPageKey;
        break;
      default:
        return widget._discoverPageKey;
        break;
    }
  }

  bool get canPop {
    bool _can = false;
    try {
      _can = Navigator.of(currentKey.currentContext).canPop();
    } catch (_) {
      debugPrint('error $_');
    }
    debugPrint('can $_can');
    return _can;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      key: widget._scafoldPageKey,
      drawer: SCDrawer(navigate: navigate),
      drawerEnableOpenDragGesture: false,
      body: WillPopScope(
        onWillPop: () async {
          bool canPop = Navigator.of(currentKey.currentContext).canPop();
          if (canPop) {
            Navigator.of(currentKey.currentContext).pop();
            return false;
          } else
            return true;
        },
        child: CupertinoTabScaffold(
          resizeToAvoidBottomInset: false,
          tabBar: SCCupertinoTabBar(
            tabs: 5,
            onTap: (index) {
              if (currentIndex == index) {
                Navigator.of(currentKey.currentContext)
                    .popUntil((route) => route.isFirst);
              }
              currentIndex = index;
              setState(() {});
            },
          ),
          tabBuilder: (context, index) {
            switch (index) {
              case 0:
                return CupertinoTabView(
                  builder: (context) {
                    return Navigator(
                      onGenerateRoute: (route) => MaterialPageRoute(
                        settings: route,
                        builder: (context) => DiscoverPage(
                            key: widget._discoverPageKey,
                            camera: widget.camera),
                      ),
                    );
                  },
                );
              case 1:
                return CupertinoTabView(
                  builder: (context) {
                    return Navigator(
                      onGenerateRoute: (route) => MaterialPageRoute(
                        settings: route,
                        builder: (context) =>
                            ProfessionalPage(key: widget._professionalPageKey),
                      ),
                    );
                  },
                );
              case 2:
                return CupertinoTabView(
                  builder: (context) {
                    return Navigator(
                      onGenerateRoute: (route) => MaterialPageRoute(
                        settings: route,
                        builder: (context) => MedicinePage(
                            key: widget._medicinePageKey,
                            camera: widget.camera),
                      ),
                    );
                  },
                );
              case 3:
                return CupertinoTabView(
                  builder: (context) {
                    return Navigator(
                      onGenerateRoute: (route) => MaterialPageRoute(
                        settings: route,
                        builder: (context) =>
                            ExchangePage(key: widget._exchangePageKey),
                      ),
                    );
                  },
                );
              case 4:
                return CupertinoTabView(
                  builder: (context) {
                    return Navigator(
                      onGenerateRoute: (route) => MaterialPageRoute(
                        settings: route,
                        builder: (context) =>
                            WritingsPage(key: widget._writingPageKey),
                      ),
                    );
                  },
                );
              default:
                return CupertinoTabView(
                  builder: (context) {
                    return Navigator(
                      onGenerateRoute: (route) => MaterialPageRoute(
                        settings: route,
                        builder: (context) => DiscoverPage(),
                      ),
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }

  void navigate(page) async {
    Navigator.of(currentKey.currentContext).push(
      MaterialPageRoute(builder: (_) => page),
    );
  }
}
