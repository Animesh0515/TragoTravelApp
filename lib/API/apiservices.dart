import 'dart:async';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trago/Models/FlightModel.dart';
import 'package:trago/Models/HotelModel.dart';
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
          Uri.parse("https://7a51050894ae.ngrok.io/api/Account/Login"),
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
          Uri.parse("https://7a51050894ae.ngrok.io/api/Account/Signup"),
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
          Uri.parse("https://7a51050894ae.ngrok.io/api/Package/GetPackage"),
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
          Uri.parse("https://7a51050894ae.ngrok.io/api/Package/SearchPackage"),
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
        Uri.parse("https://7a51050894ae.ngrok.io/api/Profile/getProfile"),
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
          Uri.parse("https://7a51050894ae.ngrok.io/api/Package/bookPackage"),
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
          Uri.parse("https://7a51050894ae.ngrok.io/api/Profile/updateProfile"),
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

  Future<List<dynamic>?> getFlightDetails(SearchFlightData data) async {
    String authorization = token + ":" + username;
    try {
      final response = await https.post(
          Uri.parse(
              "https://7a51050894ae.ngrok.io/api/Flight/getFlightDetails"),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer " + authorization,
            HttpHeaders.contentTypeHeader: "application/json"
          },
          body: json.encode(data));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<bool?> bookFlight(FlightBookingRequestModel requestModel) async {
    String authorization = token + ":" + username;
    try {
      final response = await https.post(
          Uri.parse("https://7a51050894ae.ngrok.io/api/Flight/BookFlight"),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer " + authorization,
            HttpHeaders.contentTypeHeader: "application/json"
          },
          body: json.encode(requestModel));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<dynamic>?> getHotels() async {
    String authorization = token + ":" + username;
    try {
      final response = await https.get(
        Uri.parse("https://7a51050894ae.ngrok.io/api/Hotel/getHotels"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer " + authorization,
          HttpHeaders.contentTypeHeader: "application/json"
        },
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<bool?>? bookHotel(HotelBooking hotelBooking) async {
    String authorization = token + ":" + username;
    try {
      final response = await https.post(
          Uri.parse("https://7a51050894ae.ngrok.io/api/Hotel/bookHotel"),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer " + authorization,
            HttpHeaders.contentTypeHeader: "application/json"
          },
          body: json.encode(hotelBooking.toJson()));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<dynamic>?> searchHotels(String str) async {
    String authorization = token + ":" + username;
    try {
      final response = await https.post(
          Uri.parse("https://7a51050894ae.ngrok.io/api/Hotel/searchHotel"),
          headers: {
            HttpHeaders.authorizationHeader: "Bearer " + authorization,
            HttpHeaders.contentTypeHeader: "application/json"
          },
          body: json.encode(str));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<bool> upload(XFile imageFile) async {
    // open a bytestream
    var stream =
        new https.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse("https://7a51050894ae.ngrok.io/api/Profile/UploadFile");

    // create multipart request
    var request = new https.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = new https.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));

    request.fields["user"] = "pawan";

    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }

    // listen for response
  }
}
