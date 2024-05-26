abstract class Presenter {
  List<int> selected = [];
  Future<List<dynamic>> getAll({bool more = false, bool reset = false});
  Future<bool> delete(int id);
  Future<dynamic> getOne(int id, {bool detail = false});
}
