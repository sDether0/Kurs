import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:kurs/utils.dart';
import 'main_form_state.dart';

class MainFolderCubit extends Cubit<MainFolderState> {
  MainFolderCubit() : super(MainFolderEmptyState());

  List<String> fullpaths = List.empty();
  List<String> paths = [];
  List<Icon> icons = [];

  Future<void> LoadIcons() async {
    for (int i = 0; i < fullpaths.length; i++) {
      var path = fullpaths[i];
      var name = path.split("/").last;
      var icon = ExtIcons.GetIcon(name.split(".").last);
      icons.add(icon);
      paths.add(name);
    }
    emit(MainFolderLoadedState());
  }

  Future<void> load() async {
    emit(MainFolderLoadingState());

    await LoadIcons();
  }
}
