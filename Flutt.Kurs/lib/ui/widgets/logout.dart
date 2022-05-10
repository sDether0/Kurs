import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurs/cubit/login/cubit.dart';
import 'package:kurs/ui/controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:kurs/cubit/navigation/navigation_cubit.dart';
import 'package:kurs/data/temp_data.dart';

class LogoutButton extends StatelessWidget
{
  const LogoutButton() : super();

  @override
  Widget build(BuildContext context) {
    return IconButton(icon: const Icon(
      Icons.logout,
      size: 25,
    ),
        onPressed: () async {
        var prefs = await SharedPreferences.getInstance();
        prefs.remove("token");
        prefs.remove("refreshToken");
        TempData.token = "";
        TempData.refreshToken = "";
        print(TempData.token);
        Controllers.loginPasswordController.clear();
        context.read<LoginCubit>().dropState();
        context.read<NavigationCubit>().pushToAuthScene();
        });
  }

}