class BasePresenter {
  Future<List<dynamic>> getAll() async {
    return [];
  }

  Future<dynamic> getOne(int id) async {
    return null;
  }

  Future<bool> add({dynamic item}) async {
    return false;
  }

  Future<bool> delete(List<int> items) async {
    return false;
  }
}
