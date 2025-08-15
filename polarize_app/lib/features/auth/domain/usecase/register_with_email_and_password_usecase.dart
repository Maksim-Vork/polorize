import 'package:polarize_app/features/Activity/domain/repository/activity_repository.dart';
import 'package:polarize_app/features/Auth/domain/repository/auth_repository.dart';

class RegisterWithEmailAndPasswordUsecase {
  final AuthRepository authRepository;
  final ActivityRepository activityRepository;

  RegisterWithEmailAndPasswordUsecase({
    required this.authRepository,
    required this.activityRepository,
  });

  Future<void> call(String email, String password) async {
    await authRepository.registerWithEmailAndPassword(email, password);
    await activityRepository.createActivityForNewUser();
  }
}
