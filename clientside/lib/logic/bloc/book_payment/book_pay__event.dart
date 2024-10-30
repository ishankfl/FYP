import 'package:equatable/equatable.dart';

sealed class BookPaymentEvent extends Equatable {
  const BookPaymentEvent();

  @override
  List<Object> get props => [];
}

class BookPaymentClickedEvent extends BookPaymentEvent {
  final String transactionId;
  final String token;
  final int amount;
  final int bookId;
  final String serviceType;
  BookPaymentClickedEvent(
      {required this.transactionId,
      required this.token,
      required this.amount,
      required this.bookId,
      required this.serviceType});
}
