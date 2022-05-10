import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:kurs/data/api/files.dart';
import 'package:kurs/data/models/file.dart';
import 'package:kurs/data/models/folder.dart';
import 'package:kurs/ui/controllers.dart';

import 'main_form_state.dart';

class MainFolderCubit extends Cubit<MainFolderState> {
  MainFolderCubit() : super(MainFolderEmptyState());

  List<String> fullPaths = [];
  List<String> folders = [];
  late MFolder mFolder;
  late MFolder rootFolder;
  String current = "";

  Future<void> downloadFile(MFile file) async {
    emit(MainFolderLoadingState());
    await file.download();
    Future.delayed(
        const Duration(milliseconds: 100), () => emit(MainFolderLoadedState()));
  }

  Future<void> deleteFile(MFile file) async {
    emit(MainFolderLoadingState());
    await file.deleteLocal();
    Future.delayed(
        const Duration(milliseconds: 100), () => emit(MainFolderLoadedState()));
  }

  Future<void> renameIO(IOElement io) async {
    emit(MainFolderLoadingState());
    if (io is MFile) {
      await io.rename(Controllers.fileRenameController.text,
          Controllers.fileExtensionController.text);
    }
    if(io is MFolder){
      await io.rename(Controllers.fileRenameController.text);
    }
    emit(MainFolderEmptyState());
    // Future.delayed(
    //     const Duration(milliseconds: 10), () => emit(MainFolderLoadedState()));
  }


  Future<void> load() async {
    emit(MainFolderLoadingState());

    var foldersResponse = await Files.getFilesPaths();

    if (foldersResponse.statusCode < 299) {
      Map<String, dynamic> body = jsonDecode(foldersResponse.body);
      folders = (body["data"] as List).map((item) => item as String).toList();

      var pathResponse = await Files.getFiles();
      if (pathResponse.statusCode < 299) {
        Map<String, dynamic> pathBody = jsonDecode(pathResponse.body);
        rootFolder = MFolder.fromDataList((pathBody["data"] as List)
            .map((item) => item as Map<String, dynamic>)
            .toList());
        mFolder = await rootFolder.goToPath(current);
        Future.delayed(const Duration(milliseconds: 100),
            () => emit(MainFolderLoadedState()));
        return;
      }
    }
    emit(MainFolderErrorState(error: ""));
  }

  Future<void> changeFolder(MFolder dest) async {
    emit(MainFolderLoadingState());

    mFolder = dest;
    current = dest.path;
    Future.delayed(
        const Duration(milliseconds: 100), () => emit(MainFolderLoadedState()));
  }

  Future<void> createFolder() async {
    emit(MainFolderLoadingState());
    //await file.createFolder("", Controllers.foldernameController.text);
    await Files.createPathFolder(
        mFolder.path, Controllers.foldernameController.text);
    emit(MainFolderEmptyState());
    // Future.delayed(
    //     const Duration(milliseconds: 10), () => emit(MainFolderLoadedState()));
  }

  Future<void> uploadFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);
    String mPath = mFolder.path;
    if (result != null) {
      List<File> files =
          result.paths.map((path) => File(result.files.single.path!)).toList();
      for (int i = 0; i < result.files.length; i++) {
        await Files.createFile(files[i], mPath);
      }
      refresh();
    } else {}
  }

  Future<void> refresh() async {
    emit(MainFolderEmptyState());
  }
}
