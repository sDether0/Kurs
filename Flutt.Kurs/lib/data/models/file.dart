import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kurs/data/api/files.dart';
import 'package:kurs/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MFile extends IOElement {
  MFile(String fullPath) {
    var spl = fullPath.split("\\");
    name = spl.last;
    ext = spl.last.split(".").last;
    path = spl.where((element) => element != spl.last).join("\\");
    icon = ExtIcons.GetIcon(ext);
    sPath = fullPath.replaceAll(fullPath.split("\\").first+"\\", "");
    SharedPreferences.getInstance().then((value) {
      localPath = value.getString(fullPath);
      downloaded = localPath==null?false:true;
    });
  }

  late String name;
  late String path;
  late String sPath;
  late Icon icon;
  late String ext;
  late String? localPath;
  bool downloaded = false;

  String get fullPath => path + "\\" + name;

  Future<void> download() async {
    var path = await getExternalStorageDirectory();
    var local = path!.path+"/"+name;

    if(!await File(local).exists()){

      await Files.getFile(sPath, local);

    }
    if(await File(local).exists()){
      localPath=local;
      downloaded = true;
      var prefs = await SharedPreferences.getInstance();
      prefs.setString(fullPath, localPath!);
    }
  }

  Future<void> deleteLocal() async{
    if(downloaded && await File(localPath!).exists())
    {
      await File(localPath!).delete();
    }
    if(!await File(localPath!).exists())
    {
      var prefs = await SharedPreferences.getInstance();
      prefs.remove(fullPath);
      localPath=null;
      downloaded=false;
    }
  }
}

class IOElement {}
