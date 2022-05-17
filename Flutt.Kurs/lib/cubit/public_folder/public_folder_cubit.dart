import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kurs/cubit/public_folder/cubit.dart';
import 'package:kurs/data/api/files.dart';
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

  Future<void> uploadFile() async {
    FilePickerResult? result =
    await FilePicker.platform.pickFiles(allowMultiple: true);
    String mPath = mFolder!.fullPath;
    if (result != null) {
      List<File> files =
      result.paths.map((path) => File(result.files.single.path!)).toList();
      for (int i = 0; i < result.files.length; i++) {
        await Files.upload(files[i], mPath);
      }
      refresh();
    } else {}
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

  Future<void> createPublicFolder(String name) async
  {
    emit(PublicFolderLoadingState());
    await PublicFolder.createPublicFolder(name);
    emit(PublicFolderEmptyState());

  }
  Future<void> createFolder() async {
    emit(PublicFolderEmptyState());
    //await file.createFolder("", Controllers.foldernameController.text);
    await Files.createPathFolder(
        mFolder!.fullPath, Controllers.publicFolderNameController.text);
    emit(PublicFolderEmptyState());
    // Future.delayed(
    //     const Duration(milliseconds: 10), () => emit(MainFolderLoadedState()));
  }
  Future<void> renameIO(IOElement io) async{
    emit(PublicFolderLoadingState());

    if (io is MFile) {
      await io.rename(nName : Controllers.fileRenameController.text,ext:
      Controllers.fileExtensionController.text);
    }
    if(io is MFolder){
      await io.rename(nName: Controllers.fileRenameController.text);
    }
    emit(PublicFolderEmptyState());
  }
  Future<void> deletePFolder(MPublicFolder folder) async
  {
    emit(PublicFolderLoadingState());
    await PublicFolder.deletePublicFolder(folder.id);
    emit(PublicFolderEmptyState());
  }
  Future<String> shareLink(MPublicFolder folder) async
  {
    var response = await PublicFolder.shareFolder(folder.id);
    var map = jsonDecode(response.body) as Map<String,dynamic>;
    String link = map["link"];
    await Clipboard.setData(ClipboardData(text: link));
    return link;
  }
  Future<void> renamePFolder(MPublicFolder folder) async
  {
    emit(PublicFolderLoadingState());
    await PublicFolder.renamePublicFolder(folder.id, Controllers.fileRenameController.text);
    emit(PublicFolderEmptyState());
  }
  Future<void> deleteIO(MFile file) async{
    emit(PublicFolderLoadingState());

    await file.deleteLocal();

    Future.delayed(const Duration(milliseconds: 50),
            () => emit(PublicFolderLoadedState()));
  }

  Future<void> deleteFromServer(IOElement io) async {
    emit(PublicFolderLoadingState());
    await io.deleteServer();
    emit(PublicFolderEmptyState());
  }

  Future<void> saveFile(IOElement io) async{
    emit(PublicFolderLoadingState());
    await io.download();
    if(io is MFile){
      Future.delayed(
          const Duration(milliseconds: 100), () => emit(PublicFolderLoadedState()));
    }
    if(io is MFolder){
      refresh();
    }
  }

  Future<void> refresh() async {
    emit(PublicFolderEmptyState());
  }
}
