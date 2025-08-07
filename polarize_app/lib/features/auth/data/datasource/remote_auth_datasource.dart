import 'package:firebase_auth/firebase_auth.dart';

class RemoteAuthDatasource {
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> checkAuth() async {
    final user = FirebaseAuth.instance.currentUser;
    final bool checkUser = user != null ? true : false;
    return checkUser;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
