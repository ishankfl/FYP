import 'package:bookme/data/api/loginsignupapi/login_api.dart';
// import 'package:bookme/data/model/login_model.dart';
import 'package:bookme/data/model/model_export.dart';

class LoginRepository {
  final login = LoginApiProvider();
  Future<LoginModel> loginUser(
      {required String email, required String password}) {
    return login.login(email: email, password: password);
  }
}
