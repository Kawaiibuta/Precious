import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:precious/models/user/user.dart';
import 'package:precious/resources/endpoints.dart';
import 'package:precious/resources/utils/dio_utils.dart';

class AuthRepository {
  static User? currentUser;
  static String? idToken;
  static Future<User?> updateCurrentUser() async {
    debugPrint("Update current user");
    idToken = await auth.FirebaseAuth.instance.currentUser!.getIdToken();
    debugPrint(idToken);
    final data = {"idToken": idToken};
    final response = await dio
        .request(EndPoint.login,
            options: Options(
              method: 'POST',
              headers: headers,
            ),
            data: data)
        .then((value) => User.fromJson(value.data));
    currentUser = response;
    currentUser = currentUser!
        .copyWith(name: auth.FirebaseAuth.instance.currentUser!.displayName);

    return response;
  }
}
