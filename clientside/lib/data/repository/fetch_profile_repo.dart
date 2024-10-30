import 'package:bookme/data/api/fetch_profile.dart';
import 'package:bookme/data/model/user_model.dart';

class FetchProfileRepository {
  FetchUserApiProvider apiProvider = FetchUserApiProvider();
  Future<List<UserModel>> getUserProfile({required String token}) async {
    return await apiProvider.fetchProfile(token: token);
  }
}
