import 'package:flutter/material.dart';
import 'package:precious/data_sources/product/product.dart';
import 'package:precious/data_sources/product_repository.dart';
import 'package:precious/data_sources/type/type.dart';
import 'package:precious/data_sources/type_repository.dart';

class TypePresenter {
  static Map<int, Type> typeList = {};
  static const quantityForEach = 5;

  Future<List<Type>> getAll({bool more = false}) async {
    if (typeList.values.isNotEmpty && more == false) {
      return typeList.values.toList();
    }
    debugPrint("get type");
    final result = await TypeRepository.getAll().then((e) {
      for (var element in e) {
        typeList.addEntries(<int, Type>{element.id!: element}.entries);
      }
      return e;
    }).catchError((e) {
      debugPrint(e.toString());
      return <Type>[];
    });

    return result;
  }

  Future<List<Product>> getProductByType(int type, {bool more = false}) async {
    if (typeList.keys.isEmpty) getAll();
    if (typeList.containsKey(type)) {
      if (typeList[type]!.products.isEmpty || more) {
        typeList[type]!.products.addAll(await ProductRepository.getAll(
            start: typeList[type]!.products.length,
            quantity: quantityForEach,
            type: type));
      }
      return typeList[type]!.products;
    }
    return <Product>[];
  }
}
