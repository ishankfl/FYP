import 'package:bookme/data/api/loginsignupapi/signup_api.dart';
import 'package:bookme/data/model/user_model.dart';

class SignUpUserRepository {
  final signup = SignUpApiProvider();
  Future<UserModel> signUp(
      {required String full_name,
      required String email,
      required String location,
      required String city,
      required String phonenumber,
      required String user_type,
      required String password}) {
    return signup.signUp(
        full_name: full_name,
        email: email,
        password: password,
        phonenumber: phonenumber,
        city: city,
        location: location,
        user_type: user_type);
  }

  Future<UserModel> updateUser({required UserModel model}) {
    return signup.updateUser(model: model);
  }
}
