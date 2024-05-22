import 'package:flutter/material.dart';
import 'package:precious/resources/app_export.dart';

class SettingButton extends StatelessWidget {
  final IconData icon;

  final String text;

  final Widget? customWidgetButton;

  final void Function() onTap;

  const SettingButton(this.text, this.icon,
      {super.key, this.customWidgetButton, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.all(8.h),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              width: 44.h,
              height: 44.h,
              margin: EdgeInsets.only(left: 8.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.h),
                  color: Theme.of(context).colorScheme.primaryContainer),
              child: Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
                size: 20.h,
              ),
            ),
            Positioned(
                left: 64.h,
                child: Text(text,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary))),
            Positioned(
              right: 0,
              child: customWidgetButton != null
                  ? customWidgetButton!
                  : Icon(
                      Icons.chevron_right,
                      size: 28.h,
                      color: Theme.of(context).colorScheme.primary,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
