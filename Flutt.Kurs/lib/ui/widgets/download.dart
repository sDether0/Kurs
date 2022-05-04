import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class DownloadToServerButton extends StatelessWidget {
  const DownloadToServerButton() : super();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.upload_sharp,
        size: 35,
      ),
      onPressed: () async {FilePickerResult? result = await FilePicker.platform.pickFiles();},
    );
  }
}
