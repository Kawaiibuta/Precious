import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:precious/models/option/option.dart';
import 'package:precious/models/product/product.dart';
import 'package:precious/models/variant/variant.dart';
import 'package:precious/resources/endpoints.dart';
import 'package:precious/resources/utils/dio_utils.dart';
import 'package:http_parser/http_parser.dart';

class ProductRepository {
  static Map<int, Product> list = {};
  static const quantityForEach = 20;
  static bool maximum = false;

  static Future<List<Product>> getAll(
      {bool more = false,
      int quantity = quantityForEach,
      int type = -1,
      bool reset = false}) async {
    debugPrint(EndPoint.productWithParam(
        start: more ? list.length + 1 : 1,
        quantity: (more || list.isEmpty) ? quantityForEach : list.length,
        type: type));
    if (maximum) return list.values.toList();
    final result = await dio
        .request(
            EndPoint.productWithParam(
                start: more ? list.length + 1 : 1,
                quantity:
                    (more || list.isEmpty) ? quantityForEach : list.length,
                type: type),
            options: Options(
              method: 'GET',
              headers: headers,
            ))
        .then((value) => (value.data as List).map((e) {
              return Product.fromJson(e as Map<String, dynamic>);
            }).toList())
        .catchError((e) {
      debugPrint(e.toString());
      return <Product>[];
    });
    if (result.isEmpty) {
      maximum = true;
    }
    for (var element in result) {
      if (list.containsKey(element.id)) {
        list.update(element.id!, (value) => element);
      } else {
        if (element.id! == 1) debugPrint("Product id 1: $element");
        list.addEntries(<int, Product>{element.id!: element}.entries);
      }
    }
    debugPrint("List after getAll: ${list.keys.toString()}");
    return result;
  }

  static Future<Product?> getOne(int id, {detail = true}) async {
    if ((list.containsKey(id) && list[id]!.variants.isNotEmpty) || !detail) {
      return list[id];
    }

    final result = await dio
        .request(
      EndPoint.productDetail(id),
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    )
        .then((value) {
      return Product.fromJson(value.data);
    }).catchError((e) {
      debugPrint("Error from getOne $e");
      return null;
    });
    if (list.containsKey(id)) {
      list.update(id, (value) => result);
    } else {
      list.addEntries(<int, Product>{result.id!: result}.entries);
    }
    return result;
  }

  static Future<Product?> add(
      Product product, Map<String, Uint8List> imageList) async {
    var data = FormData.fromMap({
      ...product.toJson(),
      "img[]": imageList
          .map((key, value) =>
              MapEntry(key, MultipartFile.fromBytes(value, filename: key)))
          .values
          .toList()
    });
    debugPrint(data.fields.toString());
    final result = await dio
        .request(
      EndPoint.product,
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    )
        .then((value) {
      final result = Product.fromJson(value.data);
      list.addEntries(<int, Product>{result.id!: result}.entries);
      return result;
    }).catchError((e) {
      debugPrint(e.response.toString());
      return null;
    });
    return result;
  }

  static Future<bool> update(Product product) async {
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

  static Future<bool> delete(int id) async {
    var headers = {'accept': 'application/json'};
    final result = await dio
        .request(
      EndPoint.productDetail(id),
      options: Options(
        method: 'DELETE',
        headers: headers,
      ),
    )
        .then((value) {
      list.remove(id);
      return true;
    }).catchError((e) {
      debugPrint(e.toString());
      return false;
    });
    return result;
  }

  static Future<Variant?> addVariant(
      int productId, Variant value, Map<String, Uint8List> images) async {
    if (!list.containsKey(productId)) await getOne(productId);
    var map = value.toJson();
    var data = FormData.fromMap({
      ...map,
      "product_id": productId,
    });
    for (var file in images.keys) {
      data.files.addAll([
        MapEntry(
            "img[]", MultipartFile.fromBytes(images[file]!, filename: file)),
      ]);
    }
    debugPrint(data.fields.toString());
    final response = await dio
        .request(EndPoint.productVariant(value.id!),
            options: Options(
              method: "PATCH",
              headers: headers,
            ),
            data: data)
        .then((value) {
      debugPrint(value.data.toString());
      return Variant.fromJson(value.data);
    }).catchError((error) {
      debugPrint(error.response.toString());
      return Variant(name: "name", productId: productId);
    });
    if (response.id != null) {
      final result = await getOne(productId);
      if (result != null) list.update(productId, (value) => result);
    }

    return response;
  }

  static Future<Option?> addOption(int id, Option option) async {
    var temp = option.copyWith(productId: id);
    var data = json.encode(temp.toJson());
    debugPrint(data.toString());
    final response = await dio
        .request(EndPoint.option,
            options: Options(
              method: "POST",
              headers: headers,
            ),
            data: data)
        .then((value) {
      debugPrint(value.toString());
      return Option.fromJson(value.data);
    }).catchError((error) {
      debugPrint(error.response.toString());
      return null;
    });
    return response;
  }

  static void reset() {
    list.clear();
  }

  static Future<Product?> createVariantForProduct(int id) async {
    final response = await dio
        .request(EndPoint.createVariant(id),
            options: Options(method: "POST", headers: headers))
        .then((value) => Product.fromJson(value.data))
        .catchError((error) {
      debugPrint(error.response.toString());
      return null;
    });
    if (response.id != null && response.id == id) {
      list.update(id, (value) => response);
    }
    return response;
  }
}
