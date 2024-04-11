import 'package:flutter/material.dart';

class CustomMaterialStateColor extends MaterialStateColor {
  final Color defaultColor;

  Color? onPressColor;

  Color? onDisabledColor;

  CustomMaterialStateColor(this.defaultColor,
      {this.onPressColor, this.onDisabledColor})
      : super(defaultColor.value);

  @override
  Color resolve(Set<MaterialState> states) {
    if (onPressColor != null && states.contains(MaterialState.pressed)) {
      return onPressColor!;
    }

    if (onDisabledColor != null && states.contains(MaterialState.disabled)) {
      return onDisabledColor!;
    }
    return defaultColor;
  }
}
