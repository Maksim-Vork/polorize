abstract class AuthRepository {
  Future<void> loginWithEmailAndPassword(String email, String password);
  Future<void> registerWithEmailAndPassword(String email, String password);
  Future<bool> checkAuth();
  Future<void> signOut();
}
