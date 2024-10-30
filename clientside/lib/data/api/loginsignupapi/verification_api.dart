import 'dart:convert';
import 'package:bookme/constant/server.dart';
import 'package:bookme/data/model/loginsignupmodel/verification_response_model.dart';
import 'package:http/http.dart' as http;

class VerificationApiProvider {
  Future<VerificationResponseModel> verifyUser({
    required String otp_code,
    required String email,
    required String secret_code,
      required String is_forgot_password

  }) async {
    try {
      final response = await http.post(
        Uri.parse("${ServerUrl.ipaddress()}account/api/otp/"),
        // Uri.parse("http://127.0.0.0:8000/account/api/otp/"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            "is_forgot_password": is_forgot_password,
            "secret_code": secret_code,
            "entered_otp": otp_code,
            'email': email
          },
        ),
      );
      if (response.statusCode == 200) {
        print("Response Verification 200 success");
        print(response.body);
        return VerificationResponseModel.fromMap(jsonDecode(response.body));
      } else if (response.statusCode == 400) {
        return VerificationResponseModel.InitError(
            "Verification code does not\n match");
      } else {
        print(response.body);
        print('Request failed with status: ${response.statusCode}');
        var body = response.body;
        var mapBody = jsonDecode(body);
        return VerificationResponseModel.InitError(
            mapBody['errors']['email'].toString());
      }
    } catch (err) {
      print(err);
      return VerificationResponseModel.InitError("Connection Issue");
    }
  }
}
