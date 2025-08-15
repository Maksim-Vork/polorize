import 'package:polarize_app/features/Activity/domain/entity/activity.dart';
import 'package:polarize_app/features/Activity/domain/repository/activity_repository.dart';

class UpdateActivityUsecase {
  final ActivityRepository activityRepository;

  UpdateActivityUsecase({required this.activityRepository});

  Future<void> call() async {
    final DateTime now = DateTime.now();
    final DateTime nowFormatDate = DateTime(now.day, now.month, now.year);

    final Activity currentActivity = await activityRepository.getActivity();
    final DateTime yeasterDayDate = nowFormatDate.subtract(Duration(days: 1));
    int newSumActivityDays = currentActivity.sumActivityDays;
    DateTime? newLastDayActiv = currentActivity.lastDayActiv;

    final DateTime? lastSreakDay = currentActivity.lastDayActiv;
    if (lastSreakDay != null && lastSreakDay == yeasterDayDate) {
      newSumActivityDays += 1;
    } else {
      newLastDayActiv = nowFormatDate;
    }

    final Map<String, int> activityPhoto = currentActivity.photoActivity;
    if (activityPhoto.isEmpty) {
      activityPhoto.addAll({nowFormatDate.toString(): 1});
    } else {
      try {
        final String existingKey = activityPhoto.keys.firstWhere(
          (e) => e == nowFormatDate.toString(),
        );
        activityPhoto.update(existingKey, (value) => value + 1);
      } catch (e) {
        activityPhoto.addAll({nowFormatDate.toString(): 1});
      }

      await activityRepository.updateActivity(
        Activity(
          photoActivity: activityPhoto,
          sumActivityDays: newSumActivityDays,
          lastDayActiv: newLastDayActiv,
        ),
      );
    }
  }
}
