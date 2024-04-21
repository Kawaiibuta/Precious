import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});
  static const name = "admin_home_page";
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SidebarX(
            controller: SidebarXController(selectedIndex: 0),
            items: const [
              SidebarXItem(icon: Icons.home, label: 'Home'),
              SidebarXItem(icon: Icons.search, label: 'Search'),
            ],
          ),
          // Your app screen body
        ],
      ),
    );
  }
}
