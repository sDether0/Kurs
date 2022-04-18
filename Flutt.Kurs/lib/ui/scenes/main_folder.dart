import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurs/cubit/main_folder/cubit.dart';
import 'package:kurs/ui/widgets/main_folder_form.dart';

class MainFolder extends StatelessWidget{
  const MainFolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainFolderCubit,MainFolderState>(
      builder: (context,state) {
        if(state is MainFolderEmptyState){
          context.read<MainFolderCubit>().load();
        }
        if(state is MainFolderLoadingState){
          return const MainFolderForm(loading: true);
        }
        if(state is MainFolderLoadedState){
          return const MainFolderForm(loading: false);
        }
        return Scaffold();
      }
    );
  }

}