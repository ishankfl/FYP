import 'dart:async';
import 'dart:convert';
import 'package:bookme/logic/services/device_info.dart';
import 'package:bookme/notification_services.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
import 'package:bookme/constant/constant_export.dart';
import '../../model/model_export.dart';

class LoginApiProvider {
  NotificationServices notificationServices = NotificationServices();
  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    AndroidDeviceInfo deviceName = await DeviceInfo.androidInfo();
    String nameOfDevice = deviceName.brand;
    String deviceTokenId = await notificationServices.getDeviceToken();
    print("${ServerUrl.ipaddress()}account/api/login/");
    try {
      var response = await http
          .post(
            Uri.parse("${ServerUrl.ipaddress()}account/api/login/"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              'email': email,
              'password': password,
              'device_name': nameOfDevice,
              'device_token': deviceTokenId
            }),
          )
          .timeout(const Duration(seconds: 8));
      if (response.statusCode == 200) {
        return LoginModel.fromMap(jsonDecode(response.body));
      } else {
        // print('Request failed with status: ${response.statusCode}');
        return LoginModel.InitError("Invalid Email or Password");
      }
    } on TimeoutException {
      return LoginModel.InitError("Please Check you wifi");
    } catch (err) {
      return LoginModel.InitError("Connection Issue");
    }
  }
}
