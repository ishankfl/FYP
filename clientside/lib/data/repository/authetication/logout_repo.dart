import 'package:bookme/data/api/loginsignupapi/logout_api.dart';
import 'package:bookme/data/model/logout_response_model.dart';

class LogoutRespository {
  final login = LogoutApiProvider();

  Future<LogoutResponseModel> logOutUser({required String token}) {
    return login.logOut(token: token);
  }
}
