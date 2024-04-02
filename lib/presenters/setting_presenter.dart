import 'package:precious/data_sources/setting_repository.dart';

class SettingPresenter {
  final _repos = SettingRepository();

  Future<bool> isFirstRun() => _repos.isFirstRun();
}
