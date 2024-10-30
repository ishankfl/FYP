import 'dart:async';
import 'dart:convert';

import 'package:bookme/constant/constant_export.dart';
import 'package:bookme/data/model/notification_model.dart';
import 'package:bookme/data/model/service_provider_model.dart';
import 'package:http/http.dart' as http;

class NotificationApi {
  Future<List<NotificationModel>> fetchNotification(
      {required String token}) async {
    try {
      final url = "${ServerUrl.ipaddress()}notify/api/get-notification/";

      final request = await http.get(Uri.parse(url), headers: {
        "Accept": "application/json",

        "Content-Type": "text/plain",
        "Authorization":
            "Bearer $token", // Change "Authentication" to "Authorization"
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        return List.from(jsonDecode(request.body))
            .map((e) => NotificationModel.fromMap(e))
            .toList();
        // return [NotificationModel.fromMap(jsonDecode(request.body))];

      } else {
        return [NotificationModel.initError("Internal server error")];
      }
    } on TimeoutException {
      return [
        NotificationModel.initError("Is your device is online? check again")
      ];
    } catch (exe) {
      print(exe);
      return [
        NotificationModel.initError("Something went wrong please try again")
      ];
    }
  }
}
