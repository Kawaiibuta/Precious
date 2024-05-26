abstract class HomePageContract {
  void onInitSuccess();
}

class HomePagePresenter {
  final HomePageContract _contract;
  HomePagePresenter(this._contract);
}
