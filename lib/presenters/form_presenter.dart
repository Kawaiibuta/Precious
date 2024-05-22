abstract class FormPresenter {
  dynamic item;
  Future<void> init();
  Future<void> refresh();
  Future<void> add();
  Future<void> update();
}
