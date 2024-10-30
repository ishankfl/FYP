import 'package:bookme/logic/bloc_export.dart';
import 'package:bookme/presentation/screen/payment/view_payment_history.dart';
import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class KhaltiPaymentGateway {
  void paymentGateway (
      BuildContext context, int serviceId, int amount, String serviceName) async {
    final config = PaymentConfig(
      amount: amount,
      productIdentity: serviceId.toString(),
      productName: serviceName,
    );

    final blocContext = context; // Store a reference to the context

    try {
      await KhaltiScope.of(context).pay(
        config: config,
        preferences: [
          PaymentPreference.khalti,
          PaymentPreference.eBanking,
          PaymentPreference.connectIPS
        ],
        onSuccess: (successModel) {
          blocContext.read<BookPaymentBloc>()
              .add(BookPaymentClickedEvent(
              transactionId: successModel.idx,
              token: successModel.token,
              amount: successModel.amount,
              bookId: int.parse(successModel.productIdentity),
              serviceType: successModel.productName));
          Navigator.push(blocContext, MaterialPageRoute(builder: (builder) {
            return const PaymentHistory();
          }));
        },
        onCancel: () {},
        onFailure: (paymentFailure) {
          // Handle failure
        },
      );
    } catch (e) {
      // Handle exceptions if any
    }
  }
}
