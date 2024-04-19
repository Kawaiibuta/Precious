import 'package:flutter/material.dart';
import 'package:precious/data_sources/setting_repository.dart';
import 'package:precious/views/setting_page.dart';

abstract class SettingPageContract {
  void onChangeLocalSettingError(Exception e);
}

abstract class AppContract {
  void onUpdateLocaleComplete(Locale newLocale);
  void onUpdateThemeComplete(ThemeMode newThemeMode);
}

class SettingPresenter {
  final _repos = SettingRepository();

  AppContract? appContract;

  SettingPageContract? settingPageContract;

  late bool firstRun;

  late bool hasLogin;

  late Locale locale;

  late ThemeMode themeMode;

  Future<void> initialize() async {
    await getFirstRunStatus();
    await getLoginInfo();
    await getLocale();
    await getThemeMode();
  }

  Future<void> getFirstRunStatus() async =>
      firstRun = await _repos.isFirstRun();

  Future<void> getLoginInfo() async => hasLogin = await _repos.hasLogin();

  Future<void> updateLocale(Locale newLocale) async {
    await _repos
        .updateLocale(newLocale)
        .then((_) => appContract?.onUpdateLocaleComplete(newLocale))
        .catchError((e) => settingPageContract?.onChangeLocalSettingError(e));
    locale = newLocale;
  }

  Future<void> updateThemeMode(ThemeMode newThemeMode) async {
    await _repos
        .updateThemeMode(newThemeMode)
        .then((_) => appContract?.onUpdateThemeComplete(newThemeMode))
        .catchError((e) => settingPageContract?.onChangeLocalSettingError(e));
    themeMode = newThemeMode;
  }

  Future<void> getThemeMode() async {
    await _repos.getThemeMode().then((value) => themeMode = value);
  }

  Future<void> getLocale() async {
    await _repos.getLocale().then((value) => locale = value);
  }
}
