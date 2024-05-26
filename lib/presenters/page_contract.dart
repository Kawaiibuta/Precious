import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:precious/main.dart';

abstract class PageContract {
  void onInitSuccess();
  void onRefreshSuccess();
  void onDeleteSuccess();
  void onDeleteFail();
  void onStartAsyncTask() {
    showDialog(
        context: NavigationService.navigatorKey.currentContext!,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const SimpleDialog(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            children: <Widget>[
              Center(
                child: CircularProgressIndicator(),
              )
            ],
          );
        });
  }

  void onEndAsyncTask() {
    Get.back();
  }
}
