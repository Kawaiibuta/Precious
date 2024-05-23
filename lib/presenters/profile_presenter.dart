import 'package:precious/data_sources/login_repository.dart';
import 'package:precious/data_sources/user_repository.dart';
import 'package:precious/models/user/user.dart';

abstract class ProfilePageContract {
  void onGetUserDetailSuccess(User user);
  void onGetUserFailed(Exception e);
  void onSignOutComplete();
  void onSignOutFailed(Exception e);
}

class ProfilePresenter {
  final ProfilePageContract _contract;
  final _repos = UserRepository();

  ProfilePresenter(this._contract);

  Future<void> getUser() async {
    await _repos
        .getUser()
        .then((user) => _contract.onGetUserDetailSuccess(user))
        .catchError((e) => _contract.onGetUserFailed(e));
  }

  Future<void> signOut() async {
    await LoginRepository()
        .logOut()
        .then((_) => _contract.onSignOutComplete())
        .catchError((e) => _contract.onSignOutFailed(e));
  }
}
