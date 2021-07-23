class UserModelResponseModel {
  final String name;
  final String email;
  final String password;
  final String image;

  UserModelResponseModel(
      {required this.name,
      required this.email,
      required this.password,
      required this.image});

  factory UserModelResponseModel.fromJson(Map<String, dynamic> result) {
    return UserModelResponseModel(
        name: result["Name"],
        email: result['Email'],
        password: result["Password"],
        image: result["Image"]);
  }
}

class UserUpdateRequest {
  final String name;
  final String email;
  final String oldpasssword;
  final String newpassword;

  UserUpdateRequest({
    required this.name,
    required this.email,
    required this.oldpasssword,
    required this.newpassword,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      "name": name.trim(),
      "email": email.trim(),
      "oldpassword": oldpasssword.trim(),
      "newpassword": newpassword.trim(),
    };
    return json;
  }
}
