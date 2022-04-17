class RefreshToken{
  final String token;
  final String refreshToken;

  RefreshToken({required this.token, required this.refreshToken});

  Map<String,dynamic> toJson()=>{
  "token":token,
  "refreshToken":refreshToken
  };

  }
