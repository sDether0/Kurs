class Auth{
  late String? token;
  late String? refreshToken;
  late bool success;
  late List<String>? errors;

  Auth({required this.token,required this.refreshToken,required this.success,required this.errors});

  Auth.fromJson(Map<String,dynamic> map){
    token = map["token"];
    refreshToken = map["refreshToken"];
    success = map["success"];
    errors = map["errors"];
  }
}