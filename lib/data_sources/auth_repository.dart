import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:precious/data_sources/user/user.dart';
import 'package:precious/resources/utils/dio_utils.dart';

class AuthRepository {
  static User? currentUser;

  static Future<User?> updateCurrentUser() async {
    debugPrint("Update current user");
    final idToken = await auth.FirebaseAuth.instance.currentUser!.getIdToken();
    final data = json.encode({"idToken": idToken});
    final response = await dio
        .request(
            'https://api-precious-com.onrender.com/api/auth/login_firebase',
            options: Options(
              method: 'POST',
              headers: headers,
            ),
            data: data)
        .then((value) => User.fromJson(value.data))
        .catchError((error) {
      debugPrint(error.toString());
      return null;
    });
    currentUser = response;
    return response;
  }
}
