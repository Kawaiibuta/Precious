abstract class CheckOutPageContract {
  void onCheckoutSuccess();
  void onCheckoutFailed(Exception e);
}

class CheckOutPresenter {
  final CheckOutPageContract _viewContract;

  CheckOutPresenter(this._viewContract);

  Future<void> Checkout() async {

  }
}
