import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:kurs/cubit/login/cubit.dart';
import 'package:kurs/data/api/auth_manager.dart';
import 'package:kurs/data/temp_data.dart';
import 'package:kurs/ui/controllers.dart';

import '../../data/models/auth_response.dart';
import '../../data/models/login.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginLoadedState());

  Future<void> login() async {
    emit(LoginLoadingState());
    try {
      var email = Controllers.loginEmailController.text;
      var password = Controllers.loginPasswordController.text;

      var login = Login(email: email, password: password);
      var response = await AuthManager.login(login);
      Map<String,dynamic> body = jsonDecode(response.body);
      if(response.statusCode<299){

        var authResp = Auth.fromJson(body);

        TempData.token=authResp.token!;
        TempData.refreshToken=authResp.refreshToken!;
        emit(LoginAuthorizedState());
      }
      if(response.statusCode!=401){
        emit(LoginWrongDataState());
      }
      emit(LoginErrorState(error: "critical error"));
    } catch (error) {
      emit(LoginErrorState(error:error.toString()));
    }
  }
}
