import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polarize_app/core/Bloc/first_start_event.dart';
import 'package:polarize_app/core/Bloc/first_start_state.dart';
import 'package:polarize_app/core/Services/Locator/get_it.dart';
import 'package:polarize_app/core/Services/StoredLocalSettings/first_start_services.dart';

class StartBloc extends Bloc<CheckFirstStartEvent, StartState> {
  final FirstStartServices firstStartServices = getIt<FirstStartServices>();
  StartBloc() : super(InitialStartState()) {
    on<CheckFirstStartEvent>((event, emit) async {
      emit(LoadingStartState());
      try {
        final bool isFirstStart = await firstStartServices.isFirstStart();
        isFirstStart ? emit(FirstStartState()) : emit(NotFisrtStartState());
      } catch (e) {
        emit(ErrorStartState(error: e.toString()));
      }
    });
  }
}
