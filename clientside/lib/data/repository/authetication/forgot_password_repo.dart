import 'package:bookme/data/api/api_export.dart';
import 'package:bookme/data/model/model_export.dart';

class ForgotPasswordRepository {
  final forgotPasswordApi = ForgotPasswordApiProvider();
  Future<UserModel> forgotPassword({required String email}) {
    return forgotPasswordApi.forgotPassword(email: email);
  }

  Future<UserModel> changePassword(
      {required String email, required String password}) {
    return forgotPasswordApi.changePassword(email: email, password: password);
  }
}
