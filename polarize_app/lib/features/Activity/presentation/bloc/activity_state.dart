import 'package:equatable/equatable.dart';
import 'package:polarize_app/features/Activity/domain/entity/activity.dart';

abstract class ActivityState {}

class InitialActivityState extends ActivityState {}

class LoadingActivityState extends ActivityState {}

class LoadedActivityState extends ActivityState with EquatableMixin {
  final Activity activity;

  LoadedActivityState({required this.activity});

  @override
  List<Object?> get props => [activity];
}

class ErrorActivityState extends ActivityState {
  final String error;

  ErrorActivityState({required this.error});
}
