import 'package:flutter/material.dart';
import 'package:precious/resources/app_export.dart';
import 'package:precious/resources/widgets/custom_elevated_button.dart';
import 'package:precious/views/login_page.dart';
import 'package:precious/views/sign_up_page.dart';

class LoginOrSignUpPage extends StatelessWidget {
  static const name = '/loginOption';

  const LoginOrSignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/background_image.jpg'),
            fit: BoxFit.cover,
          )),
          padding: EdgeInsets.all(16.h),
          child: Stack(
            children: [
              Positioned(
                top: 100.v,
                left: 0,
                right: 0,
                child: Image.asset(
                  "assets/images/uit_jewels_white.png",
                  width: 200.h,
                  height: 200.v,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0.v,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomElevatedButton(
                        text: AppLocalizations.of(context)!.login,
                        margin: EdgeInsets.symmetric(vertical: 8.v),
                        buttonStyle: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white
                        ),
                        buttonTextStyle: const TextStyle(color: Colors.black),
                        onPressed: () {
                          Navigator.of(context).pushNamed(LoginPage.name);
                        }),
                    CustomElevatedButton(
                      text: AppLocalizations.of(context)!.sign_up,
                      margin: EdgeInsets.symmetric(vertical: 8.v),
                      buttonStyle: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white, width: 1.v),
                            borderRadius: BorderRadius.circular(30.v),
                          ),
                          backgroundColor: Colors.transparent),
                      buttonTextStyle: const TextStyle(color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).pushNamed(SignUpPage.name);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
