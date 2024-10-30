import 'package:equatable/equatable.dart';

sealed class FetchCommentEvent extends Equatable {
  const FetchCommentEvent();

  @override
  List<Object> get props => [];
}

class FetchCommentClickedEvent extends FetchCommentEvent {
  final String token;
  final String bidId;

  FetchCommentClickedEvent({
    required this.token,
    required this.bidId,
  });
}
