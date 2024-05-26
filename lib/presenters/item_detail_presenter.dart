import 'package:precious/data_sources/cart_repository.dart';
import 'package:precious/models/variant/variant.dart';

abstract class ItemDetailPageContract {
  void onAddToCartSuccess();
  void onAddToCartError(e);
}

class ItemDetailPresenter {
  final ItemDetailPageContract _contract;
  final _cartRepos = CartRepository();

  ItemDetailPresenter(this._contract);

  Future<void> addToCart(Variant variant) async {
    await _cartRepos
        .add(variant)
        .then((value) => _contract.onAddToCartSuccess())
        .catchError(_contract.onAddToCartError);
  }
}
