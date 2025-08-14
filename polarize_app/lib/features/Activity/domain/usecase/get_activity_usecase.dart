import 'package:polarize_app/features/Activity/domain/entity/activity.dart';
import 'package:polarize_app/features/Activity/domain/repository/activity_repository.dart';

class GetActivityUsecase {
  final ActivityRepository activityRepository;

  GetActivityUsecase({required this.activityRepository});

  Future<Activity> call() async {
    final Activity myActivity = await activityRepository.getActivity();
    return myActivity;
  }
}
