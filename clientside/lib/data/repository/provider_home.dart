import 'package:bookme/data/api/api_export.dart';
import 'package:bookme/data/api/bid/bid_api.dart';
import 'package:bookme/data/api/favorite_provider/favorite_provider.dart';
import 'package:bookme/data/api/provider_home/provider_home_api.dart';
import 'package:bookme/data/model/bid/bid_model.dart';
import 'package:bookme/data/model/chart_model.dart';
import 'package:bookme/data/model/favorite_provider_model.dart';
import 'package:bookme/data/model/model_export.dart';
import 'package:bookme/data/model/request_count_model.dart';

class ProviderHomeRepo {
  final apiProvider = ProviderHomeApi();

  Future<List<ChartModel>> fetchChartData({
    required String? token,
  }) {
    return apiProvider.fetchChartDetails(
      token: token!,
    );
  }

  Future<List<RequestCountModel>> fetchRequestCount({
    required String? token,
  }) {
    return apiProvider.fetchRequestCount(
      token: token!,
    );
  }
}
