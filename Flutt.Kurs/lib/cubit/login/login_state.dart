abstract class LoginState {}

class LoginLoadingState extends LoginState {}

class LoginEmptyState extends LoginState{}

class LoginLoadedState extends LoginState {}

class LoginWrongDataState extends LoginState{}

class LoginAuthorizedState extends LoginState{}

class LoginErrorState extends LoginState {
  String error;

  LoginErrorState({required this.error});
}