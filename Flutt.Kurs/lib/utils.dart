import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kurs/resources/app_colors.dart';

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
      case ".exe":return Icon(Icons.extension_outlined,color: AppColors.primaryColor,size: 40,);
      case ".rar":return Icon(Icons.archive_outlined,color: AppColors.primaryColor,size: 40,);
      case ".jpg":case ".heic":return Icon(Icons.image_outlined,color: AppColors.primaryColor,size: 40,);
      case ".txt":return Icon(Icons.text_snippet_outlined,color: AppColors.primaryColor,size: 40,);
      case "f0lDeR":return  Icon(Icons.folder,color: AppColors.primaryColor,size: 60,);
      default: return  Icon(Icons.file_present_outlined,color: AppColors.primaryColor,size: 40,);
    }
  }
}