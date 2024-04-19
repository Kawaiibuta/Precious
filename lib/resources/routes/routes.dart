import 'package:flutter/material.dart';
import 'package:precious/presenters/setting_presenter.dart';
import 'package:precious/views/admin/home_page_admin.dart';
import 'package:precious/views/home_page.dart';
import 'package:precious/views/item_detail_page.dart';
import 'package:precious/views/landing_page.dart';
import 'package:precious/views/login_or_sign_up_page.dart';
import 'package:precious/views/login_page.dart';
import 'package:precious/views/setting_page.dart';
import 'package:precious/views/sign_up_page.dart';
import 'package:precious/views/sign_up_success_page.dart';
import 'package:precious/views/start_page.dart';

class MyRoutes {
  final SettingPresenter _settingPresenter;

  const MyRoutes(this._settingPresenter);

  Map<String, Widget Function(BuildContext)> get routes => {
        StartPage.name: (_) => const StartPage(),
        SettingPage.name: (_) => SettingPage(_settingPresenter),
        LoginPage.name: (_) => const LoginPage(),
        SignUpPage.name: (_) => const SignUpPage(),
        LoginOrSignUpPage.name: (_) => const LoginOrSignUpPage(),
        SignUpSuccessPage.name: (_) => const SignUpSuccessPage(),
        LandingPage.name: (_) => const LandingPage(),
        HomePage.name: (_) => const HomePage(),
        HomePageAdmin.name: (_) => const HomePageAdmin(),
        ItemDetailPage.name: (_) => const ItemDetailPage(id: "1")
      };
}
