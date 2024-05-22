import 'package:precious/data_sources/order/order.dart';
import 'package:precious/data_sources/order_repository.dart';
import 'package:precious/presenters/page_contract.dart';
import 'package:precious/presenters/page_presenter.dart';

abstract class AdminOrderContract extends PageContract {}

class AdminOrderPresenter extends PagePresenter {
  final AdminOrderContract _contract;
  String? searchString;
  var selectedTab = 0;
  var checkedValue = false;
  var option = false;
  AdminOrderPresenter(this._contract);

  List<Order> get orderList => OrderRepository.list.values.toList();
  @override
  Future<bool> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> init() async {
    _contract.onStartAsyncTask();
    await Future.wait([OrderRepository.getAll()]);
    _contract.onInitSuccess();
    _contract.onEndAsyncTask();
  }

  @override
  Future<void> refresh() async {
    _contract.onStartAsyncTask();
    OrderRepository.reset();
    await Future.wait([OrderRepository.getAll()]);
    _contract.onEndAsyncTask();
  }
}
