import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:precious/data_sources/option/option.dart';
import 'package:precious/data_sources/product/product.dart';
import 'package:precious/data_sources/product_repository.dart';
import 'package:precious/data_sources/variant/variant.dart';
import 'package:precious/presenters/base_presenter.dart';

class ProductPresenter implements Presenter {
  @override
  List<int> selected = [];
  bool multiSelection = false;

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

  @override
  Future<bool> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }
}
