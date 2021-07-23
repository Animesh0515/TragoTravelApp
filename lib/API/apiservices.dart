import 'dart:async';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:trago/Models/FlightModel.dart';
import 'package:trago/Models/LoginModel.dart';
import 'package:http/http.dart' as https;
import 'package:trago/Models/SignupModel.dart';
import 'package:trago/Models/UserModel.dart';

class API {
  static String token = "";
  static String username = "";
  Future<LoginResponseModel?> login(LoginRequestModel loginRequestModel) async {
    try {
      final response = await https.post(
          Uri.parse("https://b4a7e8cf7d43.ngrok.io/api/Account/Login"),
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
          Uri.parse("https://b4a7e8cf7d43.ngrok.io/api/Account/Signup"),
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

  Future<List<dynamic>?> getPackages() async {
    String authorization = token + ":" + username;
    try {
      final response = await https.get(
          Uri.parse("https://b4a7e8cf7d43.ngrok.io/api/Package/GetPackage"),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer " + authorization,
            HttpHeaders.contentTypeHeader: "application/json"
          });
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<dynamic>?> searchPackage(String destination) async {
    String authorization = token + ":" + username;
    try {
      final response = await https.post(
          Uri.parse("https://b4a7e8cf7d43.ngrok.io/api/Package/SearchPackage"),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer " + authorization,
            HttpHeaders.contentTypeHeader: "application/json"
          },
          body: jsonEncode(destination));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<UserModelResponseModel?> getUserData() async {
    String authorization = token + ":" + username;
    try {
      final response = await https.get(
        Uri.parse("https://b4a7e8cf7d43.ngrok.io/api/Profile/getProfile"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer " + authorization,
          HttpHeaders.contentTypeHeader: "application/json"
        },
      );
      if (response.statusCode == 200) {
        return UserModelResponseModel.fromJson(json.decode(response.body));
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<bool> bookPackage(int packageId) async {
    String authorization = token + ":" + username;
    try {
      final response = await https.post(
          Uri.parse("https://b4a7e8cf7d43.ngrok.io/api/Package/bookPackage"),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer " + authorization,
            HttpHeaders.contentTypeHeader: "application/json"
          },
          body: json.encode(packageId));
      if (response.statusCode == 200) {
        print(response.body);
        return json.decode(response.body);
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<int?> updateProfile(UserUpdateRequest? usrData) async {
    String authorization = token + ":" + username;
    try {
      final response = await https.post(
          Uri.parse("https://b4a7e8cf7d43.ngrok.io/api/Profile/updateProfile"),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer " + authorization,
            HttpHeaders.contentTypeHeader: "application/json"
          },
          body: jsonEncode(usrData!.toJson()));
      if (response.statusCode == 200) {
        print(response.body);
        return json.decode(response.body);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<dynamic>?> getFlightDetails() async {
    String authorization = token + ":" + username;
    try {
      final response = await https.get(
          Uri.parse(
              "https://b4a7e8cf7d43.ngrok.io/api/Flight/getFlightDetails"),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer " + authorization,
            HttpHeaders.contentTypeHeader: "application/json"
          });
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
