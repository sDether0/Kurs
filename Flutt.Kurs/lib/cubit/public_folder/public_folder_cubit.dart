import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurs/cubit/public_folder/cubit.dart';
import 'package:kurs/data/api/public_folder.dart';
import 'package:kurs/data/models/file.dart';
import 'package:kurs/data/models/folder.dart';
import 'package:kurs/data/models/public_folder.dart';
import 'package:kurs/ui/controllers.dart';

class PublicFolderCubit extends Cubit<PublicFolderState> {
  PublicFolderCubit() : super(PublicFolderEmptyState());

  late List<MPublicFolder> mPFolders =[];
  MFolder? mFolder;
  String current = "";

  Future<void> load() async {
    emit(PublicFolderLoadingState());
    mPFolders=[];
    mFolder=null;
    var response = await PublicFolder.getPublicFolders();
    Map<String, dynamic> body = jsonDecode(response.body);
    List<Map<String, dynamic>> folders = ((body["data"] as List)
        .map((item) => item as Map<String, dynamic>)
        .toList());
    for (var data in folders) {
      var mpf = MPublicFolder(name: data["name"], id: data["guid"], data: data);
      mpf.mFolder.parent = mpf;
      mPFolders.add(mpf);
    }
    if(current.isNotEmpty){
      var mpf = mPFolders.firstWhere((element) => element.id==current.split("\\").first);
      mFolder  = mpf.mFolder.goToPath(current);
    }

    Future.delayed(const Duration(milliseconds: 10),
        () => emit(PublicFolderLoadedState()));
  }

  Future<void> changeFolder(IFolder? dest) async {
    emit(PublicFolderLoadingState());
    if (dest is MFolder) {
      mFolder = dest;
      current = dest.fullPath;
    }
    if(dest is MPublicFolder){
      mFolder = dest.mFolder;
      current = dest.mFolder.fullPath;
    }
    if(dest == null){
      mFolder = null;
      current = "";
    }
    Future.delayed(const Duration(milliseconds: 50),
        () => emit(PublicFolderLoadedState()));
  }

  Future<void> renameIO(IOElement io) async{
    emit(PublicFolderLoadingState());

    if(io is MFolder){
      await io.rename(nName:Controllers.fileRenameController.text);
    }

    Future.delayed(const Duration(milliseconds: 50),
            () => emit(PublicFolderLoadedState()));
  }

  Future<void> deleteIO(IOElement io) async{
    emit(PublicFolderLoadingState());

    if(io is MFile){

    }
    if(io is MFolder){

    }

    Future.delayed(const Duration(milliseconds: 50),
            () => emit(PublicFolderLoadedState()));
  }

  Future<void> saveFile(MFile file) async{
    emit(PublicFolderLoadingState());



    Future.delayed(const Duration(milliseconds: 50),
            () => emit(PublicFolderLoadedState()));
  }

  Future<void> refresh() async {
    emit(PublicFolderEmptyState());
  }
}
