import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/refresh_token.dart';
import '../temp_data.dart';
import 'auth_manager.dart';

extension CResponse on http.Response {
  Future<bool> authorize() async {
    if (statusCode == 401) {
      if (TempData.token.isEmpty || TempData.token.isEmpty) {
        return false;
      }
      var response = await AuthManager.refreshToken(RefreshToken(
          token: TempData.token, refreshToken: TempData.refreshToken));
      Map<String,dynamic> body = jsonDecode(response.body);
      TempData.token=body["token"];
      TempData.refreshToken=body["refreshToken"];
      return false;
    }
    return true;
  }
}

