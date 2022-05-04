import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:kurs/data/api/files.dart';
import 'package:kurs/data/models/file.dart';
import 'package:kurs/data/models/folder.dart';

import 'main_form_state.dart';

class MainFolderCubit extends Cubit<MainFolderState> {
  MainFolderCubit() : super(MainFolderEmptyState());

  List<String> fullPaths = [];
  List<String> folders = [];
  late MFolder mFolder;
  late MFolder rootFolder;
  String current="";

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

  Future<void> load() async {
    emit(MainFolderLoadingState());

    var foldersResponse = await Files.getFilesPaths();

    if (foldersResponse.statusCode < 299) {
      Map<String, dynamic> body = jsonDecode(foldersResponse.body);
      folders = (body["data"] as List).map((item) => item as String).toList();

      var pathResponse = await Files.getFiles();
      if (pathResponse.statusCode < 299) {
        Map<String, dynamic> pathBody = jsonDecode(pathResponse.body);
        fullPaths =
            (pathBody["data"] as List).map((item) => item as String).toList();

        rootFolder = MFolder(
            fullPath: folders.first.split("\\").first,
            level: 0,
            folds: folders,
            paths: fullPaths,
            parent: null);
        print(current);
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

  Future<void> renameFolder(int index) async {}

  Future<void> uploadFile() async {

    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
    String mPath = mFolder.path;
    if (result != null) {
      List<File> files = result.paths.map((path) => File(result.files.single.path!)).toList();
      for(int i = 0;i<result.files.length;i++) {

        await Files.createFile(files[i],mPath);
      }
    } else {}
  }

  Future<void> refresh() async {
    emit(MainFolderEmptyState());
  }
}
