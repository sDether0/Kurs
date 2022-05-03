import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurs/resources/app_colors.dart';
import 'package:kurs/resources/app_strings.dart';
import 'package:kurs/ui/controllers.dart';
import 'package:kurs/ui/widgets/text_button.dart';
import 'package:kurs/ui/widgets/text_field.dart';

import '../../cubit/login/login_cubit.dart';
import '../../cubit/navigation/navigation_cubit.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: SizedBox(
          height: size.height * 0.35,
          width: size.width * 0.8,
          child: Card(
            color: AppColors.itemPlateColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(color: AppColors.borderColor, width: 2)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(children: [
                    CustomTextField(
                        textController: Controllers.loginEmailController,
                        obscure: false,
                        hint: "E-Mail"),
                    const SizedBox(height: 12),
                    CustomTextField(
                        textController: Controllers.loginPasswordController,
                        obscure: true,
                        hint: "Password"),
                  ]),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomTextButton(
                          text: AppString.loginButton,
                          func: context.read<LoginCubit>().login),
                      CustomTextButton(
                          text: AppString.registerButton,
                          func: context
                              .read<NavigationCubit>()
                              .pushToRegistrationScene)
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
