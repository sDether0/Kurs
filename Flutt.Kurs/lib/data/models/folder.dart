import 'package:flutter/cupertino.dart';
import 'package:kurs/data/models/file.dart';
import 'package:kurs/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  MFolder.fromJson({required this.path, required this.name});

  factory MFolder.fromDataList(List<Map<String, dynamic>> dataList) {
    MFolder mFolder = MFolder(
        fullPath: "", level: 0, folds: List.empty(), paths: List.empty());
    for (var element in dataList) {
      if (element["path"].toString().split("\\").length == 1) {
        if(mFolder.path==""){
          var root = IOElement.fromJson(element);
          if (root is MFolder) {
            mFolder = root;
          }
        }
        continue;
      }
      var ioElement = IOElement.fromJson(element);

      if (ioElement is MFile) {
        var pathf = mFolder.goToPath(ioElement.path);

        ioElement.icon = ExtIcons.GetIcon(ioElement.ext);
        SharedPreferences.getInstance().then((value) {
          ioElement.localPath = value.getString(ioElement.fullPath);
          ioElement.downloaded = ioElement.localPath == null ? false : true;});
        pathf.files.add(ioElement);
        continue;
      }
      if (ioElement is MFolder) {
        var pathr = mFolder.goToPath(ioElement.path.replaceAll("\\"+ioElement.name,""));
        ioElement.parent = pathr;
        ioElement.icon= ExtIcons.GetIcon("f0lDeR");
        pathr.folders.add(ioElement);
        continue;
      }

    }

    return mFolder;
  }

  late MFolder? parent;
  late String path;
  late String name;
  late List<MFile> files = [];
  late List<MFolder> folders = [];
  late Icon icon = ExtIcons.GetIcon("f0lDeR");

  Future<void> rename(String newName) async {
    //todo
  }

  MFolder goToPath(String destPath) {
      if (destPath.contains(path)) {
        var spl = destPath.split("\\");
        var lvl = path.split("\\").length;
        var mfolder = this;
        for (int i = lvl; i < spl.length; i++) {
          mfolder = mfolder.folders.firstWhere((x) => x.name == spl[i]);
        }
        if (mfolder.path == destPath) {
          return mfolder;
        }
        return this;
      }
      return this;
  }
}
