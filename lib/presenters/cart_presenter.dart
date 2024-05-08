import 'package:precious/data_sources/cart/cart.dart';
import 'package:precious/data_sources/cart_item/cart_item.dart';
import 'package:precious/data_sources/cart_repository.dart';

abstract class CartPageContract {
  void onGetCartComplete(Cart cart);

  void onGetCartFailed(Exception e);
}

class CartPagePresenter {
  final CartPageContract viewContract;

  final _repos = CartRepository();

  CartPagePresenter(this.viewContract);

  Future<void> getCart() async {
    await _repos
        .getCart()
        .then((value) => viewContract.onGetCartComplete(value))
        .catchError((e) => viewContract.onGetCartFailed(e));
  }

  Future<void> updateQuantity(CartItem cartItem, double quantity) async {
    await _repos
        .updateQuantity(cartItem, quantity)
        .then((value) => viewContract.onGetCartComplete(value))
        .catchError((e) => viewContract.onGetCartFailed(e));
  }
}
