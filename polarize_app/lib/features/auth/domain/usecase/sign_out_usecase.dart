import 'package:polarize_app/features/Auth/domain/repository/auth_repository.dart';

class SignOutUsecase {
  final AuthRepository authRepository;

  SignOutUsecase({required this.authRepository});
  Future<void> call() async {
    await authRepository.signOut();
  }
}
