import 'package:firebase_auth/firebase_auth.dart';

class SignUpRepository {
  Future<void> signUp(String username, String email, String password) async {
    var auth = FirebaseAuth.instance;
    await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    await auth.signInWithEmailAndPassword(email: email, password: password);
    await auth.currentUser!.updateDisplayName(username);
  }
}
