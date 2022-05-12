import 'package:flutter/cupertino.dart';
import 'package:kurs/data/api/files.dart';
import 'package:kurs/data/models/file.dart';
import 'package:kurs/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MFolder extends IOElement with IFolder{
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
              folds: folds.where((element) => element != path).toList(),
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

  MFolder.fromJson({required String fullPath, required String name}){
    var spl = fullPath.split("\\");
    path = spl.where((element) => element != spl.last).join("\\");
    this.name = name;
  }

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
        var pathr = mFolder.goToPath(ioElement.path);
        ioElement.parent = pathr;
        ioElement.icon= ExtIcons.GetIcon("f0lDeR");
        pathr.folders.add(ioElement);
        continue;
      }

    }

    return mFolder;
  }

  late IFolder? parent;
  late List<MFile> files = [];
  late List<MFolder> folders = [];
  late Icon icon = ExtIcons.GetIcon("f0lDeR");



  MFolder goToPath(String destPath) {
      if (destPath.contains(fullPath)) {
        var spl = destPath.split("\\");
        var lvl = fullPath.split("\\").length;
        var mfolder = this;
        for (int i = lvl; i < spl.length; i++) {
          mfolder = mfolder.folders.firstWhere((x) => x.name == spl[i]);
        }
        if (mfolder.fullPath == destPath) {
          return mfolder;
        }
        return this;
      }
      return this;
  }

  Future<void> deleteServer() async{

  }

  @override
  Future<void> download() async{
    var path = await getExternalStorageDirectory();
    var local = path!.path + "/" + name+".rar";
    Files.download(fullPath, local);

    var prefs = await SharedPreferences.getInstance();
    prefs.setString(fullPath+".rar", local);
  }

}

mixin IFolder{}