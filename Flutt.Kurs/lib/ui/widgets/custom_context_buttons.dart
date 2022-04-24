import 'package:flutter/material.dart';
import 'package:kurs/resources/app_colors.dart';
import 'package:kurs/resources/app_strings.dart';

import 'package:kurs/ui/styles/app_text_styles.dart';

class DeleteButton extends ActionContextButton{
  const DeleteButton({Key? key, required func}) : super(key: key, func: func);

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: (){
      func();
    }, child: Row(
      // mainAxisSize: MainAxisSize.max,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.delete_forever,size: 35,),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(AppString.delete,style: AppTextStyles.h3.action(),),
        ),
      ],
    ));
  }
}

class RenameButton extends ActionContextButton{
  const RenameButton({Key? key, required func}) : super(key: key,func: func);

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: (){
      func();
      }, child: Row(
      // mainAxisSize: MainAxisSize.max,
      // mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        const Icon(Icons.drive_file_rename_outline,size: 35),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(AppString.rename,style: AppTextStyles.h3.action(),),
        ),
      ],
    ));
  }
}

class DownloadButton extends ActionContextButton{
  const DownloadButton({Key? key, required Function func}) : super(key: key, func: func);

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: (){
      func();
    }, child: Row(
      // mainAxisSize: MainAxisSize.max,
      // mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        const Icon(Icons.download,size: 35),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(AppString.download,style: AppTextStyles.h3.action(),),
        ),
      ],
    ));
  }

}

abstract class ActionContextButton extends StatelessWidget{
  const ActionContextButton({Key? key, required this.func}) : super(key: key);
  final Function func;

}