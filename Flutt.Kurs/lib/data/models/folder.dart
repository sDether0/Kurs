import 'package:flutter/cupertino.dart';
import 'package:kurs/data/models/file.dart';
import 'package:kurs/utils.dart';

class MFolder extends IOElement {
  MFolder(
      {required String fullPath,
      required int level,
      required List<String> folds,
      required List<String> paths,
      this.parent}) {
    path = fullPath;
    name = fullPath.split("\\").last;

    for (int i = 0; i < paths.length; i++) {
      var tpath = paths[i];
      if (tpath != this.path) {
        if (folds.contains(tpath) && tpath.split("\\").length == level + 2) {
          folders.add(MFolder(
              fullPath: paths[i],
              level: level + 1,
              folds: folds.where((element) => element != this.path).toList(),
              paths: paths.where((x) => x.contains(tpath)).toList(),
              parent: this));
        } else {
          if (tpath.split("\\").length == level + 2) {
            files.add(MFile(paths[i]));
          }
        }
      }
    }
  }

  late MFolder? parent;
  late String path;
  late String name;
  late List<MFile> files = [];
  late List<MFolder> folders = [];
  late Icon icon = ExtIcons.GetIcon("fOlDeR");

  Future<MFolder> goToPath(String destPath) async {
    if (destPath.contains(path)) {

      var spl = destPath.split("\\");
      var lvl = path.split("\\").length;
      var mfolder = this;
      for(int i = lvl;i<spl.length;i++){
          mfolder = mfolder.folders.firstWhere((x)=>x.name==spl[i]);
      }
      if(mfolder.path==destPath){
        return mfolder;
      }
      return this;
    }
    return this;
  }
}
