import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:precious/data_sources/product/product.dart';
import 'package:precious/data_sources/product_repository.dart';
import 'package:precious/data_sources/variant/variant.dart';
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

  Future<Product?> add(Product item, List<XFile> imageList) async {
    var result = <String, Uint8List>{};
    for (var element in imageList) {
      final byte = await element.readAsBytes();
      result.addEntries(<String, Uint8List>{element.name: byte}.entries);
    }
    return await ProductRepository.add(item, result).catchError((e) {
      debugPrint(e.toString());
      return null;
    });
  }

  Future<Variant?> addVariant(int productId, Variant item) async {
    var result = <String, Uint8List>{};
    for (var element in item.img_paths_url) {
      if (!Uri.parse(element).isAbsolute) {
        final file = XFile(element);
        result.addEntries(
            <String, Uint8List>{file.name: await file.readAsBytes()}.entries);
      }
    }
    return ProductRepository.addVariant(productId, item, result)
        .catchError((error) {
      debugPrint(error.toString());
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
