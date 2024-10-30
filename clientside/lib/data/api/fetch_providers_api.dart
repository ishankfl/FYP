import 'dart:async';
import 'dart:convert';

import 'package:bookme/constant/constant_export.dart';
import 'package:bookme/data/model/service_provider_model.dart';
import 'package:http/http.dart' as http;

class FetchProviderApiProvider {
  Future<List<ServiceProviderModel>> fetchEmergencyProviders(
      {required String token, required String service}) async {
    try {
      final url =
          "${ServerUrl.ipaddress()}emergency/api/serviceproviders/?service=$service";

      final request = await http.get(Uri.parse(url), headers: {
        "Accept": "application/json",

        "Content-Type": "text/plain",
        "Authorization":
            "Bearer $token", // Change "Authentication" to "Authorization"
      }).timeout(const Duration(seconds: 10));
      print(request.body);

      if (request.statusCode == 200) {
        List<ServiceProviderModel> services =
            List.from(jsonDecode(request.body)['available_providers'])
                .map((e) => ServiceProviderModel.fromMap(e))
                .toList();

        return services;
      } else {
        return [ServiceProviderModel.initError("Internal server error")];
      }
    } on TimeoutException {
      return [
        ServiceProviderModel.initError("Is your device is online? check again")
      ];
    } catch (exe) {
      print(exe);
      return [
        ServiceProviderModel.initError("Something went wrong please try again")
      ];
    }
  }

  Future<List<ServiceProviderModel>> fetchProviders(
      {required String token, required int id}) async {
    print("hello word");
    try {
      final url =
          "${ServerUrl.ipaddress()}services/api/fetchproviderbyservices/?service=$id";

      final request = await http.get(Uri.parse(url), headers: {
        "service": "$id",
        "Accept": "application/json",

        "Content-Type": "text/plain",
        "Authorization":
            "Bearer $token", // Change "Authentication" to "Authorization"
      }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        List<ServiceProviderModel> services =
            List.from(jsonDecode(request.body))
                .map((e) => ServiceProviderModel.fromMap(e))
                .toList();

        return services;
      } else {
        return [ServiceProviderModel.initError("Internal server error")];
      }
    } on TimeoutException {
      return [
        ServiceProviderModel.initError("Is your device is online? check again")
      ];
    } catch (exe) {
      return [
        ServiceProviderModel.initError("Something went wrong please try again")
      ];
    }
  }
}
