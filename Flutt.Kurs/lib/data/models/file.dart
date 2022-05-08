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
      {required this.path,
      required this.name,
      required this.shortName,
      required this.ext}){
  }

  late String name;
  late String path;
  late String shortName;
  late Icon icon;
  late String ext;
  late String? localPath;
  bool downloaded = false;

  String get fullPath => path + "\\" + name;

  Future<void> download() async {
    var path = await getExternalStorageDirectory();
    var local = path!.path + "/" + name;

    if (!await File(local).exists()) {
      //print(fullPath);
      await Files.getFile(fullPath, local);
    }
    if (await File(local).exists()) {
      localPath = local;
      downloaded = true;
      var prefs = await SharedPreferences.getInstance();
      prefs.setString(fullPath, localPath!);
    }
  }


  Future<void> rename() async {
    String newName = "2222222.jpg";


    var response = await Files.rename(fullPath, path + "\\" + newName);
    var pathP = await getExternalStorageDirectory();
    var local = pathP!.path + "/" + name;
    if (response.statusCode < 299) {
      if (await File(local).exists()) {
        downloaded = true;
        var prefs = await SharedPreferences.getInstance();
        prefs.remove(fullPath);
        name = newName;
        //print(fullPath);
        File(local).rename(pathP.path + "/" + newName);
        localPath = pathP.path + "/" + name;
        prefs.setString(fullPath, localPath!);
      }
    }
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

class IOElement {
  IOElement();



  static IOElement fromJson(Map<String, dynamic> data) {
    if (data["file"]) {
      return MFile.fromJson(
          path: data["shortPath"],
          name: data["name"],
          shortName: data["shortName"],
          ext: data["extension"]);
    }
    return MFolder.fromJson(path: data["path"], name: data["name"]);
  }
}
