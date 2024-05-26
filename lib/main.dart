import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_links/app_links.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:precious/data_sources/auth_repository.dart';
import 'package:precious/presenters/setting_presenter.dart';
import 'package:precious/resources/app_export.dart';
import 'package:precious/resources/routes/routes.dart';
import 'package:precious/resources/utils/firebase_options.dart';
import 'package:flutter/services.dart';
import 'package:precious/resources/widgets/create_order_page.dart';
import 'package:precious/views/home_page.dart';
import 'package:precious/views/admin/home_page_admin.dart';
import 'package:precious/views/login_or_sign_up_page.dart';
import 'package:precious/views/splashScreen.dart';
import 'package:precious/views/start_page.dart';

final _appLinks = AppLinks();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var settings = SettingPresenter();
  await settings.initialize();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(MyApp(settings));
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

class AuthenticationWrapper extends StatefulWidget {
  final SettingPresenter _presenter;

  const AuthenticationWrapper(this._presenter, {super.key});

  @override
  _AuthenticationWrapperState createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }
          if (widget._presenter.firstRun) {
            return const StartPage();
          }
          if (snapshot.hasData) {
            debugPrint(snapshot.data.toString());
            return FutureBuilder(
              future: AuthRepository.updateCurrentUser(),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show a loading indicator if necessary
                  return const SplashScreen();
                } else {
                  debugPrint(AuthRepository.currentUser.toString());
                  if (AuthRepository.currentUser == null) {
                    return const LoginOrSignUpPage();
                  }
                  if (AuthRepository.currentUser!.userRole == "ADMIN") {
                    return const HomePageAdmin();
                  }
                  return const HomePage();
                }
              },
            );
          }
          return const LoginOrSignUpPage();
        });
  }
}

class MyApp extends StatefulWidget {
  final SettingPresenter _settingPresenter;
  const MyApp(this._settingPresenter, {super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> implements AppContract {
  late ThemeMode _themeMode;

  late Locale _locale;

  @override
  void initState() {
    super.initState();
    _appLinks.uriLinkStream.listen((uri) {
      Navigator.of(context).pushNamed(CreateOrderPage.name);
    });
    _themeMode = widget._settingPresenter.themeMode;
    _locale = widget._settingPresenter.locale;
    widget._settingPresenter.appContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      theme: AppTheme.themeLight,
      darkTheme: AppTheme.themeDark,
      themeMode: _themeMode,
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
      ],
      home: AuthenticationWrapper(widget._settingPresenter),
      routes: MyRoutes(widget._settingPresenter).routes,
    );
  }

  @override
  void onUpdateLocaleComplete(Locale newLocale) => setState(() {
        _locale = newLocale;
      });

  @override
  void onUpdateThemeComplete(ThemeMode newThemeMode) => setState(() {
        _themeMode = newThemeMode;
      });
}
