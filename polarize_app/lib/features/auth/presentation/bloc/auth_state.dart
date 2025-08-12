abstract class AuthState {}

class InitialAuthState extends AuthState {}

class LoadingAuthState extends AuthState {}

class SuccesAuthState extends AuthState {}

class NotSuccesAuthState extends AuthState {}

class ErrorAuthState extends AuthState {
  final String error;

  ErrorAuthState({required this.error});
}
