import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:precious/resources/widgets/bottom_navigation_route.dart';
import 'package:precious/resources/app_export.dart';
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
    return Container(
      height: 60.v,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.h), topRight: Radius.circular(16.h)),
          boxShadow: [
            BoxShadow(color: Theme.of(context).colorScheme.primaryContainer,
                spreadRadius: 1.h, blurRadius: 2.h, blurStyle: BlurStyle.outer)
          ]),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: widget.routes
              .asMap()
              .map((index, e) => MapEntry(
                  index,
                  Padding(
                    padding: selectedIndex == index
                        ? EdgeInsets.only(left: 10.h)
                        : EdgeInsets.symmetric(horizontal: 10.h),
                    child: BottomNavigationButton(
                      icon: e.icon,
                      title: e.title,
                      titleDecoration: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer),
                      selected: selectedIndex == index,
                      showTitleSelected: true,
                      selectedIconColor: Colors.white,
                      selectedIconBackgroundColor: Colors.black,
                      selectedTitleBackgroundColor: Colors.grey.shade400,
                      onClick: () => _handleonClick(index),
                    ),
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
