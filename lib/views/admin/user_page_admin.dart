import 'package:flutter/material.dart';

class UserPageAdmin extends StatefulWidget {
  const UserPageAdmin({Key? key}) : super(key: key);

  @override
  _UserPageAdminState createState() => _UserPageAdminState();
}

class _UserPageAdminState extends State<UserPageAdmin> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: const Padding(
            padding: EdgeInsets.only(top: 20.0, left: 8.0, right: 8.0),
            child: const Column(children: [])),
        onRefresh: () async {});
  }
}
