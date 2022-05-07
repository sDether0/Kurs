import 'package:flutter/material.dart';






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
      onPressed: (){func();},
    );
  }
}