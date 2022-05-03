import 'package:flutter/cupertino.dart';
import 'package:kurs/data/models/file.dart';
import 'package:kurs/utils.dart';

class MFolder extends IOElement{
  MFolder({required String fullPath, required int level,required List<String> folds, required List<String> paths, MFolder? parent}) {
    path = fullPath;
      for (int i = 0; i < paths.length; i++) {
        var path = paths[i];
        var secName = path.split("\\")[level];
        if (folds.contains(path)) {
          folders.add(MFolder(fullPath:  paths[i],level:  level+1,folds: folds,paths: paths.where((x)=>x.split("\\")[level]==secName).toList(),parent: this));
        } else {
          files.add(MFile(paths[i]));
        }
      }
  }

  late MFolder? parent;
  late String path;
  late List<MFile> files = [];
  late List<MFolder> folders = [];
  late Icon icon = ExtIcons.GetIcon("fOlDeR");
}
