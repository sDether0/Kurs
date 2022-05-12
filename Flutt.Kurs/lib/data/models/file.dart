import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kurs/data/api/files.dart';
import 'package:kurs/data/models/folder.dart';
import 'package:kurs/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MFile extends IOElement {
  MFile(String fullPath) {
    var spl = fullPath.split("\\");
    name = spl.last;
    ext = spl.last.split(".").last;
    shortName = name.replaceAll("." + ext, "");
    path = spl.where((element) => element != spl.last).join("\\");
    icon = ExtIcons.GetIcon(ext);
    //sPath = fullPath.replaceAll(fullPath.split("\\").first+"\\", "");
    SharedPreferences.getInstance().then((value) {
      localPath = value.getString(fullPath);
      downloaded = localPath == null ? false : true;
    });
  }

  MFile.fromJson(
      {required String path,
      required String name,
      required this.shortName,
      required this.ext}){
    this.path=path;
    this.name=name;
  }


  late String shortName;
  late Icon icon;
  late String ext;
  late String? localPath;
  bool downloaded = false;



  @override
  Future<void> download() async {
    var path = await getExternalStorageDirectory();
    var local = path!.path + "/" + name;

    if (!await File(local).exists()) {
      //print(fullPath);
      await Files.download(fullPath, local);
    }
    if (await File(local).exists()) {
      localPath = local;
      downloaded = true;
      var prefs = await SharedPreferences.getInstance();
      prefs.setString(fullPath, localPath!);
    }
  }

  Future<void> createFolder(String name) async
  {
    await Files.createRootFolder(name);
  }

  Future<void> deleteServer() async{

  }

  Future<void> deleteLocal() async {
    if (downloaded && await File(localPath!).exists()) {
      await File(localPath!).delete();
    }
    if (!await File(localPath!).exists()) {
      var prefs = await SharedPreferences.getInstance();
      prefs.remove(fullPath);
      localPath = null;
      downloaded = false;
    }
  }
}

abstract class IOElement {
  IOElement();

  late String name;
  late String path;
  String get fullPath => (path!=""?path + "\\":"")+ name;

  Future<void> rename({required String nName, String? ext = null}) async{
      String newName = nName+(ext??"");

      var response = await Files.rename(fullPath, path + "\\" + newName);
      var pathP = await getExternalStorageDirectory();
      var local = pathP!.path + "/" + name;

      if (response.statusCode < 299) {
        if (await File(local).exists()) {
          var file = this as MFile;
          file.downloaded = true;
          var prefs = await SharedPreferences.getInstance();
          prefs.remove(file.fullPath);
          name = newName;
          //print(fullPath);
          File(local).rename(pathP.path + "/" + newName);
          file.localPath = pathP.path + "/" + name;
          prefs.setString(fullPath, file.localPath!);
        }
      }
  }

  Future<void> download();

  static IOElement fromJson(Map<String, dynamic> data) {
    if (data["file"]) {
      return MFile.fromJson(
          path: data["shortPath"],
          name: data["name"],
          shortName: data["shortName"],
          ext: data["extension"]);
    }
    return MFolder.fromJson(fullPath: data["path"], name: data["name"]);
  }
}
