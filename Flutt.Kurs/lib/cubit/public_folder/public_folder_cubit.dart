import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurs/cubit/public_folder/cubit.dart';
import 'package:kurs/data/api/public_folder.dart';
import 'package:kurs/data/models/folder.dart';
import 'package:kurs/data/models/public_folder.dart';

class PublicFolderCubit extends Cubit<PublicFolderState>{
  PublicFolderCubit() : super(PublicFolderEmptyState());

  late Map<MPublicFolder,MFolder> mPFolders;
  MFolder? mFolder;

  Future<void> load()async{
    emit(PublicFolderLoadingState());

    var response = await PublicFolder.getPublicFolders();
    Map<String,dynamic> body = jsonDecode(response.body);
    List<Map<String,dynamic>> folders = body["data"];
    for(var data in folders){
      var mpf = MPublicFolder(name: data["name"], id: data["guid"], data: data );
      mPFolders[mpf] = mpf.mFolder;
    }

    Future.delayed(const Duration(milliseconds: 10),
            () => emit(PublicFolderLoadedState()));
  }
  Future<void> refresh() async {
    emit(PublicFolderEmptyState());
  }
}