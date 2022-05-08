import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurs/cubit/public_folder/cubit.dart';
import 'package:kurs/data/models/folder.dart';

class PublicFolderCubit extends Cubit<PublicFolderState>{
  PublicFolderCubit() : super(PublicFolderEmptyState());

  late List<MFolder> mFolder;

  Future<void> load()async{
    emit(PublicFolderLoadingState());



    Future.delayed(const Duration(milliseconds: 100),
            () => emit(PublicFolderLoadedState()));
  }
  Future<void> refresh() async {
    emit(PublicFolderEmptyState());
  }
}