import 'package:polarize_app/features/Auth/domain/repository/auth_repository.dart';

class CheckAuthUsecase {
  final AuthRepository authRepository;

  CheckAuthUsecase({required this.authRepository});

  Future<bool> call() async {
    return await authRepository.checkAuth();
  }
}
