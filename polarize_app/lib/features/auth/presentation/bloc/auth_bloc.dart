import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polarize_app/features/Activity/presentation/bloc/activity_bloc.dart';
import 'package:polarize_app/features/Activity/presentation/bloc/activity_event.dart';
import 'package:polarize_app/features/Auth/domain/usecase/check_auth_usecase.dart';
import 'package:polarize_app/features/Auth/domain/usecase/login_with_email_and_password_usecase.dart';
import 'package:polarize_app/features/Auth/domain/usecase/register_with_email_and_password_usecase.dart';
import 'package:polarize_app/features/Auth/domain/usecase/sign_out_usecase.dart';
import 'package:polarize_app/features/Auth/presentation/bloc/auth_event.dart';
import 'package:polarize_app/features/Auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CheckAuthUsecase checkAuthUsecase;
  final LoginWithEmailAndPasswordUsecase loginWithEmailAndPasswordUsecase;
  final RegisterWithEmailAndPasswordUsecase registerWithEmailAndPasswordUsecase;
  final SignOutUsecase signOutUsecase;
  final ActivityBloc activityBloc;
  AuthBloc(
    this.checkAuthUsecase,
    this.loginWithEmailAndPasswordUsecase,
    this.registerWithEmailAndPasswordUsecase,
    this.signOutUsecase,
    this.activityBloc,
  ) : super(InitialAuthState()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<ChechAuthEvent>(_onCheck);
    on<SignOutEvent>(_onSignOut);
  }

  void _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(LoadingAuthState());
    try {
      await loginWithEmailAndPasswordUsecase(event.email, event.password);
      emit(SuccesAuthState());
    } catch (e) {
      emit(ErrorAuthState(error: e.toString()));
    }
  }

  void _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(LoadingAuthState());
    try {
      await registerWithEmailAndPasswordUsecase(event.email, event.password);
      activityBloc.add(CreateActivityForNewUserEvent());
      emit(SuccesAuthState());
    } catch (e) {
      emit(ErrorAuthState(error: e.toString()));
    }
  }

  void _onCheck(ChechAuthEvent event, Emitter<AuthState> emit) async {
    try {
      final bool authUser = await checkAuthUsecase();
      if (authUser) {
        emit(SuccesAuthState());
      } else {
        emit(NotSuccesAuthState());
      }
    } catch (e) {
      emit(ErrorAuthState(error: e.toString()));
    }
  }

  void _onSignOut(SignOutEvent event, Emitter<AuthState> emit) async {
    try {
      await signOutUsecase();
      emit(NotSuccesAuthState());
    } catch (e) {
      emit(ErrorAuthState(error: e.toString()));
    }
  }
}
