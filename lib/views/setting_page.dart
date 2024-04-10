import 'package:flutter/material.dart';
import 'package:precious/presenters/setting_presenter.dart';

class SettingPage extends StatefulWidget {
  
  static const name = '/settings';

  final SettingPresenter _presenter;

  const SettingPage(this._presenter, {super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
