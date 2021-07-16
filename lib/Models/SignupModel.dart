class SingupRequestModel {
  String email;
  String password;
  String name;

  SingupRequestModel(
      {required this.email, required this.password, required this.name});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> req = {
      "Email": email.trim(),
      "Password": password.trim(),
      "Name": name.trim()
    };
    return req;
  }
}

class SingupResponseModel {
  final int statusCode;

  SingupResponseModel({required this.statusCode});

  factory SingupResponseModel.fromJson(Map<String, dynamic> result) {
    return SingupResponseModel(statusCode: result["StatusCode"]);
  }
}
