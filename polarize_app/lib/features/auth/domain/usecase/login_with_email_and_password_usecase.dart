import 'package:polarize_app/features/auth/domain/repository/auth_repository.dart';

class LoginWithEmailAndPasswordUsecase {
  final AuthRepository authRepository;

  LoginWithEmailAndPasswordUsecase({required this.authRepository});
  Future<void> call(String email, String password) async {
    await authRepository.loginWithEmailAndPassword(email, password);
  }
}
