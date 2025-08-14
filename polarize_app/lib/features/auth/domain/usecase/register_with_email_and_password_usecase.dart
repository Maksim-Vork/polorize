import 'package:polarize_app/features/Auth/domain/repository/auth_repository.dart';

class RegisterWithEmailAndPasswordUsecase {
  final AuthRepository authRepository;

  RegisterWithEmailAndPasswordUsecase({required this.authRepository});
  Future<void> call(String email, String password) async {
    await authRepository.registerWithEmailAndPassword(email, password);
  }
}
