import 'package:flutter/material.dart';
import 'package:precious/data_sources/bottom_navigation_route.dart';
import 'package:precious/resources/widgets/custom_bottom_navigation.dart';
import 'package:precious/views/cart_page.dart';
import 'package:precious/views/landing_page.dart';
import 'package:precious/views/profile_page.dart';
import 'package:precious/views/search_page.dart';

const routes = [
  {"title": "Home", "icon": Icons.home, "route": LandingPage()},
  {"title": "Search", "icon": Icons.search, "route": SearchPage()},
  {"title": "Cart", "icon": Icons.shopping_cart, "route": CartPage()},
  {"title": "Profile", "icon": Icons.person, "route": ProfilePage()},
];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selected = 0;
  @override
  Widget build(BuildContext context) {
    var bottomRoute = routes
        .map((e) => BottomNavigationRoute(
            icon: e['icon'] as IconData, title: e['title'] as String))
        .toList();
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigation(
        routes: bottomRoute,
        onIndexChange: (value) => _handleIndexChange(value),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0, left: 10.0, right: 10.0),
        child: Center(child: routes[selected]['route'] as Widget),
      ),
    );
  }

  _handleIndexChange(int value) {
    setState(() {
      selected = value;
    });
  }
}
