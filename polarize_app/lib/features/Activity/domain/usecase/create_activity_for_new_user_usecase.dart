import 'package:polarize_app/features/Activity/domain/repository/activity_repository.dart';

class CreateActivityForNewUserUsecase {
  final ActivityRepository activityRepository;

  CreateActivityForNewUserUsecase({required this.activityRepository});

  Future<void> call() async {
    await activityRepository.createActivityForNewUser();
  }
}
