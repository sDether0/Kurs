import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurs/cubit/login/cubit.dart';
import 'package:kurs/cubit/public_folder/cubit.dart';
import 'package:kurs/cubit/registration/cubit.dart';
import 'package:kurs/ui/app_navigator.dart';
import 'package:kurs/utils.dart';

import 'cubit/main_folder/main_folder_cubit.dart';
import 'cubit/navigation/navigation_cubit.dart';

void main() {
    HttpOverrides.global = DevHttpOverrides();
    runApp(const Starter());
}

class Starter extends StatelessWidget {
  const Starter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PublicFolderCubit>(create: (context) => PublicFolderCubit()),
        BlocProvider<MainFolderCubit>(create: (context) => MainFolderCubit()),
        BlocProvider<RegistrationCubit>(create: (context) => RegistrationCubit()),
        BlocProvider<LoginCubit>(create: (context) => LoginCubit()),
        BlocProvider<NavigationCubit>(create: (context) => NavigationCubit()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: AppNavigator(),
        ),
      ),
    );
  }
}
