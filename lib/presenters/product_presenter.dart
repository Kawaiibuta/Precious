import 'package:flutter/material.dart';
import 'package:precious/data_sources/product/product.dart';
import 'package:precious/data_sources/product_repository.dart';
import 'package:precious/presenters/base_presenter.dart';

class ProductPresenter implements BasePresenter {
  static Map<int, Product> productList = {};
  static const quantityForEach = 20;
  static List<int> selectedProduct = [];
  @override
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

  @override
  Future<Product?> getOne(int id, {detail = false}) async {
    if (productList.keys.contains(id)) {
      var product = productList[id]!;
      if (product.variants != null) return product;
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
  Future<bool> add({item}) async {
    if (item is Product) {
      return await ProductRepository.add(item)
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
