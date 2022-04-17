import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:kurs/data/http_headers.dart';
import 'package:kurs/resources/app_strings.dart';

import 'utils.dart';

class Files {
  static Future<http.Response> getFiles() async {
    var response = await http.get(Uri.parse(AppString.url + "Files"),
        headers: HttpHeaders.baseHeaders);

    if (!await response.authorize()) {
      response = await getFiles();
    }

    return response;
  }

  static Future<http.Response> getFilesPaths() async {
    var response = await http.get(Uri.parse(AppString.url + "Files"),
        headers: HttpHeaders.baseHeaders);

    if (!await response.authorize()) {
      response = await getFilesPaths();
    }

    return response;
  }

  static Future<http.Response> createRootFolder(String folder) async {
    var response = await http.post(Uri.parse(AppString.url + "Files/$folder"),
        headers: HttpHeaders.baseHeaders);

    if (!await response.authorize()) {
      response = await createRootFolder(folder);
    }

    return response;
  }

  static Future<http.Response> createPathFolder(
      String path, String folder) async {
    var response = await http.post(
        Uri.parse(AppString.url + "Files/$path/$folder"),
        headers: HttpHeaders.baseHeaders);

    if (!await response.authorize()) {
      response = await createPathFolder(path, folder);
    }

    return response;
  }

  static Future<http.Response> getFolder(
      String path) async {
    var response = await http.get(
        Uri.parse(AppString.url + "Files/folder/$path"),
        headers: HttpHeaders.baseHeaders);

    if (!await response.authorize()) {
      response = await getFolder(path);
    }

    return response;
  }
  ///путь с названием файла
  static Future<http.Response> getFile(
      String path, String localPath) async {
    var response = await http.get(
        Uri.parse(AppString.url + "Files/file/$path"),
        headers: HttpHeaders.baseHeaders);
    File(localPath).writeAsBytes(response.bodyBytes);

    if (!await response.authorize()) {
      response = await getFile(path,localPath);
    }

    return response;
  }

  static Future<http.Response> createFile(
      File file, String path) async {
    var request = http.MultipartRequest("POST",
        Uri.parse(AppString.url + "Files/$path"));
        request.headers.addAll(HttpHeaders.fileUploadingHeaders);
        request.files.add(http.MultipartFile.fromString(file.path.split("/").last, file.path));
    var response = await http.Response.fromStream(await request.send());
    if (!await response.authorize()) {
      response = await createFile(file,path);
    }

    return response;
  }
}
