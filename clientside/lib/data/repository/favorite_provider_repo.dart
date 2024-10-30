import 'package:bookme/data/api/bid/bid_api.dart';
import 'package:bookme/data/api/favorite_provider/favorite_provider.dart';
import 'package:bookme/data/model/bid/bid_model.dart';
import 'package:bookme/data/model/favorite_provider_model.dart';
import 'package:bookme/data/model/model_export.dart';

class FavoriteProviderRepo {
  final apiProvider = FavoriteProviderApiProvider();

  Future<FavoriteProviderModel> favorite(
      {required String? token,
      required String? serviceProvider,
      required bool? isFavorite}) {
    return apiProvider.favoriteProvider(
      isFavorite: isFavorite,
      token: token,
      serviceProvider: serviceProvider,
    );
  }

  Future<List<FavoriteProviderModel>> fetchFavoriteProviders({
    required String? token,
  }) {
    return apiProvider.fetchfavoriteProvider(
      token: token,
    );
  }
}
