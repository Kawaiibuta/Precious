import 'package:precious/data_sources/auth_repository.dart';
import 'package:precious/data_sources/login_repository.dart';
import 'package:precious/models/user/user.dart';

abstract class ProfilePageContract {
  void onGetUserDetailSuccess(User user);
  void onGetUserFailed(Exception e);
  void onSignOutComplete();
  void onSignOutFailed(Exception e);
}

class ProfilePresenter {
  final ProfilePageContract _contract;

  ProfilePresenter(this._contract);

  Future<void> getUser() async {
    final user = AuthRepository.currentUser;
    if (user != null) _contract.onGetUserDetailSuccess(user);
  }

  Future<void> signOut() async {
    await LoginRepository()
        .logOut()
        .then((_) => _contract.onSignOutComplete())
        .catchError((e) => _contract.onSignOutFailed(e));
  }
}
