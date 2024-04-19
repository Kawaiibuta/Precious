import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/material/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingRepository {
  Future<bool> isFirstRun() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('firstRun') ?? true;
  }

  void removeFirstRun() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('firstRun', false);
  }

  Future<bool> hasLogin() async {
    return FirebaseAuth.instance.currentUser != null;
  }

  Future<void> updateThemeMode(ThemeMode newThemeMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('themeMode', newThemeMode.toString());
  }

  Future<void> updateLocale(Locale newLocale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('locale', newLocale.languageCode);
  }

  Future<ThemeMode> getThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String theme = prefs.getString('themeMode') ?? 'ThemeMode.light';
    return ThemeMode.values.firstWhere((t) => t.toString() == theme);
  }

  Future<Locale> getLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageCode = prefs.getString('locale') ?? 'en';
    return Locale(languageCode);
  }
}
