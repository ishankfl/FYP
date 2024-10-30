import 'dart:async';
import 'dart:convert';
import 'package:bookme/constant/constant_export.dart';
import 'package:bookme/data/model/model_export.dart';
import 'package:http/http.dart' as http;

class BidApiProvider {
  Future<List<BidModel>> addBidApi(
      {required int? service,
      required String? textcontent,
      required String? image,
      required double? lon,
      required double? lat,
      required String? location,
      required String amount,
      required String? token}) async {
    final url = "${ServerUrl.ipaddress()}bid/api/bid/";
    try {
      var uri = Uri.parse(url);
      var request = http.MultipartRequest("POST", uri);
      Map<String, String> data = {
        'service': service.toString(),
        'textcontent': textcontent.toString(),
        'lon': lon.toString(),
        'lat': lat.toString(),
        'location': location.toString(),
      };

      request.headers.addAll({
        "Accept": "application/json",
        "Content-Type": "text/plain",
        "Authorization":
            "Bearer $token", // Change "Authentication" to "Authorization"
      });
      request.fields.addAll(data);
      if (image != '') {
        request.files.add(await http.MultipartFile.fromPath('image', image!));
      }
      http.StreamedResponse response =
          await request.send().timeout(const Duration(seconds: 10));
      String streamContent =
          await response.stream.transform(utf8.decoder).join();
      if (response.statusCode == 201) {
        // print()
        List<BidModel> data = List.from(jsonDecode(streamContent)['data'])
            .map((e) => BidModel.fromMap(e))
            .toList();

        return data;
      } else {
        return [BidModel.InitError(jsonDecode(streamContent)['message'])];
      }
    } on TimeoutException {
      return [BidModel.InitError("Please Check you wifi")];
    } catch (err) {
      return [BidModel.InitError("Connection Issue")];
    }
  }

  Future<List<BidModel>> fetchBidList({required String? token}) async {
    final url = "${ServerUrl.ipaddress()}bid/api/bid/";
    try {
      var uri = Uri.parse(url);
      var request = http.MultipartRequest("GET", uri);

      request.headers.addAll({
        "Accept": "application/json",
        "Content-Type": "text/plain",
        "Authorization":
            "Bearer $token", // Change "Authentication" to "Authorization"
      });
      http.StreamedResponse response =
          await request.send().timeout(const Duration(seconds: 10));
      String streamContent =
          await response.stream.transform(utf8.decoder).join();
      if (response.statusCode == 201) {
        List<BidModel> data = List.from(jsonDecode(streamContent)['data'])
            .map((e) => BidModel.fromMap(e))
            .toList();
        return data;
      } else {
        return [BidModel.InitError(jsonDecode(streamContent)['message'])];
      }
    } on TimeoutException {
      return [BidModel.InitError("Please Check you wifi")];
    } catch (err) {
      return [BidModel.InitError("Connection Issue")];
    }
  }

  Future<List<BidCommentModel>> addCommentApi(
      {required String? bidId,
      required String? textcontent,
      required String? token}) async {
    final url = "${ServerUrl.ipaddress()}bid/api/addcomment/";
    try {
      var uri = Uri.parse(url);
      var request = http.MultipartRequest("POST", uri);
      Map<String, String> data = {
        'bid': bidId!,
        'textcontent': textcontent.toString(),
      };
      // request.

      request.headers.addAll({
        "Accept": "application/json",
        "Content-Type": "text/plain",
        "Authorization":
            "Bearer $token", // Change "Authentication" to "Authorization"
      });
      request.fields.addAll(data);

      http.StreamedResponse response =
          await request.send().timeout(const Duration(seconds: 10));
      String streamContent =
          await response.stream.transform(utf8.decoder).join();
      if (response.statusCode == 201) {
        // print()
        List<BidCommentModel> data =
            List.from(jsonDecode(streamContent)['data'])
                .map((e) => BidCommentModel.fromMap(e))
                .toList();

        return data;
      } else {
        return [
          BidCommentModel.initError(jsonDecode(streamContent)['message'])
        ];
      }
    } on TimeoutException {
      return [BidCommentModel.initError("Please Check you wifi")];
    } catch (err) {
      return [BidCommentModel.initError("Connection Issue")];
    }
  }

  Future<List<BidCommentModel>> fetchComment(
      {required String? bidId, required String? token}) async {
    final url = "${ServerUrl.ipaddress()}bid/api/addcomment/?bidId=${bidId}";
    // try {
    var uri = Uri.parse(url);
    var request = http.MultipartRequest("GET", uri);

    // request.

    request.headers.addAll({
      "Accept": "application/json",
      "Content-Type": "text/plain",
      "Authorization":
          "Bearer $token", // Change "Authentication" to "Authorization"
    });
    http.StreamedResponse response =
        await request.send().timeout(const Duration(seconds: 10));
    String streamContent = await response.stream.transform(utf8.decoder).join();
    print(streamContent);
    print(response.statusCode);
    if (response.statusCode == 200) {
      // print()
      List<BidCommentModel> data = List.from(jsonDecode(streamContent)['data'])
          .map((e) => BidCommentModel.fromMap(e))
          .toList();
      print(data);

      return data;
    } else {
      return [BidCommentModel.initError(jsonDecode(streamContent)['message'])];
    }
    // } on TimeoutException {
    //   return [BidCommentModel.initError("Please Check you wifi")];
    // } catch (err) {
    //   print(err);
    //   return [BidCommentModel.initError("Connection Issue")];
    // }
  }
}
