import 'package:flutter/material.dart';
import 'package:kurs/resources/app_colors.dart';
import 'package:kurs/resources/app_strings.dart';

import 'package:kurs/ui/styles/app_text_styles.dart';

class DeleteButton extends ActionContextButton {
  const DeleteButton({Key? key, required func}) : super(key: key, func: func);

  @override
  Widget build(BuildContext context) {
    return IconContextButton(func: func,icon: Icons.delete_forever,text: AppString.delete,);
  }
}

class RenameButton extends ActionContextButton {
  const RenameButton({Key? key, required func}) : super(key: key, func: func);

  @override
  Widget build(BuildContext context) {
    return IconContextButton(func: func,icon: Icons.drive_file_rename_outline,text: AppString.rename,);
  }
}

class DownloadButton extends ActionContextButton {
  const DownloadButton({Key? key, required Function func})
      : super(key: key, func: func);

  @override
  Widget build(BuildContext context) {
    return IconContextButton(func: func,icon: Icons.download,text: AppString.download,);
  }

}

class IconContextButton extends ActionContextButton {
  IconContextButton({required Function func, required this.icon, required this.text})
      : super(func: func);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: () {
      func();
    }, child: Row(
      // mainAxisSize: MainAxisSize.max,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon,size:35),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(text, style: AppTextStyles.h3.action(),),
        ),
      ],
    ));
  }

}

abstract class ActionContextButton extends StatelessWidget {
  const ActionContextButton({Key? key, required this.func}) : super(key: key);
  final Function func;

}