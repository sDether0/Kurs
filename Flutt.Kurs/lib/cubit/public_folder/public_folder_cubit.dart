import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurs/cubit/public_folder/cubit.dart';
import 'package:kurs/data/api/public_folder.dart';
import 'package:kurs/data/models/file.dart';
import 'package:kurs/data/models/folder.dart';
import 'package:kurs/data/models/public_folder.dart';

class PublicFolderCubit extends Cubit<PublicFolderState> {
  PublicFolderCubit() : super(PublicFolderEmptyState());

  late List<MPublicFolder> mPFolders;
  MFolder? mFolder;
  String current = "";

  Future<void> load() async {
    emit(PublicFolderLoadingState());

    var response = await PublicFolder.getPublicFolders();
    Map<String, dynamic> body = jsonDecode(response.body);
    List<Map<String, dynamic>> folders = body["data"];
    for (var data in folders) {
      var mpf = MPublicFolder(name: data["name"], id: data["guid"], data: data);
      mpf.mFolder.parent = mpf;
      mPFolders.add(mpf);
    }

    Future.delayed(const Duration(milliseconds: 10),
        () => emit(PublicFolderLoadedState()));
  }

  Future<void> changeFolder(IFolder? dest) async {
    emit(PublicFolderLoadingState());
    if (dest is MFolder) {
      mFolder = dest;
      current = dest.path;
    }
    if(dest is MPublicFolder){
      mFolder = dest.mFolder;
      current = dest.mFolder.path;
    }
    if(dest == null){
      mFolder = null;
      current = "";
    }
    Future.delayed(const Duration(milliseconds: 10),
        () => emit(PublicFolderLoadedState()));
  }

  Future<void> renameIO(IOElement io) async{

  }

  Future<void> deleteFile(IOElement io) async{

  }

  Future<void> downloadFile(MFile file) async{

  }

  Future<void> refresh() async {
    emit(PublicFolderEmptyState());
  }
}
