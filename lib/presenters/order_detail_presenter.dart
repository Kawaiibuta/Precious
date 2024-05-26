import 'package:flutter/foundation.dart';
import 'package:precious/models/order/order.dart';
import 'package:precious/data_sources/order_repository.dart';
import 'package:precious/models/user/user.dart';
import 'package:precious/data_sources/user_repository.dart';
import 'package:url_launcher/url_launcher_string.dart';

abstract class OrderDetailContract {
  onInitSuccess();
  onInitFail();
  onUpdateSuccess();
  onUpdateFail();
  onStartAsyncFunction();
  onEndAsyncFunction();

  void onContactFail() {}
}

enum OrderStatus { PENDING, PROCESSING, COMPLETED, CANCELLED }

class OrderDetailPresenter {
  final OrderDetailContract _contract;
  Order order;
  late User? user;
  OrderDetailPresenter(this.order, {required OrderDetailContract contract})
      : _contract = contract;

  Future<void> init() async {
    try {
      _contract.onStartAsyncFunction();
      user = await UserRepository.getOne(order.userId);
      _contract.onInitSuccess();
      _contract.onEndAsyncFunction();
    } catch (error) {
      _contract.onInitFail();
    }
  }

  Future<void> update(OrderStatus status) async {
    try {
      _contract.onStartAsyncFunction();
      final response = await OrderRepository.update(order.id!, status);
      if (response != null) {
        order = response;
      } else {
        _contract.onUpdateFail();
      }
      _contract.onUpdateSuccess();
      _contract.onEndAsyncFunction();
    } catch (error) {
      debugPrint(error.toString());
      _contract.onUpdateFail();
    }
  }

  void contactUser() {
    if (user == null) {
      _contract.onContactFail();
      return;
    }
    try {
      if (user!.phoneNumber != null) {
        launchUrlString("tel://${user!.phoneNumber!}");
      }
      if (user!.email != null) {
        launchUrlString("mailto:${user!.email!}");
      }
    } catch (e) {
      debugPrint(e.toString());
      _contract.onContactFail();
    }
  }

  Future<void> updateIsPaid(bool bool) async {
    try {
      _contract.onStartAsyncFunction();
      final response = await OrderRepository.updatePaid(order.id!, bool);
      if (response != null) {
        order = response;
      } else {
        throw Exception("The returned order is null.");
      }
    } catch (error) {
      debugPrint(error.toString());
    }
    _contract.onEndAsyncFunction();
  }
}
