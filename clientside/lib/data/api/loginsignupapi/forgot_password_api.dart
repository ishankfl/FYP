import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bookme/constant/constant_export.dart';
import '../../model/model_export.dart';

class ForgotPasswordApiProvider {
  Future<UserModel> forgotPassword({
    required String email,
  }) async {
    try {
      var response = await http
          .post(
            Uri.parse(
                "${ServerUrl.ipaddress()}account/api/forgotpasswordgetcode/"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              'email': email,
            }),
          )
          .timeout(const Duration(seconds: 8));
      if (response.statusCode == 200) {
        return UserModel.fromMap(jsonDecode(response.body));
      }
      if (response.statusCode == 404) {
        return UserModel.InitError("Please do signup first");
      } else {
        return UserModel.InitError("Internal Server Error");

        // print('Request failed with status: ${response.statusCode}');
      }
    } on TimeoutException {
      return UserModel.InitError("Please Check your connection");
    } catch (err) {
      return UserModel.InitError("Something went wrong please try again");
    }
  }

  Future<UserModel> changePassword(
      {required String email, required String password}) async {
    try {
      var response = await http
          .post(
            Uri.parse("${ServerUrl.ipaddress()}account/api/changepassword/"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              'email': email,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 8));
      if (response.statusCode == 200) {
        return UserModel.fromMap(jsonDecode(response.body));
      }
      if (response.statusCode == 404) {
        return UserModel.InitError("Please do signup first");
      } else {
        return UserModel.InitError("Internal Server Error");

        // print('Request failed with status: ${response.statusCode}');
      }
    } on TimeoutException {
      return UserModel.InitError("Please Check your connection");
    } catch (err) {
      return UserModel.InitError("Something went wrong please try again");
    }
  }
}
