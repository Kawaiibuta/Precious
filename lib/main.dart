import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:precious/presenters/setting_presenter.dart';
import 'package:precious/resources/utils/firebase_options.dart';
import 'package:precious/views/start_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  bool isFirstRun = await SettingPresenter().isFirstRun();
  runApp(MyApp(isFirstRun));
}

class MyApp extends StatelessWidget {
  final bool _isFirstRun;

  const MyApp(this._isFirstRun, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
      ],
      home: _isFirstRun ? StartPage() : StartPage(),
    );
  }
}
