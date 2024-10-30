import 'dart:async';
import 'dart:convert';
import 'package:bookme/constant/server.dart';
import 'package:bookme/data/model/user_model.dart';
import 'package:http/http.dart' as http;

class SignUpApiProvider {
  Future<UserModel> signUp(
      {required String full_name,
      required String email,
      required String location,
      required String city,
      required String phonenumber,
      required String password,
      required String user_type}) async {
    print("THis is passing");
    print(full_name);
    print(email);
    print(city);
    print(phonenumber);
    print(password);
    try {
      final response = await http
          .post(
            Uri.parse("${ServerUrl.ipaddress()}account/api/customer/"),
            // Uri.parse("http://192.168.1.71:8000/account/api/customer/"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              "user": {
                "full_name": full_name,
                "email": email,
                "phonenumber": phonenumber,
                "user_type": user_type,
                "password": password,
                "city": city,
                'location': location
              },
            }),
          )
          .timeout(const Duration(seconds: 5));
      print(response.body);
      if (response.statusCode == 200) {
        print("Response SignUp 200 success");
        print(response.body);
        return UserModel.fromMap(jsonDecode(response.body));
      } else {
        print('Request failed with status: ${response.statusCode}');
        var body = response.body;
        var mapBody = jsonDecode(body);
        return UserModel.InitError(mapBody['errors']['email'].toString());
      }
    } on TimeoutException {
      return UserModel.InitError("Please Check you wifi");
    } catch (err) {
      print("error.com");
      print(err);
      return UserModel.InitError("Sorry you are currently Ofline!");
    }
  }

  Future<UserModel> updateUser({required UserModel model}) async {
    String token = model.access!;
    print(token);
    print(model);
    var uri = Uri.parse("${ServerUrl.ipaddress()}account/api/userprofile/");
    print(uri);
    try {
      var request = http.MultipartRequest("PATCH", uri);
      Map<String, String> data = {
        'email': model.email!,
        'full_name': model.full_name!,
        'phonenumber': model.phonenumber!,
        'username': model.username!,
        'city': model.city!,
      };
      request.fields.addAll(
        data,
      );
      request.headers.addAll({
        "Accept": "application/json",

        "Content-Type": "text/plain",
        "Authorization":
            "Bearer $token", // Change "Authentication" to "Authorization"
      });
      if (model.profile != '') {
        request.files
            .add(await http.MultipartFile.fromPath('profile', model.profile!));
      }
      // request.files
      //     .add(await http.MultipartFile.fromPath('profile', profile!.path));
      http.StreamedResponse response =
          await request.send().timeout(const Duration(seconds: 5));
      print(response.statusCode);

      if (response.statusCode == 200) {
        print("Response login 200 success");
        print(response.stream.toStringStream());
        // print()
        String streamContent =
            await response.stream.transform(utf8.decoder).join();
        print(streamContent);
        return UserModel.fromMap(jsonDecode(streamContent));
      } else if (response.statusCode == 500) {
        return UserModel.InitError("Server error occurs");
      } else {
        print('Request failed with status: ${response.statusCode}');
        return UserModel.InitError("Invalid Email or Password");
      }
    } on TimeoutException {
      return UserModel.InitError("Please Check you wifi");
    } catch (Exception) {
      print(Exception);
      return UserModel.InitError("Invalid Email or Password");
    }
  }
}
