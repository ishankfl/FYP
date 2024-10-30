// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bookme/data/model/model_export.dart';

class PaymentModel {
  double? amount;
  String? transactionId;
  String? token;
  BookModel? booking;
  String? serviceType;
  String? paymentType;
  String? paymentDate;
  String? error;
  String? message;
  String? detail;
  PaymentModel({
    this.amount,
    this.transactionId,
    this.token,
    this.booking,
    this.serviceType,
    this.paymentType,
    this.paymentDate,
    this.error,
    this.message,
    this.detail,
  });

  PaymentModel copyWith({
    double? amount,
    String? transactionId,
    String? token,
    BookModel? booking,
    String? serviceType,
    String? paymentType,
    String? paymentDate,
    String? error,
    String? message,
    String? detail,
  }) {
    return PaymentModel(
      amount: amount ?? this.amount,
      transactionId: transactionId ?? this.transactionId,
      token: token ?? this.token,
      booking: booking ?? this.booking,
      serviceType: serviceType ?? this.serviceType,
      paymentType: paymentType ?? this.paymentType,
      paymentDate: paymentDate ?? this.paymentDate,
      error: error ?? this.error,
      message: message ?? this.message,
      detail: detail ?? this.detail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'amount': amount,
      'transactionId': transactionId,
      'token': token,
      'booking': booking?.toMap(),
      'serviceType': serviceType,
      'paymentType': paymentType,
      'paymentDate': paymentDate,
      'error': error,
      'message': message,
      'detail': detail,
    };
  }

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      amount: map['amount'] != null ? map['amount'] as double : null,
      transactionId:
          map['transactionId'] != null ? map['transactionId'] as String : null,
      token: map['token'] != null ? map['token'] as String : null,
      booking: map['booking'] != null
          ? BookModel.fromMap(map['booking'] as Map<String, dynamic>)
          : null,
      serviceType:
          map['serviceType'] != null ? map['serviceType'] as String : null,
      paymentType:
          map['paymentType'] != null ? map['paymentType'] as String : null,
      paymentDate:
          map['paymentDate'] != null ? map['paymentDate'] as String : null,
      error: map['error'] != null ? map['error'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
      detail: map['detail'] != null ? map['detail'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentModel.fromJson(String source) =>
      PaymentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PaymentModel(amount: $amount, transactionId: $transactionId, token: $token, booking: $booking, serviceType: $serviceType, paymentType: $paymentType, paymentDate: $paymentDate, error: $error, message: $message, detail: $detail)';
  }

  @override
  bool operator ==(covariant PaymentModel other) {
    if (identical(this, other)) return true;

    return other.amount == amount &&
        other.transactionId == transactionId &&
        other.token == token &&
        other.booking == booking &&
        other.serviceType == serviceType &&
        other.paymentType == paymentType &&
        other.paymentDate == paymentDate &&
        other.error == error &&
        other.message == message &&
        other.detail == detail;
  }

  @override
  int get hashCode {
    return amount.hashCode ^
        transactionId.hashCode ^
        token.hashCode ^
        booking.hashCode ^
        serviceType.hashCode ^
        paymentType.hashCode ^
        paymentDate.hashCode ^
        error.hashCode ^
        message.hashCode ^
        detail.hashCode;
  }

  PaymentModel.initError({required String error}) {
    this.error = error;
  }
}
