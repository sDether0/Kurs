import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurs/cubit/registration/cubit.dart';

import '../widgets/register_form.dart';

class Registration extends StatelessWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
        builder: (context, state) {
      if (state is RegistrationLoadingState) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is RegistrationLoadedState) {
        return const  Scaffold(
          backgroundColor: Colors.deepPurple,
          body: SafeArea(child: RegistrationForm()),
        );
      }

      return const Scaffold();
    });
  }
}
