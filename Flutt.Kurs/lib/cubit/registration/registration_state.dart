abstract class RegistrationState {}

class RegistrationLoadingState extends RegistrationState {}

class RegistrationEmptyState extends RegistrationState{}

class RegistrationLoadedState extends RegistrationState {}

class RegistrationWrongDataState extends RegistrationState{}

class RegistrationAuthorizedState extends RegistrationState{}

class RegistrationErrorState extends RegistrationState {
  String error;

  RegistrationErrorState({required this.error});
}