import 'package:precious/data_sources/auth_repository.dart';
import 'package:precious/data_sources/cart_repository.dart';
import 'package:precious/data_sources/order_repository.dart';
import 'package:precious/models/cart/cart.dart';

abstract class CheckOutPageContract {
  void onCheckoutSuccess();
  void onCheckoutFailed(Exception e);
}

class CheckOutPresenter {
  final CheckOutPageContract _viewContract;

  CheckOutPresenter(this._viewContract);

  Future<void> checkout(Cart cart, String address, PaymentMethod paymentMethod) async {
    Map<int, int> items = <int, int>{
      for (var item in cart.items) item.variant.id!: item.quantity,
    };
    var user = AuthRepository.currentUser!;
    await OrderRepository
        .add(items, user.id!, address, user.phoneNumber ?? '')
        .then((order) => OrderRepository.pay(order.id!, paymentMethod));
  }
}
