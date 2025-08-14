import 'package:polarize_app/features/Auth/data/datasource/remote_auth_datasource.dart';
import 'package:polarize_app/features/Auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteAuthDatasource remoteAuthDatasource;

  AuthRepositoryImpl({required this.remoteAuthDatasource});
  @override
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    await remoteAuthDatasource.loginWithEmailAndPassword(email, password);
  }

  @override
  Future<void> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    await remoteAuthDatasource.registerWithEmailAndPassword(email, password);
  }

  @override
  Future<bool> checkAuth() async {
    return await remoteAuthDatasource.checkAuth();
  }

  @override
  Future<void> signOut() async {
    await remoteAuthDatasource.signOut();
  }
}
