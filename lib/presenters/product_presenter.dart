import 'package:flutter/material.dart';
import 'package:precious/data_sources/product/product.dart';
import 'package:precious/data_sources/product_repository.dart';

class ProductPresenter {
  static Map<int, Product> productList = {};
  static const quantityForEach = 20;
  Future<List<Product>> getAll({bool more = false}) async {
    if (productList.values.isNotEmpty && more == false) {
      return productList.values.toList();
    }
    debugPrint("get Product");
    final result = await ProductRepository.getAll(
            start: productList.length + 1, quantity: quantityForEach)
        .then((e) {
      for (var element in e) {
        productList.addEntries(<int, Product>{element.id!: element}.entries);
      }
      return e;
    }).catchError((e) {
      debugPrint(e.toString());
      return <Product>[];
    });

    return result;
  }

  Future<Product?> getOne(int id) async {
    if (productList.keys.contains(id)) return productList[id]!;
    final result = await ProductRepository.getOne(id);
    return result;
  }
}
