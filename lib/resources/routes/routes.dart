import 'package:flutter/material.dart';
import 'package:precious/presenters/setting_presenter.dart';
import 'package:precious/views/admin/home_page_admin.dart';
import 'package:precious/views/admin/inventory_form.dart';
import 'package:precious/views/admin/order_form.dart';
import 'package:precious/views/home_page.dart';
import 'package:precious/views/landing_page.dart';
import 'package:precious/views/login_or_sign_up_page.dart';
import 'package:precious/views/login_page.dart';
import 'package:precious/views/order_list_page.dart';
import 'package:precious/views/order_success_page.dart';
import 'package:precious/views/search_page.dart';
import 'package:precious/views/setting_page.dart';
import 'package:precious/views/sign_up_page.dart';
import 'package:precious/views/sign_up_success_page.dart';
import 'package:precious/views/start_page.dart';
import 'package:precious/views/user_detail_page.dart';

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
        SearchPage.name: (_) => const SearchPage(),
        LandingPage.name: (_) => const LandingPage(),
        HomePage.name: (_) => const HomePage(),
        HomePageAdmin.name: (_) => const HomePageAdmin(),
        UserDetailPage.name: (_) => const UserDetailPage(),
        InventoryForm.name: (_) => const InventoryForm(),
        OrderForm.name: (_) => const OrderForm(),
        UserDetailPage.name: (_) => const UserDetailPage(),
        OrderSuccessPage.name: (_) => const OrderSuccessPage(),
        OrderListPage.name: (_) => OrderListPage()
      };
}
