import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:precious/resources/endpoints.dart';
import 'package:precious/resources/utils/dio_utils.dart';
import 'package:precious/data_sources/type/type.dart';

class TypeRepository {
  static Future<List<Type>> getAll() async {
    debugPrint(EndPoint.type);
    final result = await dio
        .request(EndPoint.type,
            options: Options(
              method: 'GET',
              headers: headers as Map<String, dynamic>,
            ))
        .then((value) => (value.data as List).map((e) {
              return Type.fromJson(e as Map<String, dynamic>);
            }).toList())
        .catchError((e) {
      debugPrint(e.toString());
      return <Type>[];
    });
    return result;
  }

  static Future<bool> add(Type type) async {
    var data = FormData.fromMap(type.toJson());
    final result = await dio
        .request(
          EndPoint.type,
          options: Options(
            method: 'POST',
            headers: headers,
          ),
          data: data,
        )
        .then((value) => true)
        .catchError((e) {
      debugPrint(e.toString());
      return false;
    });
    return result;
  }
}
