import 'package:precious/data_sources/user/user.dart';
import 'package:precious/data_sources/user_repository.dart';
import 'package:precious/presenters/base_presenter.dart';

class UserPresenter implements Presenter {
  @override
  List<int> selected = [];

  @override
  Future<bool> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<User>> getAll({bool more = false, bool reset = false}) async {
    return await UserRepository.getAll();
  }

  @override
  Future<User?> getOne(int id, {bool detail = false}) async {
    await getAll();
    return await UserRepository.getOne(id);
  }

  Future<User?> getOneByUId(String uid) async {
    await getAll();
    return UserRepository.list.values
        .where((element) => element.uid == uid)
        .first;
  }
}
