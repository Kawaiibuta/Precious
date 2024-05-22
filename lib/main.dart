import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:precious/data_sources/auth_repository.dart';
import 'package:precious/presenters/setting_presenter.dart';
import 'package:precious/resources/routes/routes.dart';
import 'package:precious/resources/utils/firebase_options.dart';
import 'package:flutter/services.dart';
import 'package:precious/views/admin/home_page_admin.dart';
import 'package:precious/views/home_page.dart';
import 'package:precious/views/login_or_sign_up_page.dart';
import 'package:precious/views/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  var settings = SettingPresenter();
  await settings.getFirstRunStatus();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(MyApp(settings));
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

class AuthenticationWrapper extends StatefulWidget {
  @override
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
          if (snapshot.hasData) {
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

class MyApp extends StatelessWidget {
  final SettingPresenter _settingPresenter;
  const MyApp(this._settingPresenter, {super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      theme: ThemeData(
          brightness: Brightness.light,
          inputDecorationTheme: const InputDecorationTheme(
              labelStyle: TextStyle(color: Colors.black),
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(style: BorderStyle.solid, color: Colors.black),
              ))),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
      ],
      home: AuthenticationWrapper(),
      routes: MyRoutes(_settingPresenter).routes,
    );
  }
}
