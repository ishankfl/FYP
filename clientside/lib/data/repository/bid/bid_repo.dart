import 'package:bookme/data/api/bid/bid_api.dart';
import 'package:bookme/data/model/bid/bid_model.dart';
import 'package:bookme/data/model/model_export.dart';

class BidRepo {
  final apiProvider = BidApiProvider();
  Future<List<BidModel>> addBidRepo(
      {required int? service,
      required String? textcontent,
      required String? image,
      required double? lon,
      required double? lat,
      required String? location,
      required String amount,
      required String? token}) {
    return apiProvider.addBidApi(
        service: service,
        textcontent: textcontent,
        image: image,
        lon: lon,
        lat: lat,
        location: location,
        amount: amount,
        token: token);
  }

  Future<List<BidModel>> fetchBidList({required String? token}) {
    return apiProvider.fetchBidList(token: token);
  }

  Future<List<BidCommentModel>> addComment(
      {required String? token,
      required String? bidId,
      required String? textContent}) {
    return apiProvider.addCommentApi(
        token: token, bidId: bidId, textcontent: textContent);
  }

  Future<List<BidCommentModel>> fetchCommnet(
      {required String? token, required String? bidId}) {
    return apiProvider.fetchComment(
      token: token,
      bidId: bidId,
    );
  }
}
