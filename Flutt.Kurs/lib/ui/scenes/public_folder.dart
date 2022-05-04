import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurs/cubit/public_folder/cubit.dart';

import '../widgets/public_folder_form.dart';

class PublicFolder extends StatelessWidget {
  const PublicFolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PublicFolderCubit,PublicFolderState>(
        builder: (context,state) {
          if(state is PublicFolderEmptyState){
            context.read<PublicFolderCubit>().load();
          }
          if(state is PublicFolderLoadingState){
            return const PublicFolderForm(loading: true,);
          }
          if(state is PublicFolderLoadedState){
            return const PublicFolderForm(loading: false);
          }
          return const PublicFolderForm(loading: true,);
        }
    );
  }
}
