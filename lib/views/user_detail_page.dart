import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:precious/models/user/user.dart';
import 'package:precious/presenters/user_detail_presenter.dart';
import 'package:precious/resources/app_export.dart';
import 'package:precious/resources/endpoints.dart';
import 'package:precious/resources/widgets/custom_elevated_button.dart';

class UserDetailPage extends StatefulWidget {
  static String name = '/details';

  const UserDetailPage({super.key});

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage>
    implements UserDetailPageContract {
  late User _currentUser;

  late UserDetailPresenter _presenter;

  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _emailController = TextEditingController();

  late int _currentGender;

  final _nameFocusNode = FocusNode();

  final _ageFocusNode = FocusNode();

  final _genderFocusNode = FocusNode();

  bool loading = true;

  @override
  void initState() {
    super.initState();
    _presenter = UserDetailPresenter(this);
    _presenter.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: loading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.black))
                : Container(
                    padding: EdgeInsets.all(16.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 20.v),
                        Container(
                          foregroundDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.h),
                          ),
                          child: _currentUser.avatarUrl != null &&
                                  _currentUser.avatarUrl!.endsWith('.svg')
                              ? SvgPicture.network(_currentUser.avatarUrl!,
                                  width: 60.h, height: 60.v, fit: BoxFit.cover)
                              : Image.network(
                                  _currentUser.avatarUrl ??
                                      "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg",
                                  width: 60.h,
                                  height: 60.v,
                                  fit: BoxFit.cover),
                        ),
                        SizedBox(height: 60.v),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(AppLocalizations.of(context)!
                                  .name_text_field_title),
                              SizedBox(
                                width: 220.h,
                                height: 18.v,
                                child: TextFormField(
                                  controller: _nameController,
                                  focusNode: _nameFocusNode,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                  keyboardType: TextInputType.name,
                                ),
                              )
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(AppLocalizations.of(context)!
                                  .gender_checkbox_title),
                              SizedBox(
                                width: 240.h,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    // Male radio button
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 8.h, top: 8.v, bottom: 8.v),
                                      padding: EdgeInsets.only(right: 12.h),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: _currentGender == 0
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .primary
                                                  : Theme.of(context)
                                                      .colorScheme
                                                      .primaryContainer),
                                          borderRadius:
                                              BorderRadius.circular(16.h),
                                          color: _currentGender == 0
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .secondary),
                                      child: Row(
                                        children: [
                                          Radio(
                                              groupValue: _currentGender,
                                              value: 0,
                                              activeColor: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              focusNode: _genderFocusNode,
                                              onChanged: _onChangeGender),
                                          Text(
                                            AppLocalizations.of(context)!
                                                .male_checkbox_title,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium!
                                                .copyWith(
                                                    color: _currentGender == 0
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .onPrimary
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .primaryContainer),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 16.h),
                                    // Female radio button
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 8.h, top: 8.v, bottom: 8.v),
                                      padding: EdgeInsets.only(right: 12.h),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: _currentGender == 1
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .primary
                                                  : Theme.of(context)
                                                      .colorScheme
                                                      .primaryContainer),
                                          borderRadius:
                                              BorderRadius.circular(16.h),
                                          color: _currentGender == 1
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .secondary),
                                      child: Row(
                                        children: [
                                          Radio(
                                              groupValue: _currentGender,
                                              value: 1,
                                              activeColor: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              focusNode: _genderFocusNode,
                                              onChanged: _onChangeGender),
                                          Text(
                                              AppLocalizations.of(context)!
                                                  .female_checkbox_title,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium!
                                                  .copyWith(
                                                      color: _currentGender == 1
                                                          ? Theme.of(context)
                                                              .colorScheme
                                                              .onPrimary
                                                          : Theme.of(context)
                                                              .colorScheme
                                                              .primaryContainer)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(AppLocalizations.of(context)!
                                  .age_text_field_title),
                              SizedBox(
                                width: 220.h,
                                height: 18.v,
                                child: TextFormField(
                                  controller: _ageController,
                                  focusNode: _ageFocusNode,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimaryContainer),
                                  keyboardType: TextInputType.number,
                                ),
                              )
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(AppLocalizations.of(context)!
                                  .email_text_field_title),
                              SizedBox(
                                width: 220.h,
                                child: TextFormField(
                                  controller: _emailController,
                                  enabled: false,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimaryContainer),
                                ),
                              )
                            ]),
                        SizedBox(height: 150.v),
                        CustomElevatedButton(
                            buttonStyle: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary),
                            buttonTextStyle: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                            text:
                                AppLocalizations.of(context)!.save_button_title,
                            onPressed: _save)
                      ],
                    ))));
  }

  void _onChangeGender(int? value) {
    setState(() {
      _currentGender = value!;
    });
  }

  void _save() {
    _presenter.updateUser(_currentUser.copyWith(
        name: _nameController.text,
        age: int.tryParse(_ageController.text),
        gender: _currentGender));
  }

  @override
  void onGetUserDetailSuccess(User user) {
    setState(() {
      loading = false;
      _currentUser = user;
      _nameController.text = user.name ?? '';
      _currentGender = (user.gender ?? 2).toInt();
      _ageController.text = (user.age ?? 0).toString();
      _emailController.text = user.email ?? '';
    });
  }

  @override
  void onUpdateUserDetailSuccess(User user) {
    Navigator.pop(context, user);
  }

  @override
  void onUpdateUserFailed(Exception e) {
    if (e is FirebaseAuthException) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              AppLocalizations.of(context)!.unexpected_error_msg(e.code))));
    } else {
      debugPrint(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              AppLocalizations.of(context)!.unexpected_error_msg('UNKNOWN'))));
    }
  }

  @override
  void onGetUserDetailFailed(Exception e) {
    // TODO: implement onGetUserDetailFailed
  }
}
