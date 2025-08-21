import 'package:polarize_app/features/Activity/domain/entity/activity.dart';
import 'package:polarize_app/features/Activity/domain/repository/activity_repository.dart';

class UpdateActivityUsecase {
  final ActivityRepository activityRepository;

  UpdateActivityUsecase({required this.activityRepository});

  Future<void> call() async {
    final DateTime now = DateTime.now();
    final DateTime nowFormatDate = DateTime(now.year, now.month, now.day);

    final Activity currentActivity = await activityRepository.getActivity();
    final DateTime yeasterDayDate = nowFormatDate.subtract(
      const Duration(days: 1),
    );
    int newSumActivityDays = currentActivity.sumActivityDays;
    DateTime? newLastDayActiv = currentActivity.lastDayActiv;

    final DateTime? lastSreakDay = currentActivity.lastDayActiv;
    if (lastSreakDay != null && lastSreakDay == yeasterDayDate) {
      newSumActivityDays += 1;
    } else {
      newLastDayActiv = nowFormatDate;
    }

    final Map<DateTime, int> activityPhoto = Map.from(
      currentActivity.photoActivity,
    );

    if (activityPhoto.isEmpty) {
      activityPhoto[nowFormatDate] = 1;
    } else {
      if (activityPhoto.containsKey(nowFormatDate)) {
        activityPhoto[nowFormatDate] = activityPhoto[nowFormatDate]! + 1;
      } else {
        activityPhoto[nowFormatDate] = 1;
      }
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
