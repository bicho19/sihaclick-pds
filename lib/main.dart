import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sihaclik/helpers/sc-localization.dart';
import 'package:sihaclik/pages/index.dart';
import 'package:sihaclik/pages/onboarding/onboarding.dart';
import 'package:sihaclik/pages/onboarding/onboardingBloodPage.dart';
import 'package:sihaclik/pages/onboarding/signin.dart';
import 'package:sihaclik/pages/onboarding/signup.dart';
import 'package:sihaclik/store/notifiers/localization.dart';
import 'package:sihaclik/store/services/auth_provider.dart';
import 'package:sihaclik/store/store.dart';
import 'package:sihaclik/helpers/theme.dart' as ThemeProvider;
import 'package:sihaclik/utils/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/fonts/poppins/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final cameras = await availableCameras();
  final CameraDescription camera = cameras.length > 0 ? cameras.first : null;
  DatabaseHelper databaseHelper = DatabaseHelper.internal();
  runApp(SIHACLICK(camera: camera));
}

class SIHACLICK extends StatelessWidget {
  final CameraDescription camera;

  SIHACLICK({this.camera});

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      child: Builder(
        builder: (context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Sihaclick',
          theme: ThemeProvider.Theme().themeData,
          // home: SignupPage(),
          initialRoute: '/',
          locale: context.watch<LocalizationNotifier>().locale,
          routes: {
            '/': (context) => App(camera: camera),
            '/main': (context) => IndexPage(camera: camera),
            '/sign-in': (context) => SigninPage(),
            '/sign-up': (context) => SignupPage(),
            '/blood': (context) => OnboardingBloodPage(),
          },
          localizationsDelegates: [
            SCLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('fr', ''),
            const Locale('ar', ''),
          ],
          localeResolutionCallback: (
            Locale locale,
            Iterable<Locale> supportedLocales,
          ) {
            for (final supportedLocale in supportedLocales)
              if (supportedLocale.languageCode == locale.languageCode)
                return locale;
            return supportedLocales.first;
          },
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class App extends StatelessWidget {
  final CameraDescription camera;

  App({Key key, this.camera}) : super(key: key);
  AuthStateProvider _authState;

  @override
  Widget build(BuildContext context) {
    _authState = context.watch<AuthStateProvider>();
    return FutureBuilder<bool>(
      future: _authState.isUserLoggedIn(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: SplashScreen(),
          );
        } else if (snapshot.hasData && snapshot.data) {
          debugPrint("User logged in ");
          return IndexPage(
            camera: camera,
          );
        } else {
          debugPrint("User is not logged in");
          return OnboardingPage();
        }
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
