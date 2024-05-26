import 'package:flutter/material.dart';
import 'package:precious/resources/app_export.dart';
import 'package:precious/resources/widgets/custom_elevated_button.dart';
import 'package:precious/views/home_page.dart';

class OrderSuccessPage extends StatelessWidget {
  static const name = '/orderSuccess';

  const OrderSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(16.h),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              padding: EdgeInsets.all(20.h),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(60.h),
              ),
              child: Icon(Icons.shopping_bag,
                  color: Theme.of(context).colorScheme.onPrimary, size: 70.h),
            ),
            SizedBox(height: 30.v),
            Text(AppLocalizations.of(context)!.order_success_title,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(fontWeight: FontWeight.w900)),
            Text(AppLocalizations.of(context)!.order_success_body,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(height: 200.v),
            CustomElevatedButton(
                text: AppLocalizations.of(context)!.continue_shopping_btn_title,
                buttonTextStyle: Theme.of(context).textTheme.labelLarge,
                buttonStyle: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () => Navigator.of(context)
                    .pushNamedAndRemoveUntil(HomePage.name, (route) => false))
          ]),
        ),
      ),
    );
  }
}
