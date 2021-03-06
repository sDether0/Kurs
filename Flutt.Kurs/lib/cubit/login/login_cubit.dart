import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:kurs/cubit/login/cubit.dart';
import 'package:kurs/data/api/auth_manager.dart';
import 'package:kurs/data/temp_data.dart';
import 'package:kurs/ui/controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/auth_response.dart';
import '../../data/models/login.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginEmptyState());

  late SharedPreferences prefs;

  Future<void> login() async {
    emit(LoginLoadingState());
    try {
      var email = Controllers.loginEmailController.text;
      var password = Controllers.loginPasswordController.text;

      var login = Login(email: email, password: password);
      var response = await AuthManager.login(login);
      Map<String, dynamic> body = jsonDecode(response.body);
      if (response.statusCode < 299) {
        var authResp = Auth.fromJson(body);

        TempData.token = authResp.token!;
        TempData.refreshToken = authResp.refreshToken!;
        prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", authResp.token!);
        await prefs.setString("refreshToken", authResp.refreshToken!);
        emit(LoginAuthorizedState());
      } else {
        if (response.statusCode != 401) {
          emit(LoginWrongDataState());
        }
        emit(LoginErrorState(error: "critical error"));
      }
    } catch (error) {
      emit(LoginErrorState(error: error.toString()));
    }
  }
  Future<void> dropState() async{
    emit(LoginEmptyState());
  }
  Future<void> tryLoad() async {
    prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var refreshToken = prefs.getString("refreshToken");
    if(token!=null && refreshToken!=null){
    TempData.token = token;
    TempData.refreshToken = refreshToken;
    emit(LoginAuthorizedState());
    return;
    }
    emit(LoginLoadedState());
  }
}
