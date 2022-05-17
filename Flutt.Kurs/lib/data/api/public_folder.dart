import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:kurs/data/http_headers.dart';
import 'package:kurs/data/temp_data.dart';
import 'package:kurs/resources/app_strings.dart';

import '../models/login.dart';
import '../models/refresh_token.dart';
import '../models/register.dart';
import 'utils.dart';

class PublicFolder {
  static Future<http.Response> createPublicFolder(String name) async {
    var response = await http.post(Uri.parse(AppString.url + "PublicFolder/$name"),
        headers: HttpHeaders.baseHeaders);

    if (!await response.authorize()) {
      response = await createPublicFolder(name);
    }

    return response;
  }

  static Future<http.Response> getPublicFolders() async {
    var response = await http.get(Uri.parse(AppString.url+"PublicFolder"),
        headers: HttpHeaders.baseHeaders);

    if (!await response.authorize()) {
      response = await getPublicFolders();
    }

    return response;
  }

  static Future<http.Response> deletePublicFolder(String folderId) async {
    var response = await http.get(
        Uri.parse(AppString.url + "PublicFolder/$folderId"),
        headers: HttpHeaders.baseHeaders);

    if (!await response.authorize()) {
      response = await deletePublicFolder(folderId);
    }

    return response;
  }
}
