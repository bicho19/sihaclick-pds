import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sihaclik/store/abstracts/widget-view.dart';
import 'package:sihaclik/store/notifiers/exchanges.dart';
import 'package:sihaclik/store/notifiers/localization.dart';
import 'package:sihaclik/store/notifiers/locations.dart';
import 'package:sihaclik/store/notifiers/notifications.dart';
import 'package:sihaclik/store/notifiers/pds_notifier.dart';
import 'package:sihaclik/store/notifiers/professionals.dart';
import 'package:sihaclik/store/notifiers/reminders.dart';
import 'package:sihaclik/store/notifiers/writings.dart';
import 'package:sihaclik/store/services/auth_provider.dart';

class StoreProvider extends StatefulWidget {
  StoreProvider({this.child});
  final Widget child;
  @override
  _StoreProviderController createState() => _StoreProviderController();
}

class _StoreProviderController extends State<StoreProvider> {
  LocalizationNotifier _localizationNotifier = LocalizationNotifier();
  RemindersNotifier _remindersNotifier = RemindersNotifier();
  LocationsNotifier _locationsNotifier = LocationsNotifier();
  ExchangesNotifier _exchangesNotifier = ExchangesNotifier();
  ProfessionalsNotifier _professionalsNotifier = ProfessionalsNotifier();
  WritingsNotifier _writingsNotifier = WritingsNotifier();
  NotificationsNotifier _notificationsNotifier = NotificationsNotifier();
  AuthStateProvider _authStateProvider = AuthStateProvider();
  PDSNotifier _pdsNotifier = PDSNotifier();

  @override
  Widget build(BuildContext context) => _StoreProviderView(this);

  @override
  void initState() {
    super.initState();
    () async {
      await _authStateProvider.initState();
      await _localizationNotifier.init();
      await _remindersNotifier.init();
      await _locationsNotifier.init();
      await _exchangesNotifier.init();
      await _professionalsNotifier.init();
      await _writingsNotifier.init();
      await _notificationsNotifier.init();
    }();
  }
}

class _StoreProviderView
    extends WidgetView<StoreProvider, _StoreProviderController> {
  _StoreProviderView(_StoreProviderController state) : super(state);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => state._authStateProvider),
        ChangeNotifierProvider(create: (_) => state._localizationNotifier),
        ChangeNotifierProvider(create: (_) => state._remindersNotifier),
        ChangeNotifierProvider(create: (_) => state._locationsNotifier),
        ChangeNotifierProvider(create: (_) => state._exchangesNotifier),
        ChangeNotifierProvider(create: (_) => state._professionalsNotifier),
        ChangeNotifierProvider(create: (_) => state._writingsNotifier),
        ChangeNotifierProvider(create: (_) => state._notificationsNotifier),
        ChangeNotifierProvider(create: (_) => state._pdsNotifier),

      ],
      child: state.widget.child,
    );
  }
}
