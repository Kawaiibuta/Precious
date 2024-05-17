import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:precious/data_sources/product/product.dart';
import 'package:precious/data_sources/variant/variant.dart';
import 'package:precious/resources/endpoints.dart';
import 'package:precious/resources/utils/dio_utils.dart';
import 'package:precious/views/item_detail_page.dart';

class ProductRepository {
  static Map<int, Product> list = {};
  static const quantityForEach = 20;
  static Future<List<Product>> getAll({
    int start = 0,
    int quantity = quantityForEach,
    int type = -1,
  }) async {
    if (start <= 0) start = list.length + 1;
    debugPrint(EndPoint.productWithParam(
        start: start, quantity: quantity, type: type));
    final result = await dio
        .request(
            EndPoint.productWithParam(
                start: start, quantity: quantity, type: type),
            options: Options(
              method: 'GET',
              headers: headers as Map<String, dynamic>,
            ))
        .then((value) => (value.data as List).map((e) {
              return Product.fromJson(e as Map<String, dynamic>);
            }).toList())
        .catchError((e) {
      debugPrint(e.toString());
      return <Product>[];
    });
    for (var element in result) {
      list.addEntries(<int, Product>{element.id!: element}.entries);
    }
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
        .then((value) {
      return Product.fromJson(value.data as Map<String, dynamic>);
    }).catchError((e) {
      debugPrint("Error from getOne $e");
      return null;
    });
    if (list.containsKey(id))
      list.update(id, (value) => result);
    else
      list.addEntries(<int, Product>{result.id!: result}.entries);
    return result;
  }

  static Future<Product?> add(
      Product product, Map<String, Uint8List> imageList) async {
    var map = product.toJson();
    map.remove("id");
    map.remove("img_paths_url");
    map.remove("variants");
    map.remove("price");
    map.remove("quantity");
    var data = FormData.fromMap({
      ...map,
      "img[]": imageList
          .map((key, value) =>
              MapEntry(key, MultipartFile.fromBytes(value, filename: key)))
          .values
          .toList()
    });
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
      debugPrint(e.response.data.toString());
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
    debugPrint(map.toString());
    map.remove("id");
    map.remove("img_paths_url");
    var data = FormData.fromMap({
      ...map,
      "product_id": productId,
      "img[]": images
          .map((key, value) =>
              MapEntry(key, MultipartFile.fromBytes(value, filename: key)))
          .values
    });
    final response = await dio
        .request(EndPoint.variant,
            options: Options(
              method: "POST",
              headers: headers,
            ),
            data: data)
        .then((value) => Variant.fromJson(value.data))
        .catchError((error) {
      debugPrint(error.response.toString());
      return null;
    });
    if (list[productId]!.variants == null) {
      list.update(productId, (value) => value.copyWith(variants: []));
    }
    list[productId]!.variants!.add(response);
    return response;
  }

  static void reset() {
    list.clear();
  }
}
