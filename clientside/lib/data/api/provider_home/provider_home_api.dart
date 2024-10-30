import 'dart:async';
import 'dart:convert';

import 'package:bookme/constant/constant_export.dart';
import 'package:bookme/data/model/chart_model.dart';
import 'package:bookme/data/model/request_count_model.dart';
import 'package:bookme/data/model/service_provider_model.dart';
import 'package:http/http.dart' as http;

class ProviderHomeApi {
  Future<List<ChartModel>> fetchChartDetails({required String token}) async {
    try {
      final url = "${ServerUrl.ipaddress()}payment/api/monthly/";

      final request = await http.post(Uri.parse(url), headers: {
        "Accept": "application/json",
        "Content-Type": "text/plain",
        "Authorization":
            "Bearer $token", // Change "Authentication" to "Authorization"
      }).timeout(const Duration(seconds: 10));
      print(request.body);

      if (request.statusCode == 200) {
        List<ChartModel> services = List.from(jsonDecode(request.body))
            .map((e) => ChartModel.fromMap(e))
            .toList();

        return services;
      } else {
        return [ChartModel.initError("Internal server error")];
      }
    } on TimeoutException {
      return [ChartModel.initError("Is your device is online? check again")];
    } catch (exe) {
      print(exe);
      return [ChartModel.initError("Something went wrong please try again")];
    }
  }

  Future<List<RequestCountModel>> fetchRequestCount(
      {required String token}) async {
    try {
      final url = "${ServerUrl.ipaddress()}booking/api/homeview/";

      final request = await http.get(Uri.parse(url), headers: {
        "Accept": "application/json",
        "Content-Type": "text/plain",
        "Authorization":
            "Bearer $token", // Change "Authentication" to "Authorization"
      }).timeout(const Duration(seconds: 10));
      print(request.body);

      if (request.statusCode == 200) {
        print(jsonDecode(request.body)['data']);
        List<RequestCountModel> services = [
          RequestCountModel.fromJson(request.body)
        ];

        return services;
      } else {
        return [RequestCountModel.initError("Internal server error")];
      }
    } on TimeoutException {
      return [
        RequestCountModel.initError("Is your device is online? check again")
      ];
    } catch (exe) {
      print(exe);
      return [
        RequestCountModel.initError("Something went wrong please try again")
      ];
    }
  }
}
