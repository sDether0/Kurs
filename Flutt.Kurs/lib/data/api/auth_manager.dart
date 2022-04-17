import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kurs/data/http_headers.dart';
import 'package:kurs/data/temp_data.dart';
import 'package:kurs/resources/app_strings.dart';

import '../models/login.dart';
import '../models/refresh_token.dart';
import '../models/register.dart';

class AuthManager {
  static Future<http.Response> register(Register register) async {
    var response = await http.post(Uri.parse(AppString.url + "Register"),
        body: jsonEncode(register.toJson()), headers: HttpHeaders.registerHeaders);
    return response;
  }

  static Future<http.Response> login(Login login) async {
    var response = await http.post(Uri.parse(AppString.url + "Login"),
        body:jsonEncode(login.toJson()), headers: HttpHeaders.registerHeaders);
    return response;
  }

  static Future<http.Response> refreshToken(RefreshToken refreshToken) async {
    var response = await http.post(Uri.parse(AppString.url + "RefreshToken"),
        body: jsonEncode(refreshToken.toJson()), headers: HttpHeaders.registerHeaders);
    return response;
  }
}

