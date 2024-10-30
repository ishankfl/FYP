import 'dart:convert';

import 'package:bookme/constant/constant_export.dart';
import 'package:bookme/data/model/time_validation_model.dart';
import 'package:http/http.dart' as http;

class TimeValidationApiProvider {
  Future<List<TimeValidationModel>> chechProviderAvailability(
      {required String token,
      required int providerId,
      required String date_time,
      required String expected_hours}) async {
    print("On api provider");
    print(date_time);

    print(token);
    final url =
        "${ServerUrl.ipaddress()}booking/api/provideravailability/?start_time_date=$date_time:00&expected_hours=$expected_hours&provider=$providerId";
    print(url);
    final request = await http.get(Uri.parse(url), headers: {
      "Accept": "application/json",

      "Content-Type": "text/plain",
      "Authorization":
          "Bearer $token", // Change "Authentication" to "Authorization"
    });

    if (request.statusCode == 200) {
      print(request.body);
      List<TimeValidationModel> data = List.from(jsonDecode(request.body))
          .map((e) => TimeValidationModel.fromMap(e))
          .toList();

      print(data);

      return data;
    } else {
      return [TimeValidationModel.withError("Server Error")];
    }
  }
}
