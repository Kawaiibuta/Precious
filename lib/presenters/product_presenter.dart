import 'package:flutter/material.dart';
import 'package:precious/models/product/product.dart';
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

  Future<Product?> getOne(int id, {detail = false}) async {
    if (productList.keys.contains(id)) {
      var product = productList[id]!;
      if (detail) {
        product = await ProductRepository.getOne(id)
            .then((value) => productList.update(id, (_) => value ?? product));
      }
      return product;
    }
    final result = await ProductRepository.getOne(id).then((value) {
      if (value != null) {
        productList.addEntries(<int, Product>{id: value}.entries);
      }
      return value;
    });
    return result;
  }

  @override
  Future<bool> add({item, imageList}) async {
    if (item is Product) {
      return await ProductRepository.add(item, imageList)
          .then((value) => true)
          .catchError((e) {
        debugPrint(e.toString());
        return false;
      });
    }
    return false;
  }

  @override
  Future<bool> delete(List<int> items) async {
    bool item = true;
    items.forEach((element) async {
      item = await ProductRepository.delete(element).catchError((e) => false);
    });
    return item;
  }
}
