import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:precious/data_sources/login_repository.dart';

abstract class LoginPageContract {
  void onLoginSuccess();
  void onLoginFailed(FirebaseException e);
}

class LoginPresenter {
  final LoginPageContract _viewContract;
  final LoginRepository _repos = LoginRepository();

  LoginPresenter(this._viewContract);

  Future<void> login(String email, String password) async {
    await _repos
        .login(email, password)
        .then((_) => _viewContract.onLoginSuccess())
        .catchError((e) {
      debugPrint(e.toString());
      _viewContract.onLoginFailed(e);
    });
  }

  Future<void> loginWithGoogle() => _repos
      .loginWithGoogle()
      .then((_) => _viewContract.onLoginSuccess())
      .catchError((e) => _viewContract.onLoginFailed(e));
}
