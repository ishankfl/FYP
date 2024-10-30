import 'package:equatable/equatable.dart';

sealed class FetchPaymentEvent extends Equatable {
  const FetchPaymentEvent();

  @override
  List<Object> get props => [];
}

class FetchPaymentClickedEvent extends FetchPaymentEvent {
  final String token;

  FetchPaymentClickedEvent({
    required this.token,
  });
}
