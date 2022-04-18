import 'dart:io';

import 'package:flutter/material.dart';



class ExtIcons{
  static Icon GetIcon(String extention){
    switch(extention){
      case "exe":return const Icon(Icons.extension,color: Colors.deepOrange,size: 40,);
      case "rar":return const Icon(Icons.archive_outlined,color: Colors.deepOrange,size: 40,);
      case "jpg":case "heic":return const Icon(Icons.image,color: Colors.deepOrange,size: 40,);
      case "txt":return const Icon(Icons.text_snippet,color: Colors.deepOrange,size: 40,);
      case "fOlDeR":return const Icon(Icons.folder,color: Colors.deepOrange,size: 60,);
      default: return const Icon(Icons.file_present,color: Colors.deepOrange,size: 40,);
    }
  }
}