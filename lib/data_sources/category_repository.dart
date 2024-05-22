import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:precious/models/product_category/product_category.dart';
import 'package:precious/resources/endpoints.dart';
import 'package:precious/resources/utils/dio_utils.dart';

class ProductCategoryRepository {
  static Future<List<ProductCategory>> getAll() async {
    final result = await dio
        .request(EndPoint.category,
            options: Options(
              headers: headers,
              method: "GET",
            ))
        .then((value) =>
            (value.data as List).map((e) => ProductCategory.fromJson(e)))
        .catchError((e) {
      debugPrint(e.toString());
      return <ProductCategory>[];
    });
    return result.toList();
  }

  static Future<ProductCategory?> getOne(int id) async {
    final result = dio
        .request(EndPoint.categoryDetail(id),
            options: Options(headers: headers, method: "GET"))
        .then((value) => ProductCategory.fromJson(value.data))
        .catchError((e) {
      debugPrint(e.toString());
      return null;
    });
    return result;
  }

  static Future<bool> add(ProductCategory category) async {
    var data = FormData.fromMap(category.toJson().remove("id"));
    final result = dio
        .request(EndPoint.category,
            options: Options(headers: headers, method: "POST"), data: data)
        .then((value) => true)
        .catchError((e) {
      debugPrint(e.toString());
      return false;
    });
    return result;
  }

  static Future<bool> delete(int id) async {
    final result = dio
        .request(EndPoint.categoryDetail(id),
            options: Options(headers: headers, method: "DELETE"))
        .then((value) => true)
        .catchError((e) {
      debugPrint(e.toString());
      return false;
    });
    return result;
  }
}
