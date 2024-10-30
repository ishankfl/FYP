import 'package:equatable/equatable.dart';

sealed class FetchBidListEvent extends Equatable {
  const FetchBidListEvent();

  @override
  List<Object> get props => [];
}

class FetchBidListClickedEvent extends FetchBidListEvent {
  final String token;

  FetchBidListClickedEvent({
    required this.token,
  });
}
