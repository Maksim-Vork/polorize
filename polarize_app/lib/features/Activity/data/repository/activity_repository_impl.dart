import 'package:polarize_app/features/Activity/data/datasource/remote_activity_data.dart';
import 'package:polarize_app/features/Activity/data/model/activity_model.dart';
import 'package:polarize_app/features/Activity/domain/entity/activity.dart';
import 'package:polarize_app/features/Activity/domain/repository/activity_repository.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  final RemoteActivityData remoteActivityData;

  ActivityRepositoryImpl({required this.remoteActivityData});
  @override
  Future<void> createActivityForNewUser() async {
    final ActivityModel activityModel = ActivityModel();
    await remoteActivityData.createActivityForNewUser(activityModel);
  }

  @override
  Future<Activity> getActivity() async {
    final ActivityModel activity = await remoteActivityData.getActivity();
    return Activity(
      photoActivity: activity.photoActivity!,
      sumActivityDays: activity.sumActivityDays!,
      lastDayActiv: activity.lastDayActiv,
    );
  }

  @override
  Future<void> updateActivity(Activity updateActivity) async {
    final ActivityModel activityModel = ActivityModel(
      photoActivity: updateActivity.photoActivity as Map<String, int>,
      sumActivityDays: updateActivity.sumActivityDays,
      lastDayActiv: updateActivity.lastDayActiv,
    );
    await remoteActivityData.updateActivity(activityModel);
  }
}
