import 'dart:async';
import 'dart:convert';

import 'package:bookme/constant/constant_export.dart';
import 'package:bookme/data/model/user_model.dart';
import 'package:http/http.dart' as http;

class FetchUserApiProvider {
  Future<List<UserModel>> fetchProfile({required String token}) async {
    print("On api provider");
    print(token);
    try {
      final url = "${ServerUrl.ipaddress()}account/api/userprofile/";

      final request = await http.get(Uri.parse(url), headers: {
        "Accept": "application/json",

        "Content-Type": "text/plain",
        "Authorization":
            "Bearer $token" // Change "Authentication" to "Authorization"
      });

      print(request.statusCode);
      if (request.statusCode == 200) {
        // Map body = request.body as Map;
        final Map<String, dynamic> responseData = jsonDecode(request.body);
        final String jsonDataString = responseData['data'] as String;

        // Replace single quotes with double quotes
        final String cleanedJsonString =
            jsonDataString.replaceAll("'", '"').replaceAll('None', '""');

        final Map<String, dynamic> jsonMap = jsonDecode(cleanedJsonString);

        List<UserModel> services = [UserModel.fromMap(jsonMap)];
        print(services);
        return services;
      } else {
        return [UserModel.withError("Server Error")];
      }
    } on TimeoutException {
      return [UserModel.withError("Please Check you wifi")];
    } catch (err) {
      return [UserModel.withError("Connection problem")];
    }
  }
}
