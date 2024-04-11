import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:precious/data_sources/sign_up_repository.dart';

abstract class SignUpPageContract {
  void onSignUpSuccess();
  void onSignUpError(FirebaseException e);
}

class SignUpPresenter {
  final SignUpPageContract _viewContract;
  final _repos = SignUpRepository();

  SignUpPresenter(this._viewContract);

  Future<void> signUp(String username, String email, String password,
      String confirmPassword) async {
    await _repos
        .signUp(username, email, password)
        .then((_) => _viewContract.onSignUpSuccess())
        .catchError((e) => _viewContract.onSignUpError(e));
  }
}
