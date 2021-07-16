import 'dart:convert';

import 'package:trago/Models/LoginModel.dart';
import 'package:http/http.dart' as https;
import 'package:trago/Models/SignupModel.dart';

class API {
  static String token = "";
  Future<LoginResponseModel?> login(LoginRequestModel loginRequestModel) async {
    try {
      final response = await https.post(
          Uri.parse("https://7fdddaab2574.ngrok.io/api/Account/Login"),
          body: loginRequestModel.toJson());

      if (response.statusCode == 200) {
        print(jsonDecode(response.body)["token"]);
        return LoginResponseModel.fromJson(jsonDecode(response.body));
      } else {
        print("Failed to check credential");
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<SingupResponseModel?> Signup(
      SingupRequestModel singupRequestModel) async {
    try {
      final response = await https.post(
          Uri.parse("https://7fdddaab2574.ngrok.io/api/Account/Signup"),
          body: singupRequestModel.toJson());

      if (response.statusCode == 200) {
        return SingupResponseModel.fromJson(jsonDecode(response.body));
      } else {
        print("Failed to save data");
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
