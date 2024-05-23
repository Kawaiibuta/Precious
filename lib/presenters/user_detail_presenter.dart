import 'package:precious/data_sources/user_repository.dart';
import 'package:precious/models/user/user.dart';

abstract class UserDetailPageContract {
  void onGetUserDetailSuccess(User user);
  void onGetUserDetailFailed(Exception e);
  void onUpdateUserDetailSuccess(User user);
  void onUpdateUserFailed(Exception e);
}

class UserDetailPresenter {
  final _repos = UserRepository();
  final UserDetailPageContract _viewContract;

  UserDetailPresenter(this._viewContract);

  Future<void> updateUser(User user) async {
    await _repos
        .updateUser(user)
        .then((user) => _viewContract.onUpdateUserDetailSuccess(user))
        .catchError((e) => _viewContract.onUpdateUserFailed(e));
  }

  Future<void> getUser() async {
        await _repos
        .getUser()
        .then((user) => _viewContract.onGetUserDetailSuccess(user))
        .catchError((e) => _viewContract.onGetUserDetailFailed(e));
  }
}
