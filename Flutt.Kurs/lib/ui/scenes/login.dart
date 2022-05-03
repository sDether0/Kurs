import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurs/cubit/login/cubit.dart';
import 'package:kurs/cubit/navigation/cubit.dart';
import 'package:kurs/resources/app_colors.dart';
import 'package:kurs/resources/app_strings.dart';
import 'package:kurs/ui/widgets/login_form.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      var _cubit = context.read<LoginCubit>();
      if (state is LoginLoadingState) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is LoginLoadedState) {
        return const Scaffold(
          backgroundColor: AppColors.primaryBackgroundColor,
          body: SafeArea(
            child: LoginForm(),
          ),
        );
      }
      if (state is LoginErrorState) {
        return AlertDialog(
          title: const Text(AppString.errorTitle),
          content: Text(state.error),
          actions: [
            TextButton(onPressed: () {}, child: const Text(AppString.accept))
          ],
        );
      }
      if (state is LoginEmptyState) {
        _cubit.tryLoad();
      }
      if (state is LoginAuthorizedState) {
        context.read<NavigationCubit>().pushToMainFolderScene();
      }
      if (state is LoginWrongDataState) {}
      return const SizedBox.shrink();
    });
  }
}
