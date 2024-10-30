import 'package:equatable/equatable.dart';

sealed class BidCommentEvent extends Equatable {
  const BidCommentEvent();

  @override
  List<Object> get props => [];
}

class AddBidCommentBtnPressed extends BidCommentEvent {
  // final String email;
  final String bidId;
  final String text;
  final String token;
  // final bool rememberMe;
  const AddBidCommentBtnPressed({
    required this.bidId,
    required this.text,
    required this.token,
  });
}
