import 'package:flutter/material.dart';
import 'package:precious/resources/app_export.dart';
import 'package:precious/resources/widgets/custom_elevated_button.dart';
import 'package:precious/views/admin/home_page_admin.dart';
import 'package:precious/views/home_page.dart';

class SignUpSuccessPage extends StatefulWidget {
  static const name = '/signUpSuccess';

  const SignUpSuccessPage({super.key});

  @override
  State<SignUpSuccessPage> createState() => _SignUpSuccessPageState();
}

class _SignUpSuccessPageState extends State<SignUpSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        padding: EdgeInsets.all(16.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 160.v),
            Icon(
              Icons.check_circle_outline,
              size: 80.h,
              color: Colors.lightGreen,
            ),
            SizedBox(height: 30.v),
            Text(AppLocalizations.of(context)!.sign_up_success_title,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.w800)),
            Text(AppLocalizations.of(context)!.sign_up_success_body,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium),
            SizedBox(height: 240.v),
            CustomElevatedButton(
                text: AppLocalizations.of(context)!.start_shopping,
                buttonTextStyle: Theme.of(context).textTheme.labelLarge,
                buttonStyle:
                    ElevatedButton.styleFrom(backgroundColor: Colors.black),
                onPressed: _goToMainPage),
          ],
        ),
      )),
    );
  }

  void _goToMainPage() {
    Navigator.of(context).pushReplacementNamed(HomePage.name);
  }
}
