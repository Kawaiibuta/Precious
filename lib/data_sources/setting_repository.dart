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
}
