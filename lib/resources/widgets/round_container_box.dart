import 'package:flutter/material.dart';
import 'package:precious/resources/app_export.dart';

class RoundContainerBox extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final Widget? child;
  final bool hasShadow;
  final double shadowWidth;
  final BoxBorder? border;

  const RoundContainerBox(
      {super.key,
      this.padding,
      this.hasShadow = false,
      this.border,
      this.shadowWidth = 0,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        border: border,
        borderRadius: BorderRadius.circular(24.h),
        boxShadow: [
          if (hasShadow)
            BoxShadow(
              color: Colors.grey.shade300,
              offset: Offset(3.h, 3.v),
              blurRadius: shadowWidth + 2.h,
              spreadRadius: shadowWidth,
            )
        ],
      ),
      child: child,
    );
  }
}
