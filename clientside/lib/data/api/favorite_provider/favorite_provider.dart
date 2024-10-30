import 'dart:async';
import 'dart:convert';
import 'package:bookme/data/model/favorite_provider_model.dart';
import 'package:bookme/notification_services.dart';
import 'package:http/http.dart' as http;
import 'package:bookme/constant/constant_export.dart';
import '../../model/model_export.dart';

class FavoriteProviderApiProvider {
  Future<FavoriteProviderModel> favoriteProvider(
      {required String? token,
      required String? serviceProvider,
      required bool? isFavorite}) async {
    try {
      var response = await http
          .post(
            Uri.parse("${ServerUrl.ipaddress()}account/api/favorite/"),
            headers: <String, String>{
              'Authorization': 'Bearer ${token!}',
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              'provider': serviceProvider,
              'is_favorite': isFavorite,
            }),
          )
          .timeout(const Duration(seconds: 8));
      if (response.statusCode == 200) {
        return FavoriteProviderModel.fromMap(jsonDecode(response.body));
      } else {
        // print('Request failed with status: ${response.statusCode}');
        return FavoriteProviderModel.InitError("Invalid Email or Password");
      }
    } on TimeoutException {
      return FavoriteProviderModel.InitError("Please Check you wifi");
    } catch (err) {
      return FavoriteProviderModel.InitError("Connection Issue");
    }
  }

  Future<List<FavoriteProviderModel>> fetchfavoriteProvider({
    required String? token,
  }) async {
    try {
      var response = await http.get(
        Uri.parse("${ServerUrl.ipaddress()}account/api/favorite/"),
        headers: <String, String>{
          'Authorization': 'Bearer ${token!}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(const Duration(seconds: 8));
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        print(response.body);
        List<FavoriteProviderModel> data = List.from(jsonDecode(response.body))
            .map((e) => FavoriteProviderModel.fromMap(e))
            .toList();
        return data;
        // return [FavoriteProviderModel.fromJson(jsonDecode(response.body))];
      } else {
        // print('Request failed with status: ${response.statusCode}');
        return [FavoriteProviderModel.InitError("Invalid Email or Password")];
      }
    } on TimeoutException {
      return [FavoriteProviderModel.InitError("Please Check you wifi")];
    } catch (err) {
      print(err);
      return [FavoriteProviderModel.InitError("Connection Issue")];
    }
  }
}
