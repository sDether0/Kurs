import 'package:kurs/data/models/file.dart';
import 'package:kurs/data/models/folder.dart';

class MPublicFolder extends IOElement{
  MPublicFolder({required this.name,required this.id, required Map<String,dynamic> data}){
    mFolder = MFolder.fromDataList(data["paths"]);
  }

  String name;
  String id;
  late MFolder mFolder;
}