import 'package:flutter/material.dart';
import 'package:precious/data_sources/order/order.dart';
import 'package:precious/data_sources/order_repository.dart';
import 'package:precious/data_sources/user_repository.dart';
import 'package:precious/presenters/base_presenter.dart';

class OrderPresenter implements Presenter {
  @override
  List<int> selected = [];
  @override
  Future<List<Order>> getAll(
      {bool more = false, bool reset = false, bool detail = false}) async {
    if (OrderRepository.list.isNotEmpty) {
      return OrderRepository.list.values.toList();
    }
    if (reset) OrderRepository.reset();
    final result = await OrderRepository.getAll().then((value) async {
      if (detail) {
        await UserRepository.getAll();
        for (var element in value) {
          final user = await UserRepository.getOne(element.id!);
          OrderRepository.list
              .update(element.id!, (value) => value.copyWith(user: user));
        }
      }
      return OrderRepository.list.values.toList();
    }).catchError((e) {
      debugPrint(e.toString());
      return <Order>[];
    });
    return result;
  }

  @override
  delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  getOne(int id, {bool detail = false}) {
    // TODO: implement getOne
    throw UnimplementedError();
  }
}
