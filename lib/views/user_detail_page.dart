import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:precious/data_sources/user/user.dart';
import 'package:precious/presenters/login_presenter.dart';
import 'package:precious/resources/app_export.dart';

class UserDetailPage extends StatefulWidget {
  const UserDetailPage({super.key});

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  late User _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = LoginPresenter.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
                padding: EdgeInsets.all(16.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.v),
                    Container(
                      foregroundDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.h),
                      ),
                      child: Image.network(_currentUser.avatarImgPath,
                          width: 48.h, height: 48.h, fit: BoxFit.cover),
                    ),
                  ],
                ))));
  }
}
