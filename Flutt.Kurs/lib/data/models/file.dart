import 'package:flutter/material.dart';
import 'package:kurs/utils.dart';

class MFile{
  MFile(String fullPath){
    var spl = fullPath.split("\\");
    name = spl.last.split(".").where((element) => element!=spl.last.split(".").last).join(".");
    ext = spl.last.split(".").last;
    path = spl.where((element) => element!=spl.last).join("\\");
    icon = ExtIcons.GetIcon(ext);
  }
  late String name;
  late String path;
  late String ext;
  late Icon icon;
  String get fullPath => path+"\\"+name+"\\"+ext;
}