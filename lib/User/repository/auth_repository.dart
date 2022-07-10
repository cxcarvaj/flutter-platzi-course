import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_auth_api.dart';

class AuthRepository {
  final _firebaseAuthAPI = FirebaseAuthAPI();

  Future<UserCredential> signInFirebase() =>
      _firebaseAuthAPI.signInWithGoogle();

  void signOut() => _firebaseAuthAPI.signOutWithGoogle();
}
