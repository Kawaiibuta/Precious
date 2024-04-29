import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:precious/data_sources/product/product.dart';
import 'package:precious/resources/endpoints.dart';
import 'package:precious/resources/utils/dio_utils.dart';

class ProductRepository {
  static Future<List<Product>> getAll(
      {int start = 1,
      int quantity = 9223372036854775807,
      int type = -1}) async {
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
    return result;
  }

  static Future<Product?> add(Product product, {List<XFile>? imageList}) async {
    var map = product.toJson();
    map.remove("id");
    map.remove("img_paths_url");
    map.remove("rating");
    map.remove("variants");
    debugPrint(map.toString());
    var data = FormData.fromMap(map);
    if (imageList != null) {
      imageList.forEach((element) async {
        final byte = MultipartFile.fromBytes(await element.readAsBytes());
        data.files.addAll({"img": byte}.entries);
      });
    }
    final result = await dio
        .request(
          EndPoint.product,
          options: Options(
            method: 'POST',
            headers: headers,
          ),
          data: data,
        )
        .then((value) => Product.fromJson(value.data))
        .catchError((e) {
      debugPrint(e.toString());
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
        .then((value) => true)
        .catchError((e) {
      debugPrint(e.toString());
      return false;
    });
    return result;
  }
}
