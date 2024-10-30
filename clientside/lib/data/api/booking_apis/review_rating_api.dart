import 'dart:async';
import 'dart:convert';

import 'package:bookme/constant/server.dart';
import 'package:bookme/data/model/book_related_models/review_rate_model.dart';
import 'package:http/http.dart' as http;

class ReviewRatingApi {
  Future<List<RateProviderResponseModel>> giveReview(
      {required String bookId,
      required String description,
      required String token,
      required String rate}) async {
    try {
      var request = await http.post(
          Uri.parse("${ServerUrl.ipaddress()}rating/api/rateprovider/"),
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          },
          body: {
            'book_id': bookId,
            'rate': rate,
            'description': description
          }).timeout(const Duration(seconds: 10));

      if (request.statusCode == 200) {
        print(request.body);
        return [RateProviderResponseModel.fromMap(jsonDecode(request.body))];

        // return data;
        // return BookModel.fromMap(jsonDecode(response.b ody));
      } else {
        return [
          RateProviderResponseModel.initError(
              jsonDecode(request.body)['message'])
        ];
      }
    } on TimeoutException {
      return [RateProviderResponseModel.initError("Please Check you wifi")];
    } catch (err) {
      print(err);
      return [RateProviderResponseModel.initError("Connection Issue")];
    }
  }
}
