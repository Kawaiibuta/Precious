import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:precious/data_sources/order/order.dart';
import 'package:precious/resources/endpoints.dart';
import 'package:precious/resources/utils/dio_utils.dart';

class OrderRepository {
  static Future<List<Order>> getAll() async {
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
    return response;
  }
}
