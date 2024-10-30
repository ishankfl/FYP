import 'package:bookme/data/model/model_export.dart';
import 'package:bookme/data/api/api_export.dart';
import 'package:bookme/data/api/api_export.dart' as http;
// import 'package:http/http.dart' as http;

class PaymentApiProivider {
  Future<PaymentModel> bookPayment(
      {required String transactionId,
      required String token,
      required int amount,
      required int bookId,
      required String serviceType}) async {
    try {
      print("Inside of the payment api");
      var response = await http
          .post(
            Uri.parse("${ServerUrl.ipaddress()}payment/api/payment/"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              'transactionId': transactionId,
              'token': token,
              'amount': amount,
              'bookId': bookId,
              'serviceType': serviceType
            }),
          )
          .timeout(const Duration(seconds: 8));
      print("responssssssssss");
      print(response.body);
      if (response.statusCode == 200) {
        print("Response login 200 success");
        print(response.body);
        return PaymentModel.fromMap(jsonDecode(response.body));
      } else {
        // print('Request failed with status: ${response.statusCode}');
        return PaymentModel.initError(error: "Invalid Email or Password");
      }
    } on TimeoutException {
      return PaymentModel.initError(error: "Please Check you wifi");
    } catch (err) {
      // print(err);
      // print("Error on code");
      return PaymentModel.initError(error: "Connection Issue");
    }
  }

  Future<List<PaymentModel>> fetchPaymentDetails({
    required String token,
  }) async {
    try {
      print("Inside of the payment api");
      var response = await http.get(
        Uri.parse("${ServerUrl.ipaddress()}payment/api/payment/"),
        headers: <String, String>{
          "Accept": "application/json",
          "Content-Type": "text/plain",
          "Authorization": "Bearer $token",
        },
      ).timeout(const Duration(seconds: 8));
      print("responssssssssss");
      print(response.body);
      if (response.statusCode == 200) {
        List<PaymentModel> data = List.from(jsonDecode(response.body))
            .map((e) => PaymentModel.fromMap(e))
            .toList();
        print("Response login 200 success");
        print(response.body);
        return data;
      } else {
        // print('Request failed with status: ${response.statusCode}');
        return [PaymentModel.initError(error: "Invalid Email or Password")];
      }
    } on TimeoutException {
      return [PaymentModel.initError(error: "Please Check you wifi")];
    } catch (err) {
      return [PaymentModel.initError(error: "Connection Issue")];
    }
  }
}
