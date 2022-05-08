import 'package:flutter/material.dart';
import 'package:kurs/resources/app_strings.dart';

import 'package:kurs/ui/styles/app_text_styles.dart';

class DeleteButton extends ActionContextButton {
  const DeleteButton({required func, required this.local}) : super(func: func);

  final bool local;

  @override
  Widget build(BuildContext context) {
    return IconContextButton(
      func: func,
      icon: local ? Icons.delete_forever : Icons.cloud_off,
      text: local ? AppString.delete : AppString.deleteFrom,
    );
  }
}

class RenameButton extends ActionContextButton {
  const RenameButton({required func}) : super(func: func);

  @override
  Widget build(BuildContext context) {
    return IconContextButton(
      func: func,
      icon: Icons.drive_file_rename_outline,
      text: AppString.rename,
    );
  }
}

class DownloadButton extends ActionContextButton {
  const DownloadButton({required Function func}) : super(func: func);

  @override
  Widget build(BuildContext context) {
    return IconContextButton(
      func: func,
      icon: Icons.download,
      text: AppString.download,
    );
  }
}

class IconContextButton extends ActionContextButton {
  const IconContextButton(
      {required Function func, required this.icon, required this.text})
      : super(func: func);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          func();
        },
        child: Row(
          // mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 35),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                text,
                style: AppTextStyles.h3.action(),
              ),
            ),
          ],
        ));
  }
}

abstract class ActionContextButton extends StatelessWidget {
  const ActionContextButton({required this.func}) : super();
  final Function func;
}
