import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:precious/data_sources/product/product.dart';
import 'package:precious/resources/endpoints.dart';
import 'package:precious/resources/utils/dio_utils.dart';

class ProductRepository {
  static Future<List<Product>> getAll() async {
    final result = await dio
        .request(
          EndPoint.product,
          options: Options(
            method: 'GET',
            headers: headers as Map<String, dynamic>,
          ),
        )
        .then((value) => value.data.map((e) {
              return Product.fromJson(e as Map<String, dynamic>);
            }).toList())
        .catchError((e) {
      debugPrint(e.toString());
      return <Product>[];
    });
    return result;
  }

  static Future<Product?> getOne(int id) async {
    final result = await dio
        .request(
          EndPoint.productDetail(id),
          options: Options(
            method: 'GET',
            headers: headers,
          ),
        )
        .then((value) =>
            Product.fromJson(JsonDecoder(value.data) as Map<String, dynamic>))
        .catchError((e) {
      debugPrint(e.toString());
      return null;
    });
    return result;
  }

  static Future<bool> addProduct(Product product) async {
    var data = FormData.fromMap(product.toJson());
    final result = await dio
        .request(
          EndPoint.product,
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

  static Future<bool> updateProduct(Product product) async {
    if (product.id == null) {
      debugPrint("Product's not existed");
      return false;
    }
    var data = FormData.fromMap(product.toJson().remove("id"));
    final result = await dio
        .request(
          EndPoint.productDetail(product.id!),
          options: Options(
            method: 'PATCH',
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

  static Future<bool> deleteProduct(int id) async {
    var headers = {'accept': 'application/json'};
    final result = await dio
        .request(
          EndPoint.productDetail(id),
          options: Options(
            method: 'DELETE',
            headers: headers,
          ),
        )
        .then((value) => true)
        .catchError((e) {
      debugPrint(e.toString());
      return false;
    });
    return result;
  }
}
