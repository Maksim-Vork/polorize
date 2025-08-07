import 'package:polarize_app/features/auth/domain/repository/auth_repository.dart';

class AuthWithEmailAndPasswordUsecase {
  final AuthRepository authRepository;

  AuthWithEmailAndPasswordUsecase({required this.authRepository});
  Future<void> call(String email, String password) async {
    await authRepository.loginWithEmailAndPassword(email, password);
  }
}
