import 'package:kurs/data/models/file.dart';
import 'package:kurs/data/models/folder.dart';

class MPublicFolder extends IOElement{
  MPublicFolder({required this.name,required this.id, required Map<String,dynamic> data}){
    mFolder = MFolder.fromDataList((data["paths"] as List).map((item) => item as Map<String,dynamic>).toList());
  }

  String name;
  String id;
  late MFolder mFolder;
}