import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:kurs/cubit/registration/cubit.dart';
import 'package:kurs/data/api/auth_manager.dart';
import 'package:kurs/data/models/auth_response.dart';
import 'package:kurs/data/models/register.dart';
import 'package:kurs/data/temp_data.dart';
import 'package:kurs/ui/controllers.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationCubit() : super(RegistrationLoadedState());

  Future<void> register() async {
    emit(RegistrationLoadingState());
    try {
      var name = Controllers.registerNameController.text;
      var email = Controllers.registerEmailController.text;
      var password = Controllers.registerPasswordController.text;

      var register = Register(name:name, email: email, password: password);
      var response = await AuthManager.register(register);
      Map<String, dynamic> body = jsonDecode(response.body);
      if (response.statusCode < 299) {
        var authResp = Auth.fromJson(body);

        TempData.token = authResp.token!;
        TempData.refreshToken = authResp.refreshToken!;
      }
      emit(RegistrationAuthorizedState());
    } catch (error) {
      emit(RegistrationErrorState(error: error.toString()));
    }
  }
}