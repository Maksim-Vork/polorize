import 'package:polarize_app/features/Activity/domain/entity/activity.dart';

abstract class ActivityRepository {
  Future<void> createActivityForNewUser();
  Future<Activity> getActivity();
  Future<void> updateActivity(Activity updateActivity);
}
