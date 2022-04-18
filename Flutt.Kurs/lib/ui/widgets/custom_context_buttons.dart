import 'package:flutter/material.dart';
import 'package:kurs/resources/app_strings.dart';

class DeleteButton extends ActionContextButton{
  const DeleteButton({Key? key, required func}) : super(key: key, func: func);

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: (){
      func();
    }, child: Row(
      children: const [
        Icon(Icons.delete_forever),
        Text(AppString.delete,style: TextStyle(color: Colors.white70),),
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
      children: const [
        Icon(Icons.drive_file_rename_outline),
        Text(AppString.rename,style: TextStyle(color: Colors.white70),),
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
      children: const [
        Icon(Icons.download),
        Text(AppString.download,style: TextStyle(color: Colors.white70),),
      ],
    ));
  }

}

abstract class ActionContextButton extends StatelessWidget{
  const ActionContextButton({Key? key, required this.func}) : super(key: key);
  final Function func;

}