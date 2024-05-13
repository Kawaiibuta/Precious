import 'package:flutter/material.dart';
import 'package:precious/data_sources/product/product.dart';
import 'package:precious/data_sources/product_repository.dart';
import 'package:precious/presenters/base_presenter.dart';

class ProductPresenter implements Presenter {
  @override
  List<int> selected = [];
  @override
  Future<List<Product>> getAll({bool more = false, bool reset = false}) async {
    if (!more && ProductRepository.list.isNotEmpty) {
      return ProductRepository.list.values.toList();
    }
    if (reset) ProductRepository.reset();
    debugPrint("get Product");
    final result = await ProductRepository.getAll().then((e) {
      return e;
    }).catchError((e) {
      debugPrint(e.toString());
      return <Product>[];
    });
    return result;
  }

  @override
  Future<Product?> getOne(int id, {detail = false}) async {
    final productList = ProductRepository.list;
    if (productList.keys.contains(id) && !detail) {
      var product = productList[id]!;
      if (product.variants != null) return product;
      return product;
    }
    final result = await ProductRepository.getOne(id);
    return result;
  }

  Future<Product?> add(Product item) async {
    return await ProductRepository.add(item).catchError((e) {
      debugPrint(e.toString());
      return null;
    });
  }

  @override
  Future<bool> delete(int id) async {
    return ProductRepository.delete(id).catchError((error) {
      debugPrint(error.toString());
      return false;
    });
  }
}
