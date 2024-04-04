import 'package:flutter/material.dart';
import 'package:precious/data_sources/bottom_navigation_route.dart';
import 'package:precious/resources/widgets/bottom_navigation_button.dart';

class CustomBottomNavigation extends StatefulWidget {
  const CustomBottomNavigation(
      {super.key, required this.routes, this.onIndexChange});

  final List<BottomNavigationRoute> routes;
  final Function(int index)? onIndexChange;
  @override
  _CustomBottomNavigationState createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: widget.routes
              .asMap()
              .map((index, e) => MapEntry(
                  index,
                  BottomNavigationButton(
                    icon: e.icon,
                    title: e.title,
                    selected: selectedIndex == index,
                    showTitleSelected: true,
                    selectedIconColor: Colors.white,
                    selectedIconBackgroundColor: Colors.black,
                    selectedTitleBackgroundColor: const Color(0xffeeeeee),
                    onClick: () => _handleonClick(index),
                  )))
              .values
              .toList()),
    );
  }

  _handleonClick(int value) {
    if (value != selectedIndex) {
      if (widget.onIndexChange != null) {
        widget.onIndexChange!(value);
      }
      setState(() {
        selectedIndex = value;
      });
    }
  }
}
