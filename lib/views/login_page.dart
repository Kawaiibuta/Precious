import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:precious/models/user/user.dart';
import 'package:precious/presenters/login_presenter.dart';
import 'package:precious/resources/app_export.dart';
import 'package:precious/resources/widgets/custom_elevated_button.dart';
import 'package:precious/views/admin/home_page_admin.dart';
import 'package:precious/views/home_page.dart';

class LoginPage extends StatefulWidget {
  static const name = '/login';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginPageContract {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool _isObscured = true;

  final _emailFocusNode = FocusNode();

  final _passwordFocusNode = FocusNode();

  late LoginPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = LoginPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Form(
              child: Container(
                padding: EdgeInsets.all(16.h),
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
                      AppLocalizations.of(context)!.login_title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 5.v),
                    Text(
                      AppLocalizations.of(context)!.login_body,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(height: 48.v),
                    Text(
                      AppLocalizations.of(context)!.email_title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    TextFormField(
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      decoration: const InputDecoration(
                        fillColor: Colors.transparent,
                        suffixIcon: Icon(Icons.check_circle_rounded),
                        suffixIconColor: Colors.black,
                      ),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black),
                      keyboardType: TextInputType.emailAddress,
                      onTap: _emailFocusNode.requestFocus,
                    ),
                    SizedBox(height: 16.v),
                    Text(
                      AppLocalizations.of(context)!.password_title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      obscureText: _isObscured,
                      decoration: InputDecoration(
                        fillColor: Colors.transparent,
                        suffix: InkWell(
                          onTap: () =>
                              setState(() => _isObscured = !_isObscured),
                          child: Icon(
                              _isObscured
                                  ? Icons.visibility_rounded
                                  : Icons.visibility_off_rounded,
                              color: Colors.black),
                        ),
                        suffixIcon: const Icon(Icons.check_circle_rounded),
                        suffixIconColor: Colors.black,
                      ),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black),
                      keyboardType: TextInputType.visiblePassword,
                      onTap: _passwordFocusNode.requestFocus,
                    ),
                    SizedBox(height: 48.v),
                    CustomElevatedButton(
                        text: AppLocalizations.of(context)!.login,
                        buttonStyle: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        buttonTextStyle: Theme.of(context).textTheme.labelLarge,
                        onPressed: _loginWithPassword),
                    SizedBox(height: 8.v),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 120.h,
                            child: Divider(
                              thickness: 1.v,
                              color: Colors.grey.shade300,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: Text(AppLocalizations.of(context)!.or),
                          ),
                          SizedBox(
                            width: 120.h,
                            child: Divider(
                                thickness: 1.v, color: Colors.grey.shade300),
                          ),
                        ]),
                    SizedBox(height: 8.v),
                    CustomElevatedButton(
                      text: AppLocalizations.of(context)!
                          .login_with_google_button_title,
                      leftIcon: Image.asset('assets/images/google.png',
                          width: 32.h, height: 32.v, fit: BoxFit.cover),
                      buttonStyle: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      buttonTextStyle: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: Colors.black),
                      onPressed: _loginWithGoogle,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _loginWithPassword() {
    callLoadingScreen();
    _presenter.login(_emailController.text, _passwordController.text);
  }

  void _loginWithGoogle() {
    callLoadingScreen();
    _presenter.loginWithGoogle();
  }

  @override
  void onLoginFailed(auth.FirebaseException e) {
    Navigator.of(context).pop();
    debugPrint('${e.message}\n${e.stackTrace}');
    switch (e.code) {
      case 'wrong-password':
      case 'invalid-email':
      case 'user-not-found':
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppLocalizations.of(context)!
                .email_or_password_incorrect_msg)));
        break;
      case 'network-request-failed':
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppLocalizations.of(context)!.network_issue_msg)));
      default:
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                AppLocalizations.of(context)!.unexpected_error_msg(e.code))));
        break;
    }
  }

  @override
  void onLoginSuccess(User user) {
    if (user.userRole == 'USER') {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(HomePage.name, (_) => false);
    } else {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(HomePageAdmin.name, (_) => false);
    }
  }

  void callLoadingScreen() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(
            child: CircularProgressIndicator(color: Colors.white)));
  }
}
