import 'package:bookme/data/api/loginsignupapi/verification_api.dart';
import 'package:bookme/data/model/loginsignupmodel/verification_response_model.dart';

class VerificationResponseRepository {
  final signup = VerificationApiProvider();
  Future<VerificationResponseModel> verifyUser({
    required String entered_otp,
    required String email,
    required String secret_code,
    required String is_forgot_password,
  }) {
    print("THis is repooooooooooooooooooooo");
    return signup.verifyUser(
      is_forgot_password: is_forgot_password,
      secret_code: secret_code,
      otp_code: entered_otp,
      email: email,
    );
  }
}
