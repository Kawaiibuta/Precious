import 'package:flutter/material.dart';
import 'package:precious/data_sources/order/order.dart';
import 'package:precious/data_sources/order_repository.dart';

class OrderPresenter {
  static Map<int, Order> orderList = {};
  static const quantityForEach = 20;
  static List<int> selectedOrder = [];

  Future<List<Order>> getAll({bool more = false}) async {
    if (orderList.values.isNotEmpty) {
      return orderList.values.toList();
    }
    final result = await OrderRepository.getAll().then((e) {
      for (var element in e) {
        orderList.addEntries(<int, Order>{element.id!: element}.entries);
      }
      return e;
    }).catchError((e) {
      debugPrint(e.toString());
      return <Order>[];
    });

    return result;
  }
}
