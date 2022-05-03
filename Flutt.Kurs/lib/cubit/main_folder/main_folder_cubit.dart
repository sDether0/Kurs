import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kurs/data/api/files.dart';
import 'package:kurs/data/models/file.dart';
import 'package:kurs/data/models/folder.dart';
import 'package:kurs/ui/styles/app_text_styles.dart';
import 'package:kurs/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_form_state.dart';

class MainFolderCubit extends Cubit<MainFolderState> {
  MainFolderCubit() : super(MainFolderEmptyState());

  List<String> fullPaths = [];
  List<String> folders = [];
  List<String> paths = [];
  List<Icon> icons = [];
  Map<String,String> localPaths={};
  late SharedPreferences prefs;
  String path="";
  int level=1;
  late MFolder mFolder;
  late MFolder rootFolder;

  Future<void> loadIcons() async {


    emit(MainFolderLoadedState());
  }
  Future<void> downloadFile(MFile file) async{
    emit(MainFolderLoadingState());
    file.download();
    emit(MainFolderLoadedState());
  }
  Future<void> deleteFile(MFile file) async{
    emit(MainFolderLoadingState());

    emit(MainFolderLoadedState());
  }

  Future<void> load() async {
    emit(MainFolderLoadingState());
    AppTextStyles.h4.getColor();
    var foldersResponse = await Files.getFilesPaths();

    if (foldersResponse.statusCode < 299) {
      Map<String, dynamic> body = jsonDecode(foldersResponse.body);
      folders = (body["data"] as List).map((item) => item as String).toList();


      var pathResponse = await Files.getFiles();
      if (pathResponse.statusCode < 299) {
        Map<String, dynamic> pathBody = jsonDecode(pathResponse.body);
        fullPaths = (pathBody["data"] as List).map((item) => item as String).toList();

        mFolder = MFolder(fullPath : folders.first.split("\\").first, level:0, folds:folders, paths:fullPaths);
        rootFolder = MFolder(fullPath : folders.first.split("\\").first, level:0, folds:folders, paths:fullPaths);
        emit(MainFolderLoadedState());
        return;
      }
    }
    emit(MainFolderErrorState(error: ""));
  }

  Future<void> changeFolder(MFolder dest) async {
    emit(MainFolderLoadingState());
    mFolder = dest;
    emit(MainFolderLoadedState());
  }

  Future<void> renameFolder(int index) async{
    var path = paths[index];

  }

  Future<void> refresh() async {
    emit(MainFolderEmptyState());
  }
}
