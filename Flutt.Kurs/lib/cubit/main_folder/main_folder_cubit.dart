import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:kurs/data/api/files.dart';
import 'package:kurs/ui/styles/app_text_styles.dart';
import 'package:kurs/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_form_state.dart';

class MainFolderCubit extends Cubit<MainFolderState> {
  MainFolderCubit() : super(MainFolderEmptyState());

  List<String> fullPaths = List.empty();
  List<String> folders = [];
  List<String> paths = [];
  List<Icon> icons = [];
  Map<String,String> localPaths={};
  late SharedPreferences prefs;

  Future<void> loadIcons() async {
    List<String> firstPath = [];
    List<String> secondPath =[];
    List<Icon> firstIcon = [];
    List<Icon> secondIcon = [];
    for (int i = 0; i < fullPaths.length; i++) {
      var path = fullPaths[i];
      var secName = path.split("\\");
      if (folders.contains(path)) {
        var name = secName[1];
        var icon = ExtIcons.GetIcon("fOlDeR");
        firstIcon.add(icon);
        firstPath.add(name);
      }
      else {
        var name = secName[1];
        var icon = ExtIcons.GetIcon(secName[1].split(".").last);
        secondIcon.add(icon);
        secondPath.add(name);
      }
    }
    prefs = await SharedPreferences.getInstance();
    var locals = prefs.getString("localPaths");
    if(locals!=null){
      localPaths = Map<String,String>.from(jsonDecode(locals));
      print(localPaths);
    }
    paths=firstPath+secondPath;
    icons=firstIcon+secondIcon;

    emit(MainFolderLoadedState());
  }
  Future<void> downloadFile(int index) async{
    emit(MainFolderLoadingState());
    var path = await getExternalStorageDirectory();
    var local = path!.path+"/"+paths[index];

    if(!await File(local).exists()){
    await Files.getFile(paths[index], local);
    }
    if(await File(local).exists()){
      localPaths[index.toString()] = local;
      prefs = await SharedPreferences.getInstance();
      prefs.setString("localPaths", jsonEncode(localPaths));
    }
    emit(MainFolderLoadedState());
  }
  Future<void> deleteFile(int index) async{
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


        await loadIcons();
        return;
      }
    }
    emit(MainFolderErrorState(error: ""));
  }

  Future<void> renameFolder(int index) async{
    var path = paths[index];

  }
}
