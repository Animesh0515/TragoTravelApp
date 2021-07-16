class LoginRequestModel {
  String email;
  String password;

  LoginRequestModel({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> req = {
      'Email': email.trim(),
      'Password': password.trim()
    };
    return req;
  }
}

class LoginResponseModel {
  final bool valid;
  final String token;

  LoginResponseModel({required this.valid, required this.token});

  factory LoginResponseModel.fromJson(Map<String, dynamic> result) {
    return LoginResponseModel(valid: result["valid"], token: result["token"]);
  }
}
