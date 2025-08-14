import 'package:polarize_app/features/Activity/domain/entity/activity.dart';
import 'package:polarize_app/features/Activity/domain/repository/activity_repository.dart';

class UpdateActivityUsecase {
  final ActivityRepository activityRepository;

  UpdateActivityUsecase({required this.activityRepository});

  Future<void> call() async {
    final Activity updateActivity = await activityRepository.getActivity();

    await activityRepository.updateActivity(updateActivity);
  }
}
