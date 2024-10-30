import 'package:bookme/data/api/api_export.dart';
import 'package:bookme/data/model/model_export.dart';

class PaymentRepository {
  final payment = PaymentApiProivider();
  Future<PaymentModel> bookPayment(
      {required String transactionId,
      required String token,
      required int amount,
      required int bookId,
      required String serviceType}) {
    return payment.bookPayment(
        transactionId: transactionId,
        token: token,
        amount: amount,
        bookId: bookId,
        serviceType: serviceType);
  }

  Future<List<PaymentModel>> fetchPaymentDetails({
    required String token,
  }) {
    return payment.fetchPaymentDetails(
      token: token,
    );
  }
}
