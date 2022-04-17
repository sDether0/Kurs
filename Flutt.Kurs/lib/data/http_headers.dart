import 'package:kurs/data/temp_data.dart';

class HttpHeaders{
  // static Map<String, String> loginHeaders = {
  //   'Accept': 'Application/json',
  //   'Content-Type': 'application/x-www-urlencoded'
  // };

  static Map<String, String> baseHeaders = {
    'Accept': 'Application/json',
    'Authorization': 'Bearer ${TempData.token}'
  };

  static Map<String, String> registerHeaders = {
    'Accept': '*/*',
    'Content-Type': 'application/json'
  };

  static Map<String, String> fileUploadingHeaders = {
    'Accept': 'Application/json',
    'Authorization': 'Bearer ${TempData.token}',
    'Content-Type': 'multipart/form-data'
  };
}