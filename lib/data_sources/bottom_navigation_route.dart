import 'package:flutter/material.dart';

class BottomNavigationRoute {
  const BottomNavigationRoute({required this.icon, required this.title});

  final IconData icon;
  final String title;

  String getTitle() {
    return title;
  }

  IconData getIcon() {
    return icon;
  }
}
