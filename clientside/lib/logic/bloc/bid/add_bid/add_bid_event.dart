// part of 'FetchBooking_bloc.dart';

import 'package:equatable/equatable.dart';

sealed class BidEvent extends Equatable {
  const BidEvent();

  @override
  List<Object> get props => [];
}

class AddBidClickedEvent extends BidEvent {
  // final String email;
  final int service;
  final String textcontent;
  final String image;
  final double lon;
  final double lat;
  final String location;
  final String token;
  final String amount;
  // final bool rememberMe;
  const AddBidClickedEvent(
      {required this.service,
      required this.textcontent,
      required this.image,
      required this.lon,
      required this.lat,
      required this.location,
      required this.amount,
      required this.token});
}
