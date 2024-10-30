import 'package:bookme/data/api/api_export.dart';
import 'package:bookme/data/api/booking_apis/review_rating_api.dart';
import 'package:bookme/data/model/book_related_models/review_rate_model.dart';
import 'package:bookme/data/model/model_export.dart';

class ReviewRateRepository {
  final payment = ReviewRatingApi();
  Future<List<RateProviderResponseModel>> giveReview({
    required String description,
    required String token,
    required String rate,
    required String bookId,
  }) {
    return payment.giveReview(
        token: token, bookId: bookId, description: description, rate: rate);
  }
}
