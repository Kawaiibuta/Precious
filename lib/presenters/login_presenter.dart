import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:precious/data_sources/auth_repository.dart';
import 'package:precious/data_sources/login_repository.dart';
import 'package:precious/data_sources/user/user.dart';

abstract class LoginPageContract {
  void onLoginSuccess(User currentUser);
  void onLoginFailed(FirebaseException e);
}

class LoginPresenter {
  final LoginPageContract _viewContract;
  final LoginRepository _repos = LoginRepository();

  static User? currentUser;

  LoginPresenter(this._viewContract);

  Future<void> login(String email, String password) async {
    await _repos
        .login(email, password)
        .then((_) => _viewContract.onLoginSuccess(AuthRepository.currentUser!))
        .catchError((e) {
      debugPrint(e.toString());
      _viewContract.onLoginFailed(e);
    });
  }

  Future<void> loginWithGoogle() => _repos.loginWithGoogle().then((user) {
        currentUser = user;
        _viewContract.onLoginSuccess(user);
      }).catchError((e) => _viewContract.onLoginFailed(e));
}
