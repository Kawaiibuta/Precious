import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:precious/resources/widgets/bottom_navigation_route.dart';
import 'package:precious/resources/app_export.dart';
import 'package:precious/resources/widgets/custom_bottom_navigation.dart';
import 'package:precious/views/cart_page.dart';
import 'package:precious/views/landing_page.dart';
import 'package:precious/views/profile_page.dart';
import 'package:precious/views/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const name = '/homePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selected = 0;
  late List<dynamic> routes;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
        // Update titles with the current localization
    routes = [
      {
        "title": AppLocalizations.of(context)!.home_bottom_title,
        "icon": Icons.home,
      },
      {
        "title": AppLocalizations.of(context)!.search_bottom_title,
        "icon": Icons.search,
      },
      {
        "title": AppLocalizations.of(context)!.cart_bottom_title,
        "icon": Icons.shopping_cart, 
      },
      {
        "title": AppLocalizations.of(context)!.profile_bottom_title,
        "icon": Icons.person,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    var bottomRoute = routes
        .map((e) => BottomNavigationRoute(
            icon: e['icon'] as IconData, title: e['title'] as String))
        .toList();
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CustomBottomNavigation(
          routes: bottomRoute,
          onIndexChange: (value) => _handleIndexChange(value),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Center(child: getRoute()),
        ),
      ),
    );
  }

  _handleIndexChange(int value) {
    setState(() {
      selected = value;
    });
  }

  void _handleChangePage(int i) {
    setState(() {
      selected = i;
    });
  }

  // Initialized selected page only
  Widget getRoute() => switch (selected) {
    0 => LandingPage(changePage: _handleChangePage),
    1 => const SearchPage(),
    2 => const CartPage(),
    _ => const ProfilePage()
  };
}
