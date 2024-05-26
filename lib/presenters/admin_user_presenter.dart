import 'package:flutter/foundation.dart';
import 'package:precious/data_sources/user_repository.dart';
import 'package:precious/models/user/user.dart';
import 'package:precious/presenters/page_presenter.dart';
import 'package:url_launcher/url_launcher_string.dart';

abstract class AdminUserContract {
  onInitSuccess();
  onInitFail();
  onRefreshSuccess();
  onRefreshFail();
  onStartAsyncFunction();
  onEndAsyncFunction();

  void onContactFail() {}
}

class AdminUserPresenter implements PagePresenter {
  @override
  List<int> selected = [];
  final AdminUserContract _contract;
  AdminUserPresenter(this._contract);
  String? searchParam;

  List<User> get userList => (searchParam == null || searchParam!.isEmpty)
      ? UserRepository.list.values.toList()
      : UserRepository.list.values
          .where((element) => element.id.toString() == searchParam)
          .toList();
  @override
  Future<bool> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> init() async {
    try {
      _contract.onStartAsyncFunction();
      await Future.wait([UserRepository.getAll()]);
    } catch (error) {
      debugPrint(error.toString());
      _contract.onInitFail();
    }
    _contract.onEndAsyncFunction();
  }

  @override
  Future<void> refresh() async {
    try {
      _contract.onStartAsyncFunction();
      UserRepository.list.clear();
      await Future.wait([UserRepository.getAll()]);
      _contract.onRefreshSuccess();
    } catch (error) {
      debugPrint(error.toString());
      _contract.onRefreshFail();
    } finally {
      _contract.onEndAsyncFunction();
    }
  }

  contactEmail(User user) {
    try {
      _contract.onStartAsyncFunction();

      if (user.email != null) {
        launchUrlString("mailto:${user.email!}");
      } else {
        throw Exception("User hasn't set have email.");
      }
    } catch (error) {
      debugPrint(error.toString());
      _contract.onContactFail();
    }
    _contract.onEndAsyncFunction();
  }

  contactPhoneNumber(User user) {
    try {
      _contract.onStartAsyncFunction();
      if (user.phoneNumber != null) {
        launchUrlString("tel://${user.phoneNumber!}");
      } else {
        throw Exception("User hasn't set have phoneNumber");
      }
    } catch (error) {
      debugPrint(error.toString());
      _contract.onContactFail();
    }
    _contract.onEndAsyncFunction();
  }
}
