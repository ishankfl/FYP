// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChartModel {
  double? total_income;
  int? payment_date__month;
  int? error;
  int? success;
  String? message;
  ChartModel({
    this.total_income,
    this.payment_date__month,
    this.error,
    this.success,
    this.message,
  });
  ChartModel.initError(this.message);
  ChartModel copyWith({
    double? total_income,
    int? payment_date__month,
    int? error,
    int? success,
    String? message,
  }) {
    return ChartModel(
      total_income: total_income ?? this.total_income,
      payment_date__month: payment_date__month ?? this.payment_date__month,
      error: error ?? this.error,
      success: success ?? this.success,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total_income': total_income,
      'payment_date__month': payment_date__month,
      'error': error,
      'success': success,
      'message': message,
    };
  }

  factory ChartModel.fromMap(Map<String, dynamic> map) {
    return ChartModel(
      total_income:
          map['total_income'] != null ? map['total_income'] as double : null,
      payment_date__month: map['payment_date__month'] != null
          ? map['payment_date__month'] as int
          : null,
      error: map['error'] != null ? map['error'] as int : null,
      success: map['success'] != null ? map['success'] as int : null,
      message: map['message'] != null ? map['message'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChartModel.fromJson(String source) =>
      ChartModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChartModel(total_income: $total_income, payment_date__month: $payment_date__month, error: $error, success: $success, message: $message)';
  }

  @override
  bool operator ==(covariant ChartModel other) {
    if (identical(this, other)) return true;

    return other.total_income == total_income &&
        other.payment_date__month == payment_date__month &&
        other.error == error &&
        other.success == success &&
        other.message == message;
  }

  @override
  int get hashCode {
    return total_income.hashCode ^
        payment_date__month.hashCode ^
        error.hashCode ^
        success.hashCode ^
        message.hashCode;
  }
}
