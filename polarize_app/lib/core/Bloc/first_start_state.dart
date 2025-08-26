abstract class StartState {}

class InitialStartState extends StartState {}

class LoadingStartState extends StartState {}

class FirstStartState extends StartState {}

class NotFisrtStartState extends StartState {}

class ErrorStartState extends StartState {
  final String error;

  ErrorStartState({required this.error});
}
