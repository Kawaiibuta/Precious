import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:precious/data_sources/auth_repository.dart';
import 'package:precious/data_sources/order_repository.dart';
import 'package:precious/data_sources/product_repository.dart';
import 'package:precious/models/user/user.dart';
import 'package:precious/data_sources/user_repository.dart';
import 'package:precious/models/variant/variant.dart';
import 'package:precious/presenters/form_presenter.dart';

abstract class OrderFormContract {
  onInitSuccess();
  onInitFail();
  onResetSuccess();
  onResetFail();
  onAddSuccess();
  onAddFail();
  onMissingField();
  onStartAsyncFunction();
  onEndAsyncFunction();
}

class OrderFormPresenter implements FormPresenter {
  @override
  var item;
  User? user;
  Map<Variant, int> variants = {};
  final OrderFormContract _contract;
  PaymentMethod method = PaymentMethod.cash;
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  OrderFormPresenter(this._contract);
  @override
  Future<void> add() async {
    try {
      _contract.onStartAsyncFunction();
      if (variants.isEmpty) {
        _contract.onMissingField();
        throw (Exception("At least one product is selected."));
      }
      final items = variants.map((key, value) => MapEntry(key.id!, value));
      if (addressController.text.isEmpty || phoneController.text.isEmpty) {
        _contract.onMissingField();
      } else {
        final order = await OrderRepository.add(
            items, user!.id!, addressController.text, phoneController.text);

        debugPrint(order.toString());
        if (order.id != null) {
          OrderRepository.pay(order.id!, PaymentMethod.momo);
        }
        _contract.onAddSuccess();
      }
    } catch (error) {
      debugPrint(error.toString());
      _contract.onAddFail();
    } finally {
      _contract.onEndAsyncFunction();
    }
  }

  @override
  Future<void> init() async {
    _contract.onStartAsyncFunction();
    try {
      await Future.wait([UserRepository.getAll(), ProductRepository.getAll()]);
      user = AuthRepository.currentUser;
      if (user!.addresses.isNotEmpty) {
        addressController.text = user!.addresses[0];
      }
      if (user!.phoneNumber != null) phoneController.text = user!.phoneNumber!;
      _contract.onInitSuccess();
    } catch (error) {
      debugPrint(error.toString());
      _contract.onInitFail();
    }
    _contract.onEndAsyncFunction();
  }

  @override
  Future<void> refresh() {
    // TODO: implement refresh
    throw UnimplementedError();
  }

  @override
  Future<void> update() {
    // TODO: implement update
    throw UnimplementedError();
  }

  void changeUser(User value) {
    user = value;
    if (user!.addresses.isNotEmpty) addressController.text = user!.addresses[0];
    if (user!.phoneNumber != null) phoneController.text = user!.phoneNumber!;
  }
}
