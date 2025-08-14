import 'package:polarize_app/features/Activity/domain/entity/activity.dart';

abstract class ActivityState {}

class InitialActivityState extends ActivityState {}

class LoadingActivityState extends ActivityState {}

class LoadedActivityState extends ActivityState {
  final Activity activity;

  LoadedActivityState({required this.activity});
}

class ErrorActivityState extends ActivityState {
  final String error;

  ErrorActivityState({required this.error});
}
