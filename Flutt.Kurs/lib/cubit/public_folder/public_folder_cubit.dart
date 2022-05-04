import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurs/cubit/public_folder/cubit.dart';

class PublicFolderCubit extends Cubit<PublicFolderState>{
  PublicFolderCubit() : super(PublicFolderEmptyState());


  Future<void> load()async{
    emit(PublicFolderLoadingState());






    Future.delayed(const Duration(milliseconds: 100),
            () => emit(PublicFolderLoadedState()));
  }
  Future<void> refresh() async {
    emit(PublicFolderEmptyState());
  }
}