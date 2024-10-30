// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';

import 'package:bookme/constant/constant_export.dart';
import 'package:bookme/data/model/model_export.dart';
import 'package:http/http.dart' as http;

class ChatApiProvider {
  Future<List<UserModel>> fetchChatUser({required String token}) async {
    final url = "${ServerUrl.ipaddress()}booking/api/chattinglist/";
    try {
      final request = await http.get(Uri.parse(url), headers: {
        "Accept": "application/json",

        "Content-Type": "text/plain",
        "Authorization":
            "Bearer $token", // Change "Authentication" to "Authorization"
      }).timeout(Duration(seconds: 10));

      print(request.body);
      if (request.statusCode == 200) {
        var data = jsonDecode(request.body)['data'];
        if (data == []) {
          return data;
        }
        List<UserModel> services =
            List.from(data)
            .map((e) => UserModel.fromMap(e))
            .toList();

        return services;
      } else {
        return [UserModel.InitError(jsonDecode(request.body)['message'])];
      }
    } on TimeoutException {
      return [UserModel.InitError("Please Check you wifi")];
    } catch (err) {
      return [UserModel.InitError("Connection Issue")];
    }
  }

  Future<List<ChatModel>> individualChat(
      {required String token, required toId}) async {
    final url = "${ServerUrl.ipaddress()}chat/api/chatmessage/?to=$toId";
    try {
      final request = await http.get(Uri.parse(url), headers: {
        "Accept": "application/json",
        "Content-Type": "text/plain",
        "Authorization":
            "Bearer $token", // Chang e "Authentication" to "Authorization"
      }).timeout(const Duration(seconds: 10));
      // print(request.body);
      if (request.statusCode == 200) {
        List<ChatModel> services = List.from(jsonDecode(request.body)['data'])
            .map((e) => ChatModel.fromMap(e))
            .toList();

        return services;
      } else {
        return [ChatModel.initError(jsonDecode(request.body)['message'])];
      }
    } on TimeoutException {
      return [ChatModel.initError("Please Check you wifi")];
    } catch (err) {
      return [ChatModel.initError("Connection Issue")];
    }
  }
}
