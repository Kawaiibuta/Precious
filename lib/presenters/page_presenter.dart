abstract class PagePresenter {
  List<int> selected = [];

  Future<void> init();
  Future<void> refresh();
  Future<bool> delete(int id);
}
