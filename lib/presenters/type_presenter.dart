import 'package:flutter/material.dart';
import 'package:precious/models/product/product.dart';
import 'package:precious/data_sources/product_repository.dart';
import 'package:precious/data_sources/type/type.dart';
import 'package:precious/data_sources/type_repository.dart';
import 'package:precious/presenters/base_presenter.dart';

class TypePresenter {
  static Map<int, Type> typeList = {};
  static const quantityForEach = 5;

  @override
  Future<List<Type>> getAll({int type = -1, bool more = false}) async {
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

  @override
  Future<Type?> getOne(int type) async {
    if (typeList.containsKey(type)) return typeList[type];
    return null;
  }

  Future<List<Product>> getProductByType(int type, {bool more = false}) async {
    if (typeList.keys.isEmpty) getAll();
    debugPrint(typeList.toString());
    debugPrint(typeList.containsKey(type).toString());
    if (typeList.containsKey(type)) {
      if (typeList[type]!.products.isEmpty || more) {
        final product = await ProductRepository.getAll(
            start: typeList[type]!.products.length + 1,
            quantity: quantityForEach,
            type: type);
        typeList[type]!.products.addAll(product);
        return product;
      }
      return typeList[type]!.products;
    }
    return <Product>[];
  }

  @override
  Future<bool> add({item}) async {
    if (item is Type) {
      return await TypeRepository.add(item)
          .then((value) => true)
          .catchError((e) {
        debugPrint(e.toString());
        return false;
      });
    }
    return false;
  }

  @override
  Future<bool> delete(List<int> items) {
    // TODO: implement delete
    throw UnimplementedError();
  }
}
