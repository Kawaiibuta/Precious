import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:precious/data_sources/user/user.dart';
import 'package:precious/resources/endpoints.dart';
import 'package:precious/resources/utils/dio_utils.dart';

class UserRepository {
  static Map<int, User> list = {};
  static List<int> selected = [];
  static Future<List<User>> getAll({more = false}) async {
    if (!more && list.isNotEmpty) return list.values.toList();
    final response = await dio
        .request(EndPoint.user,
            options: Options(
              headers: headers,
              method: "GET",
            ))
        .then((value) =>
            (value.data as List).map((e) => User.fromJson(e)).toList())
        .catchError((error) {
      debugPrint(error.response.toString());
      return <User>[];
    });
    list.addAll(
        response.asMap().map((key, value) => MapEntry(value.id!, value)));
    return response;
  }

  static Future<User?> getOne(int id) async {
    if (list.containsKey(id)) return list[id];
    final response = await dio
        .request(EndPoint.userDetail(id),
            options: Options(
              headers: headers,
              method: "GET",
            ))
        .then((value) {
      final result = User.fromJson(value.data);
      list.addEntries(<int, User>{result.id!: result}.entries);
      return result;
    }).catchError((error) {
      debugPrint(error.response.toString());
      return null;
    });
    return response;
  }
}
