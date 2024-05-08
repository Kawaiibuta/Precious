import 'package:flutter/material.dart';
import 'package:precious/presenters/profile_presenter.dart';
import 'package:precious/resources/app_export.dart';
import 'package:precious/resources/widgets/custom_elevated_button.dart';
import 'package:precious/resources/widgets/round_container_box.dart';
import 'package:precious/resources/widgets/setting_button.dart';
import 'package:precious/views/login_page.dart';
import 'package:precious/views/setting_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    implements ProfilePageContract {
  late ProfilePresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = ProfilePresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.h),
            child: Column(
              children: [
                SizedBox(height: 30.v),
                RoundContainerBox(
                    padding: EdgeInsets.all(8.h),
                    hasShadow: true,
                    shadowWidth: 3.h,
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        Image.asset('assets/images/default_profile.png',
                            width: 64.h, height: 64.v, fit: BoxFit.cover),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Nguyen Van An",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(fontWeight: FontWeight.w800)),
                            Text(
                              "nguyenvanan2001@gmail.com",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        )
                      ],
                    )),
                SizedBox(height: 30.v),
                RoundContainerBox(
                    border: Border.all(
                        color: Theme.of(context).colorScheme.outlineVariant),
                    padding: EdgeInsets.symmetric(vertical: 16.v),
                    child: Column(children: [
                      SettingButton(
                          AppLocalizations.of(context)!.my_order_button_title,
                          Icons.shopping_bag,
                          onTap: _openMyOrderPage),
                      SettingButton(
                          AppLocalizations.of(context)!
                              .my_favourites_button_title,
                          Icons.favorite,
                          onTap: _openMyFavouritePage),
                      SettingButton(
                          AppLocalizations.of(context)!
                              .shipping_address_button_title,
                          Icons.local_shipping,
                          onTap: _openShippingAddressPage),
                      SettingButton(
                          AppLocalizations.of(context)!.my_card_button_title,
                          Icons.credit_card,
                          onTap: _openMyCardPage),
                      SettingButton(
                          AppLocalizations.of(context)!.settings_button_title,
                          Icons.settings,
                          onTap: _openSettingPage)
                    ])),
                SizedBox(height: 30.v),
                RoundContainerBox(
                    border: Border.all(
                        color: Theme.of(context).colorScheme.outlineVariant),
                    padding: EdgeInsets.symmetric(vertical: 16.v),
                    child: Column(children: [
                      SettingButton(
                          AppLocalizations.of(context)!.faq_button_title,
                          Icons.info,
                          onTap: _openFAQPage),
                      SettingButton(
                          AppLocalizations.of(context)!
                              .privacy_policy_button_title,
                          Icons.verified_user,
                          onTap: _openPrivacyPolicyPage)
                    ])),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.v),
                  child: CustomElevatedButton(
                      buttonStyle: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary),
                      buttonTextStyle: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(
                              color: Theme.of(context).colorScheme.onPrimary),
                      text: AppLocalizations.of(context)!.log_out,
                      leftIcon: Icon(Icons.logout,
                          color: Theme.of(context).colorScheme.onPrimary),
                      onPressed: _logOut),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openMyOrderPage() {}

  void _openMyFavouritePage() {}

  void _openShippingAddressPage() {}

  void _openMyCardPage() {}

  void _openSettingPage() {
    Navigator.of(context).pushNamed(SettingPage.name);
  }

  void _openFAQPage() {}

  void _openPrivacyPolicyPage() {}

  void _logOut() {
    _presenter.signOut();
  }

  @override
  void onSignOutComplete() {
    Navigator.of(context).pushReplacementNamed(LoginPage.name);
  }

  @override
  void onSignOutFailed(Exception e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            AppLocalizations.of(context)!.unexpected_error_msg(e.toString()))));
  }
}
