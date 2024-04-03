import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:precious/presenters/sign_up_presenter.dart';
import 'package:precious/resources/app_export.dart';
import 'package:precious/resources/widgets/custom_elevated_button.dart';
import 'package:precious/views/sign_up_success_page.dart';

class SignUpPage extends StatefulWidget {
  static const name = '/signUp';

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> implements SignUpPageContract {
  final _emailRegex = RegExp(r'[a-zA-Z0-9]+@[a-zA-Z]*\.[a-zA-Z.]*');

  final _usernameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

  final _usernameFocusNode = FocusNode();

  final _emailFocusNode = FocusNode();

  final _passwordFocusNode = FocusNode();

  final _confirmPasswordFocusNode = FocusNode();

  final GlobalKey<FormFieldState<String>> _usernameFieldKey = GlobalKey();

  final GlobalKey<FormFieldState<String>> _emailFieldKey = GlobalKey();

  final GlobalKey<FormFieldState<String>> _passwordFieldKey = GlobalKey();

  final GlobalKey<FormFieldState<String>> _confirmPasswordFieldKey =
      GlobalKey();

  FormFieldState<String>? lastFormFieldState;

  bool _obscuredText = true;

  bool _usernameError = false;

  bool _emailError = false;

  bool _passwordError = false;

  bool _confirmPasswordError = false;

  bool _hasAgree = false;

  late SignUpPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = SignUpPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Form(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                padding: EdgeInsets.all(16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 625.v,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20.v),
                            Center(
                                child: Image.asset(
                              'assets/images/uit_jewels_black.png',
                              width: 160.h,
                              height: 160.v,
                              fit: BoxFit.contain,
                            )),
                            SizedBox(height: 20.v),
                            Text(
                              AppLocalizations.of(context)!.sign_up_title,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            SizedBox(height: 5.v),
                            Text(
                              AppLocalizations.of(context)!.sign_up_body,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            SizedBox(height: 48.v),
                            // Username **************************************************//
                            Text(
                              AppLocalizations.of(context)!.username_title,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            TextFormField(
                              key: _usernameFieldKey,
                              controller: _usernameController,
                              focusNode: _usernameFocusNode,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Colors.transparent,
                                suffixIcon: Icon(_usernameError
                                    ? Icons.cancel_rounded
                                    : Icons.check_circle_rounded),
                                suffixIconColor: Colors.black,
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colors.black),
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.name,
                              onTap: _onTapUsername,
                              // onChanged: (_) =>
                              //     setState(() => _usernameError = false),
                              validator: _usernameValidator,
                            ),
                            SizedBox(height: 16.v),
                            // Email *****************************************************//
                            Text(
                              AppLocalizations.of(context)!.email_title,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            TextFormField(
                              key: _emailFieldKey,
                              controller: _emailController,
                              focusNode: _emailFocusNode,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Colors.transparent,
                                suffixIcon: Icon(_emailError
                                    ? Icons.cancel_rounded
                                    : Icons.check_circle_rounded),
                                suffixIconColor: Colors.black,
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colors.black),
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.emailAddress,
                              onTap: _onTapEmail,
                              // onChanged: (_) =>
                              //     setState(() => _emailError = false),
                              validator: _emailValidator,
                            ),
                            SizedBox(height: 16.v),
                            // Password **************************************************//
                            Text(
                              AppLocalizations.of(context)!.password_title,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            TextFormField(
                              key: _passwordFieldKey,
                              controller: _passwordController,
                              focusNode: _passwordFocusNode,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                fillColor: Colors.transparent,
                                suffixIcon: IntrinsicWidth(
                                  child: Row(
                                    children: [
                                      InkWell(
                                          onTap: () => setState(() =>
                                              _obscuredText = !_obscuredText),
                                          child: Icon(_obscuredText
                                              ? Icons.visibility
                                              : Icons.visibility_off)),
                                      SizedBox(width: 4.h),
                                      Icon(_passwordError
                                          ? Icons.cancel_rounded
                                          : Icons.check_circle_rounded)
                                    ],
                                  ),
                                ),
                                suffixIconColor: Colors.black,
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colors.black),
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: _obscuredText,
                              onTap: _onTapPassword,
                              // onChanged: (_) =>
                              //     setState(() => _passwordError = false),
                              validator: _passwordValidator,
                            ),
                            SizedBox(height: 16.v),
                            // Confirm password
                            Text(
                              AppLocalizations.of(context)!
                                  .confirm_password_title,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            TextFormField(
                              key: _confirmPasswordFieldKey,
                              controller: _confirmPasswordController,
                              focusNode: _confirmPasswordFocusNode,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                errorMaxLines: 2,
                                fillColor: Colors.transparent,
                                suffixIcon: Icon(_confirmPasswordError
                                    ? Icons.check_circle_rounded
                                    : Icons.cancel),
                                suffixIconColor: Colors.black,
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colors.black),
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              onTap: _onTapConfirmPassword,
                              onChanged: (_) =>
                                  setState(() => _confirmPasswordError = false),
                              validator: _confirmPasswordValidator,
                            ),
                            SizedBox(height: 16.v)
                          ],
                        ),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(vertical: 16.v),
                        height: 80.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Checkbox(
                                value: _hasAgree,
                                onChanged: (agree) {
                                  setState(() {
                                    _hasAgree = agree ?? false;
                                  });
                                }),
                            SizedBox(
                              width: 283.h,
                              child: Text(
                                AppLocalizations.of(context)!
                                    .term_and_condition_agree_msg,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            )
                          ],
                        )),
                    CustomElevatedButton(
                        onPressed: _signUp,
                        buttonStyle: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            disabledBackgroundColor: Colors.grey.shade600),
                        isDisabled: !_hasAgree,
                        buttonTextStyle: Theme.of(context).textTheme.labelLarge,
                        text: AppLocalizations.of(context)!.sign_up),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapUsername() {
    _usernameFocusNode.requestFocus;
    lastFormFieldState?.validate();
    lastFormFieldState = _usernameFieldKey.currentState;
  }

  void _onTapEmail() {
    _emailFocusNode.requestFocus;
    lastFormFieldState?.validate();
    lastFormFieldState = _emailFieldKey.currentState;
  }

  void _onTapPassword() {
    _passwordFocusNode.requestFocus;
    lastFormFieldState?.validate();
    lastFormFieldState = _passwordFieldKey.currentState;
  }

  void _onTapConfirmPassword() {
    _confirmPasswordFocusNode.requestFocus();
    lastFormFieldState?.validate();
  }

  String? _usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      _usernameError = true;
      return AppLocalizations.of(context)!.username_empty_msg;
    }
    _usernameError = false;
    return null;
  }

  String? _emailValidator(String? value) {
    _emailError = true;
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.email_empty_msg;
    }
    if (!_emailRegex.hasMatch(value)) {
      return AppLocalizations.of(context)!.email_incorrect_format;
    }
    _emailError = false;
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.length < 6) {
      _passwordError = true;
      return AppLocalizations.of(context)!.password_length_msg;
    }
    _passwordError = false;
    return null;
  }

  String? _confirmPasswordValidator(String? value) {
    if (_confirmPasswordController.text != _passwordController.text) {
      _confirmPasswordError = true;
      return AppLocalizations.of(context)!.confirm_password_unmatched;
    }
    _confirmPasswordError = false;
    return null;
  }

  void _signUp() {
    if (_confirmPasswordFieldKey.currentState!.validate()) {
      _presenter.signUp(_usernameController.text, _emailController.text,
          _passwordController.text, _confirmPasswordController.text);
    } else {
      _confirmPasswordFocusNode.requestFocus();
    }
  }

  @override
  void onSignUpError(FirebaseException e) {
    switch (e.code) {
      case 'email-already-in-use':
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                AppLocalizations.of(context)!.email_already_in_use_err_msg)));
        break;
      case 'network-request-failed':
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppLocalizations.of(context)!.network_issue_msg)));
      default:
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  AppLocalizations.of(context)!.unexpected_error_msg(e.code))));
        });
        break;
    }
  }

  @override
  void onSignUpSuccess() {
    Navigator.of(context).pushReplacementNamed(SignUpSuccessPage.name);
  }
}
