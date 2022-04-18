import 'package:bloc/bloc.dart';
import 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState>{
  NavigationCubit() : super(NavigationLoginState());

  void pushToAuthScene() => emit(NavigationLoginState());

  void pushToMainFolderScene() => emit(NavigationMainFolderState());

  void pushToNewsScene() => emit(NavigationNewsState());

  void pushToProfileScene() => emit(NavigationProfileState());

  void pushToRegistrationScene() => emit(NavigationRegistrationState());

}