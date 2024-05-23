import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:precious/data_sources/login_repository.dart';
import 'package:precious/models/user/user.dart' as model;
import 'package:precious/resources/endpoints.dart';
import 'package:precious/resources/utils/dio_utils.dart';

class UserRepository {
  static String? idToken;

  Future<model.User> getUser() async {
    try {
      idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
      var response = await dio.request(EndPoint.login,
          options: Options(
            method: 'POST',
            contentType: Headers.jsonContentType,
            receiveTimeout: const Duration(seconds: 15),
          ),
          data: {"idToken": idToken});
      if (response.statusCode != 201) {
        throw FirebaseAuthException(
            code: '${response.statusCode}: ${response.statusMessage}');
      } else {
        (response.data as Map<String, dynamic>).addAll({
          'name': FirebaseAuth.instance.currentUser!.displayName,
          'email': FirebaseAuth.instance.currentUser!.email
        });
        var user = model.User.fromJson(response.data);
        return user;
      }
    } on DioException catch (_) {
      throw FirebaseAuthException(code: 'REQUEST_TIME_OUT');
    }
  }

  Future<model.User> updateUser(model.User user) async {
    await FirebaseAuth.instance.currentUser!.updateDisplayName(user.name);
    var response = await dio.request(EndPoint.user,
        data: {
          'age': user.age,
          'gender': user.gender,
        },
        options: Options(
          method: 'PUT',
          contentType: Headers.jsonContentType,
        ));
    if (response.statusCode == 200) {
      return model.User.fromJson(response.data);
    } else {
      throw FirebaseAuthException(
          code: '${response.statusCode}: ${response.statusMessage}');
    }
  }
}
