import 'package:flutter/material.dart';
import 'package:precious/presenters/setting_presenter.dart';
import 'package:precious/resources/app_export.dart';
import 'package:precious/resources/widgets/round_container_box.dart';
import 'package:precious/resources/widgets/setting_button.dart';

class SettingPage extends StatefulWidget {
  static const name = '/settings';

  final SettingPresenter _presenter;

  const SettingPage(this._presenter, {super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage>
    implements SettingPageContract {
  @override
  void initState() {
    super.initState();
    widget._presenter.settingPageContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          foregroundColor: Theme.of(context).colorScheme.primary,
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        body: Container(
          padding: EdgeInsets.all(8.h),
          child: Column(
            children: [
              RoundContainerBox(
                  border: Border.all(
                      color: Theme.of(context).colorScheme.primaryContainer),
                  padding: EdgeInsets.symmetric(vertical: 16.v),
                  child: Column(children: [
                    SettingButton(
                        AppLocalizations.of(context)!.language_button_title,
                        Icons.language,
                        onTap: _onChangeLanguage),
                    SettingButton(
                        AppLocalizations.of(context)!.notification_button_title,
                        Icons.notifications,
                        onTap: _onChangeNotificationState),
                    SettingButton(
                        AppLocalizations.of(context)!.dark_mode_button_title,
                        Icons.dark_mode,
                        customWidgetButton: Switch(
                            activeTrackColor:
                                Theme.of(context).colorScheme.primary,
                            inactiveTrackColor:
                                Theme.of(context).colorScheme.primaryContainer,
                            value:
                                widget._presenter.themeMode == ThemeMode.dark,
                            onChanged: (_) => _onChangeThemeMode()),
                        onTap: _onChangeThemeMode),
                    SettingButton(
                        AppLocalizations.of(context)!.help_center_button_title,
                        Icons.help,
                        onTap: _openHelpCenter),
                  ])),
            ],
          ),
        ),
      ),
    );
  }

  void _onChangeLanguage() {}

  void _onChangeNotificationState() {}

  void _onChangeThemeMode() {
    if (widget._presenter.themeMode == ThemeMode.light) {
      widget._presenter.updateThemeMode(ThemeMode.dark);
    } else {
      widget._presenter.updateThemeMode(ThemeMode.light);
    }
  }

  void _openHelpCenter() {}

  @override
  void onChangeLocalSettingError(Exception e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            AppLocalizations.of(context)!.unexpected_error_msg('UNKNOWN'),
            style: Theme.of(context).textTheme.labelLarge)));
  }
}
