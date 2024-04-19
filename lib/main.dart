import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:precious/presenters/setting_presenter.dart';
import 'package:precious/resources/routes/routes.dart';
import 'package:precious/resources/themes/app_theme.dart';
import 'package:precious/resources/utils/firebase_options.dart';
import 'package:precious/views/admin/home_page_admin.dart';
import 'package:flutter/services.dart';
import 'package:precious/views/home_page.dart';
import 'package:precious/views/login_or_sign_up_page.dart';
import 'package:precious/views/start_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var settings = SettingPresenter();
  await settings.initialize();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  runApp(MyApp(settings));
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
    _themeMode = widget._settingPresenter.themeMode;
    _locale = widget._settingPresenter.locale;
    widget._settingPresenter.appContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      initialRoute: _getInitialPage(),
      routes: MyRoutes(widget._settingPresenter).routes,
    );
  }

  _getInitialPage() {
    if (widget._settingPresenter.firstRun) {
      return StartPage.name;
    }
    if (!widget._settingPresenter.hasLogin) {
      return LoginOrSignUpPage.name;
    }
    return HomePage.name;
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
