import 'dart:convert';
import 'dart:io';
import 'package:bookme/data/model/loginsignupmodel/provider_signup_responsemodel.dart';
import 'package:http/http.dart' as http;
import 'package:bookme/constant/constant_export.dart';

// class ProviderSignUpApi {
//   Future<ProviderSignupModel> signUp({
//     required String email,
//     required String service_type,
//     required String experience,
//     required File? profile,
//     required File? certificate,
//   }) async {
//     try {
//       print("Inside of the login");
//       final response = await http.post(
//         Uri.parse("${ServerUrl.ipaddress()}account/api/login/"),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode({
//           'email': email,
//           'service_type': service_type,
//           'experience': experience,
//           'profile': profile,
//           'certificate': certificate
//         }),
//       );

//       if (response.statusCode == 200) {
//         print("Response login 200 success");
//         print(response.body);
//         return ProviderSignupModel.fromMap(jsonDecode(response.body));
//       } else if (response.statusCode == 500) {
//         return ProviderSignupModel.InitError("Server error occurs");
//       } else {
//         print('Request failed with status: ${response.statusCode}');
//         return ProviderSignupModel.InitError("Invalid Email or Password");
//       }
//     } catch (err) {
//       print(err);
//       print("Error on code");
//       return ProviderSignupModel.InitError("Connection Issue");
//     }
//   }
// }
class ProviderSignUpApi {
  Future<ProviderSignupModel> signUp({
    required String email,
    required String service_type,
    required String experience,
    required File? profile,
    required File? certificate,
  }) async {
    try {
      var uri =
          Uri.parse("${ServerUrl.ipaddress()}account/api/service-provider/");
      var request = http.MultipartRequest("POST", uri);
      Map<String, String> data = {
        'email': email,
        'service_type': service_type,
        'experience': experience
      };
      request.fields.addAll(data);
      request.files.add(
          await http.MultipartFile.fromPath('certificate', certificate!.path));
      request.files
          .add(await http.MultipartFile.fromPath('profile', profile!.path));
      http.StreamedResponse response = await request.send();
      print(response.statusCode);

      if (response.statusCode == 200) {
        print("Response login 200 success");
        print(response.stream.toStringStream());
        // print()
        String streamContent =
            await response.stream.transform(utf8.decoder).join();
        print(streamContent);
        return ProviderSignupModel.fromMap(jsonDecode(streamContent));
      } else if (response.statusCode == 500) {
        return ProviderSignupModel.InitError("Server error occurs");
      } else {
        print('Request failed with status: ${response.statusCode}');
        return ProviderSignupModel.InitError("Invalid Email or Password");
      }
    } catch (err) {
      print(err);
      print("error");
      rethrow;
    }
  }
}
