

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:kurs/cubit/main_folder/cubit.dart';
import 'package:kurs/cubit/navigation/cubit.dart';



import '../../data/api/files.dart';



class DownloadToServerButton extends StatelessWidget {
  const DownloadToServerButton({ required this.func}) : super( );
  final Function func;


  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.upload_sharp,
        size: 35,
      ),
      onPressed: func(),
    );
  }
}

