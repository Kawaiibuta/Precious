import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:precious/resources/endpoints.dart';
import 'package:precious/resources/utils/dio_utils.dart';
import 'package:precious/data_sources/user/user.dart' as model;

class LoginRepository {
  static String idToken = '';

  Future<model.User> login(String email, String password) async {
    var auth = FirebaseAuth.instance;
    var credential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return await sendIdToken(await credential.user!.getIdToken());
  }

  Future<model.User> loginWithGoogle() async {
    var googleSignIn = GoogleSignIn();

    // // Logout the user to force the user to choose an account
    if (await googleSignIn.isSignedIn()) {
      await googleSignIn.signOut();
    }
    // Trigger the authentication flow
    var googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      // Obtain the auth details from the request
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      var credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in using the credential
      var userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Send id token to the server API
      return await sendIdToken(await userCredential.user!.getIdToken());
    } else {
      // Throw an exception notify that sign up process was aborted
      throw FirebaseAuthException(code: 'sign-up-abort');
    }
  }

  Future<void> logOut() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }

  Future<model.User> sendIdToken(String? idToken) async {
    try {
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
        var user = model.User.fromJson(response.data);
        LoginRepository.idToken = idToken!;
        return user;
      }
    } on DioException catch (e) {
      throw FirebaseAuthException(code: 'REQUEST_TIME_OUT');
    }
  }
}
