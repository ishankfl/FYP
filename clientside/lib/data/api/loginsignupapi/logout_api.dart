import 'dart:async';
import 'dart:convert';
import 'package:bookme/data/model/logout_response_model.dart';
import 'package:bookme/notification_services.dart';
import 'package:http/http.dart' as http;
import 'package:bookme/constant/constant_export.dart';

class LogoutApiProvider {
  NotificationServices notificationServices = NotificationServices();
  Future<LogoutResponseModel> logOut({
    required String token,
  }) async {
    String deviceTokenId = await notificationServices.getDeviceToken();
    print("Device token: " + deviceTokenId);
    print(deviceTokenId);
    try {
      var response = await http
          .post(Uri.parse("${ServerUrl.ipaddress()}notify/api/logout/"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer $token'
              },
              body: jsonEncode({
                'tokenString': deviceTokenId,
              }))
          .timeout(const Duration(seconds: 8));
      if (response.statusCode == 200) {
        return LogoutResponseModel.fromMap(jsonDecode(response.body));
      } else {
        // print('Request failed with status: ${response.statusCode}');
        return LogoutResponseModel.InitError(
            "Something went wrong with the request ");
      }
    } on TimeoutException {
      return LogoutResponseModel.InitError("Please Check you wifi");
    } catch (err) {
      return LogoutResponseModel.InitError("Connection Issue");
    }
  }
}
