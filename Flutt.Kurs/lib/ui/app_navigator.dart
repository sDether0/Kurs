import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurs/cubit/navigation/cubit.dart';
import 'package:kurs/ui/scenes/login.dart';
import 'package:kurs/ui/scenes/main_folder.dart';
import 'package:kurs/ui/scenes/registration.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
      return Navigator(
        pages: [
          if (state is NavigationLoginState)
            const MaterialPage(child: Login()),
          if (state is NavigationRegistrationState)
            const MaterialPage(child: Registration()),
          if(state is NavigationMainFolderState)
            const MaterialPage(child: MainFolder())
        ],
        onPopPage: (route, result) {
          return route.didPop(result);
        },
      );
    });
  }
}
