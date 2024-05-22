import 'package:flutter/material.dart';
import 'package:precious/resources/app_export.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/background_image.jpg'),
              fit: BoxFit.cover,
            )),
            padding: EdgeInsets.all(16.h),
            child: const SizedBox.expand()),
      ),
    );
  }
}
