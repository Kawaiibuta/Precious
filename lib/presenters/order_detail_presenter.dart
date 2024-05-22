import 'package:flutter/foundation.dart';
import 'package:precious/data_sources/order/order.dart';
import 'package:precious/data_sources/order_repository.dart';
import 'package:precious/data_sources/user/user.dart';
import 'package:precious/data_sources/user_repository.dart';

abstract class OrderDetailContract {
  onInitSuccess();
  onInitFail();
  onUpdateSuccess();
  onUpdateFail();
  onStartAsyncFunction();
  onEndAsyncFunction();
}

enum OrderStatus { PENDING, PROCESSING, COMPLETED, CANCELLED }

class OrderDetailPresenter {
  final OrderDetailContract _contract;
  final Order _order;
  late User? user;
  OrderDetailPresenter(this._order, {required OrderDetailContract contract})
      : _contract = contract;

  Future<void> init() async {
    try {
      _contract.onStartAsyncFunction();
      user = await UserRepository.getOne(_order.userId);
      _contract.onInitSuccess();
      _contract.onEndAsyncFunction();
    } catch (error) {
      _contract.onInitFail();
    }
  }

  Future<void> update(OrderStatus status) async {
    try {
      _contract.onStartAsyncFunction();
      OrderRepository.update(_order.id!, status);
      _contract.onUpdateSuccess();
      _contract.onEndAsyncFunction();
    } catch (error) {
      debugPrint(error.toString());
      _contract.onUpdateFail();
    }
  }
}
