import 'package:firebase_auth/firebase_auth.dart' as FBAuth;
import 'package:precious/data_sources/auth_repository.dart';

class SignUpRepository {
  Future<void> signUp(String username, String email, String password) async {
    var auth = FBAuth.FirebaseAuth.instance;
    await auth.createUserWithEmailAndPassword(email: email, password: password);
    await auth.signInWithEmailAndPassword(email: email, password: password);
    await AuthRepository.updateCurrentUser();
    await auth.currentUser!.updateDisplayName(username);
  }
}
