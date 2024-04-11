import 'package:flutter/material.dart';
import 'package:precious/data_sources/setting_repository.dart';

abstract class SettingPageContract {
  void onUpdateLocaleComplete(Locale newLocale);
}

class SettingPresenter {
  final _repos = SettingRepository();

  late bool firstRun;

  Future<void> getFirstRunStatus() async => firstRun = await _repos.isFirstRun();

  Future<void> updateLocale(Locale newLocale) async {
    // TODO: update this
  }
}
