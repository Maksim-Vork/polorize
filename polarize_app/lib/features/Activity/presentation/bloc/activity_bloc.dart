import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polarize_app/core/Services/Locator/get_it.dart';
import 'package:polarize_app/features/Activity/domain/entity/activity.dart';
import 'package:polarize_app/features/Activity/domain/usecase/create_activity_for_new_user_usecase.dart';
import 'package:polarize_app/features/Activity/domain/usecase/get_activity_usecase.dart';
import 'package:polarize_app/features/Activity/domain/usecase/update_activity_usecase.dart';
import 'package:polarize_app/features/Activity/presentation/bloc/activity_event.dart';
import 'package:polarize_app/features/Activity/presentation/bloc/activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final GetActivityUsecase getActivityUsecase = getIt<GetActivityUsecase>();
  final CreateActivityForNewUserUsecase createActivityForNewUserUsecase =
      getIt<CreateActivityForNewUserUsecase>();
  final UpdateActivityUsecase updateActivityUsecase =
      getIt<UpdateActivityUsecase>();
  ActivityBloc() : super(InitialActivityState()) {
    on<GetActivityEvent>(_onGetActivity);
    on<CreateActivityForNewUserEvent>(_onCreateActivity);
    on<UpdateActivityEvent>(_onUpdateActivity);
    on<ResetActivityEvent>(_onResetActivity);
  }

  void _onGetActivity(
    GetActivityEvent event,
    Emitter<ActivityState> emit,
  ) async {
    emit(LoadingActivityState());
    try {
      final Activity activity = await getActivityUsecase();
      emit(LoadedActivityState(activity: activity));
    } catch (e) {
      emit(ErrorActivityState(error: e.toString()));
    }
  }

  void _onCreateActivity(
    CreateActivityForNewUserEvent event,
    Emitter<ActivityState> emit,
  ) async {
    emit(LoadingActivityState());
    try {
      await createActivityForNewUserUsecase();
      final Activity activity = await getActivityUsecase();
      emit(LoadedActivityState(activity: activity));
    } catch (e) {
      emit(ErrorActivityState(error: e.toString()));
    }
  }

  void _onUpdateActivity(
    UpdateActivityEvent event,
    Emitter<ActivityState> emit,
  ) async {
    emit(LoadingActivityState());
    try {
      await updateActivityUsecase();
      final Activity activity = await getActivityUsecase();
      emit(LoadedActivityState(activity: activity));
    } catch (e) {
      emit(ErrorActivityState(error: e.toString()));
    }
  }

  void _onResetActivity(
    ResetActivityEvent event,
    Emitter<ActivityState> emit,
  ) async {
    emit(InitialActivityState());
    try {
      final Activity activity = await getActivityUsecase();
      emit(LoadedActivityState(activity: activity));
    } catch (e) {
      emit(ErrorActivityState(error: e.toString()));
    }
  }
}
