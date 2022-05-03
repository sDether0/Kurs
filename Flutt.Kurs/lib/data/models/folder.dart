import 'package:flutter/cupertino.dart';
import 'package:kurs/data/models/file.dart';
import 'package:kurs/utils.dart';

class MFolder {
  MFolder(String fullPath, int level, List<String> paths) {
    path = fullPath;
    for (int i = 0; i < paths.length; i++) {
      List<String> firstPath = [];
      List<String> secondPath = [];
      List<Icon> firstIcon = [];
      List<Icon> secondIcon = [];
      for (int i = 0; i < paths.length; i++) {
        var path = paths[i];
        var secName = path.split("\\");
        if (folders.contains(path)) {
          folders.add(MFolder(paths[i], level+1, paths))
        } else {
          files.add(MFile(paths[i]));
        }
      }
    }
  }

  late String path;
  late List<MFile> files = [];
  late List<MFolder> folders = [];
  late Icon icon = ExtIcons.GetIcon("fOlDeR");
}
