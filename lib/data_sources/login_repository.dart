import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:precious/data_sources/user_repository.dart';
import 'package:precious/data_sources/user/user.dart' as model;
import 'package:precious/data_sources/auth_repository.dart';

class LoginRepository {
  Future<model.User> login(String email, String password) async {
    var auth = FirebaseAuth.instance;
    var credential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return (await AuthRepository.updateCurrentUser())!;
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
      return (await AuthRepository.updateCurrentUser())!;
    } else {
      // Throw an exception notify that sign up process was aborted
      throw FirebaseAuthException(code: 'sign-up-abort');
    }
  }

  Future<void> logOut() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
  }
}
