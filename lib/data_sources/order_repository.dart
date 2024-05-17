import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:precious/data_sources/order/order.dart';
import 'package:precious/resources/endpoints.dart';
import 'package:precious/resources/utils/dio_utils.dart';

class OrderRepository {
  static Map<int, Order> list = {};
  static const quantityForEach = 20;
  static Future<List<Order>> getAll({bool more = false}) async {
    debugPrint("get all order");
    var response = await dio
        .request(
          EndPoint.order,
          options: Options(
            method: 'GET',
            headers: headers,
          ),
        )
        .then((value) => (value.data as List).map((e) {
              return Order.fromJson(e as Map<String, dynamic>);
            }).toList())
        .catchError((e) {
      debugPrint(e.toString());
      return <Order>[];
    });
    list.addAll(response
        .asMap()
        .map((key, value) => MapEntry(value.id ?? key, value)));
    return response;
  }

  static void reset() {
    list.clear();
  }

  static Future<Order?> getOne(int id) async {
    final response = await dio
        .request(
          EndPoint.orderDetail(id),
          options: Options(
            method: 'GET',
            headers: headers,
          ),
        )
        .then((value) => Order.fromJson(value.data))
        .catchError((error) {
      debugPrint(error.response.toString());
      return null;
    });

    list.update(id, (value) => response);
    return response;
  }
}
