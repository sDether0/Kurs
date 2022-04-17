import 'dart:io';

import 'package:flutter/material.dart';

class DevHttpOverrides  extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

class ExtIcons{
  static Icon GetIcon(String extention){
    switch(extention){
      case "exe":return const Icon(Icons.extension,color: Colors.deepOrange,size: 40,);
      case "rar":return const Icon(Icons.archive_outlined,color: Colors.deepOrange,size: 40,);
      default: return const Icon(Icons.file_present,color: Colors.deepOrange,size: 40,);
    }
  }
}