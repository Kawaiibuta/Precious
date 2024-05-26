import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:precious/models/user/user.dart';
import 'package:precious/presenters/profile_presenter.dart';
import 'package:precious/resources/app_export.dart';
import 'package:precious/resources/widgets/custom_elevated_button.dart';
import 'package:precious/resources/widgets/round_container_box.dart';
import 'package:precious/resources/widgets/setting_button.dart';
import 'package:precious/views/login_page.dart';
import 'package:precious/views/setting_page.dart';
import 'package:precious/views/user_detail_page.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    implements ProfilePageContract {
  late ProfilePresenter _presenter;
  late User _user;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _presenter = ProfilePresenter(this);
    _presenter.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: _loading
          ? Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary))
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16.h),
                child: Column(
                  children: [
                    SizedBox(height: 30.v),
                    GestureDetector(
                      onTap: () =>
                          Navigator.of(context).pushNamed(UserDetailPage.name),
                      child: RoundContainerBox(
                          padding: EdgeInsets.all(8.h),
                          hasShadow: true,
                          shadowWidth: 3.h,
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Container(
                                width: 44.h,
                                height: 44.v,
                                margin: EdgeInsets.symmetric(horizontal: 8.h),
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                                clipBehavior: Clip.antiAlias,
                                child: _user.avatarUrl != null &&
                                        _user.avatarUrl!.endsWith('.svg')
                                    ? SvgPicture.network(_user.avatarUrl!,
                                        width: 64.h,
                                        height: 64.v,
                                        fit: BoxFit.cover)
                                    : Image.network(
                                        _user.avatarUrl ??
                                            "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg",
                                        width: 64.h,
                                        height: 64.v,
                                        fit: BoxFit.cover),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(_user.name!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.w800)),
                                    Text(
                                      _user.email!,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                    ),
                    SizedBox(height: 30.v),
                    RoundContainerBox(
                        border: Border.all(
                            color:
                                Theme.of(context).colorScheme.outlineVariant),
                        padding: EdgeInsets.symmetric(vertical: 16.v),
                        child: Column(children: [
                          SettingButton(
                              AppLocalizations.of(context)!
                                  .my_order_button_title,
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
                              AppLocalizations.of(context)!
                                  .my_card_button_title,
                              Icons.credit_card,
                              onTap: _openMyCardPage),
                          SettingButton(
                              AppLocalizations.of(context)!
                                  .settings_button_title,
                              Icons.settings,
                              onTap: _openSettingPage)
                        ])),
                    SizedBox(height: 30.v),
                    RoundContainerBox(
                        border: Border.all(
                            color:
                                Theme.of(context).colorScheme.outlineVariant),
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
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                          text: AppLocalizations.of(context)!.log_out,
                          leftIcon: Icon(Icons.logout,
                              color: Theme.of(context).colorScheme.onPrimary),
                          onPressed: _logOut),
                    )
                  ],
                ),
              ),
            ),
    ));
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

  @override
  void onGetUserDetailSuccess(User user) {
    setState(() {
      _loading = false;
      _user = user;
    });
  }

  @override
  void onGetUserFailed(Exception e) {
    // TODO: implement onGetUserFailed
  }
}
