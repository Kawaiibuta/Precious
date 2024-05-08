import 'package:precious/data_sources/login_repository.dart';

abstract class ProfilePageContract {
  void onSignOutComplete();
  void onSignOutFailed(Exception e);
}

class ProfilePresenter {
  final ProfilePageContract _contract;

  ProfilePresenter(this._contract);

  Future<void> signOut() async {
    await LoginRepository()
        .logOut()
        .then((_) => _contract.onSignOutComplete())
        .catchError((e) => _contract.onSignOutFailed(e));
  }
}
