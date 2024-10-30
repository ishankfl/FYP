import 'dart:io';
import 'package:bookme/data/api/loginsignupapi/signupprovider_api.dart';
import 'package:bookme/data/model/loginsignupmodel/provider_signup_responsemodel.dart';

class ProviderSignupRepository {
  final signup = ProviderSignUpApi();
  Future<ProviderSignupModel> signUp(
      {required String email,
      required String service_type,
      required String experience,
      File? profile,
      required File? certificate}) {
    return signup.signUp(
        email: email,
        service_type: service_type,
        experience: experience,
        profile: profile,
        certificate: certificate);
  }
}
