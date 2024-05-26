import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:precious/data_sources/auth_repository.dart';
import 'package:precious/models/user/user.dart' as model;
import 'package:precious/resources/endpoints.dart';
import 'package:precious/resources/utils/dio_utils.dart';

class UserRepository {
  static Map<int, model.User> list = {};
  static List<int> selected = [];
  static Future<List<model.User>> getAll({more = false}) async {
    if (!more && list.isNotEmpty) return list.values.toList();
    final response = await dio
        .request(EndPoint.user,
            options: Options(
              headers: headers,
              method: "GET",
            ))
        .then((value) =>
            (value.data as List).map((e) => model.User.fromJson(e)).toList())
        .catchError((error) {
      debugPrint(error.toString());
      return <model.User>[];
    });
    list.addAll(
        response.asMap().map((key, value) => MapEntry(value.id!, value)));
    return response;
  }

  static Future<model.User?> getOne(int id) async {
    if (list.containsKey(id)) return list[id];
    final response = await dio
        .request(EndPoint.userDetail(id),
            options: Options(
              headers: headers,
              method: "GET",
            ))
        .then((value) {
      final result = model.User.fromJson(value.data);
      list.addEntries(<int, model.User>{result.id!: result}.entries);
      return result;
    }).catchError((error) {
      debugPrint(error.response.toString());
      return null;
    });
    return response;
  }

  static Future<model.User?> getUserByUid(String uid) async {
    final response = await dio
        .request(EndPoint.findUserByUid(uid),
            options: Options(method: "GET", headers: headers))
        .then((value) {
      debugPrint("Value: ${value.data}");
      model.User.fromJson(value.data);
    }).catchError((error) {
      debugPrint(error.toString());
      return null;
    });
    if (!list.containsKey(response.id)) {
      list.addEntries(<int, model.User>{response.id!: response}.entries);
    } else {
      list.update(response.id!, (value) => response);
    }
    return response;
  }

  Future<model.User> updateUser(model.User user) async {
    await FirebaseAuth.instance.currentUser!.updateDisplayName(user.name);
    var response = await dio.request(EndPoint.user,
        data: {
          'age': user.age,
          'gender': user.gender,
        },
        options: Options(
          method: 'PUT',
          contentType: Headers.jsonContentType,
        ));
    if (response.statusCode == 200) {
      return model.User.fromJson(response.data);
    } else {
      throw FirebaseAuthException(
          code: '${response.statusCode}: ${response.statusMessage}');
    }
  }
}
