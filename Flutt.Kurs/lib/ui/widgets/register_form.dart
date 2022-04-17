import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurs/cubit/registration/cubit.dart';
import 'package:kurs/resources/app_strings.dart';
import 'package:kurs/ui/controllers.dart';
import 'package:kurs/ui/widgets/text_button.dart';
import 'package:kurs/ui/widgets/text_field.dart';

import '../../cubit/login/login_cubit.dart';
import '../../cubit/navigation/navigation_cubit.dart';

class RegistrationForm extends StatelessWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: SizedBox(
          height: size.height * 0.45,
          width: size.width * 0.8,
          child: Card(
            color: Colors.black87,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(color: Colors.purple, width: 2)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(children: [
                    CustomTextField(
                        textController: Controllers.registerNameController,
                        obscure: false,
                        hint: "Name"),
                    const SizedBox(height: 12),
                    CustomTextField(
                        textController: Controllers.registerEmailController,
                        obscure: false,
                        hint: "E-Mail"),
                    const SizedBox(height: 12),
                    CustomTextField(
                        textController: Controllers.registerPasswordController,
                        obscure: true,
                        hint: "Password"),
                  ]),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomTextButton(
                          text: AppString.cancelButton,
                          func: (){}),
                      CustomTextButton(
                          text: AppString.registerButton,
                          func: context.read<RegistrationCubit>().register)
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
