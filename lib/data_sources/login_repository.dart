import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginRepository {
  Future<void> login(String email, String password) async {
    var auth = FirebaseAuth.instance;
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> loginWithGoogle() async {
    var googleSignIn = GoogleSignIn();

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
      await FirebaseAuth.instance.signInWithCredential(credential);

      await FirebaseAuth.instance.currentUser!
          .updateDisplayName(googleUser.displayName);
      await FirebaseAuth.instance.currentUser!
          .updatePhotoURL(googleUser.photoUrl);
    } else {
      // Throw an exception notify that sign up process was aborted
      throw FirebaseAuthException(code: 'sign-up-abort');
    }
  }
}
