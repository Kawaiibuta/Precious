import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:precious/models/order/order.dart';
import 'package:precious/presenters/order_detail_presenter.dart';
import 'package:precious/resources/endpoints.dart';
import 'package:precious/resources/utils/dio_utils.dart';

enum PaymentMethod { cash, momo, onDelivery }

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
    list.addAll(
        response.asMap().map((key, value) => MapEntry(value.id ?? key, value)));
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

  static Future<String> pay(int id, PaymentMethod type) async {
    var data = json.encode({"redirectURL": "app://precious/momoComplete"});
    final response = await dio
        .request("${EndPoint.orderDetail(id)}/paid",
            options: Options(headers: headers, method: "POST"), data: data)
        .then((value) => value.data as Map<String, dynamic>)
        .catchError((error) {
      debugPrint(error.response.toString());
      return <String, dynamic>{"deeplink": ""};
    });
    if (type == PaymentMethod.momo) return response['payUrl'];
    if (type == PaymentMethod.cash) return response['qrCodeUrl'];
    return response["deeplink"];
  }

  static Future<Order> add(Map<int, int> items, int userId, String address,
      String phoneNumber) async {
    final result = [];
    for (var item in items.entries) {
      result.add(<String, int>{"variant_id": item.key, 'quantity': item.value});
    }
    final data = json.encode({
      "items": result,
      "user_id": userId,
      "address": address,
      "phone_number": phoneNumber
    });

    debugPrint("start call API: ${data.toString()}");
    final response = await dio
        .request(EndPoint.order,
            options: Options(method: "POST", headers: headers), data: data)
        .then((value) => Order.fromJson(value.data));
    if (response.id != null) {
      list.addEntries(<int, Order>{response.id!: response}.entries);
    }
    return response;
  }

  static Future<Order?> update(int id, OrderStatus status) async {
    final data = json.encode({"status": status.toString()});
    final response = await dio
        .request(EndPoint.orderDetail(id),
            options: Options(method: "PATCH", headers: headers), data: data)
        .then((value) => Order.fromJson(value.data))
        .catchError((error) {
      debugPrint(error);
      return null;
    });
    list.update(id, (value) => response);
    return response;
  }
}
