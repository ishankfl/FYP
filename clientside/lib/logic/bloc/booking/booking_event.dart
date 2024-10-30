// part of 'FetchBooking_bloc.dart';

import 'package:equatable/equatable.dart';

sealed class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object> get props => [];
}

class BookingClickedEvent extends BookingEvent {
  // final String email;
  final String service;
  final String provider;
  final String start_date_time;
  final String expectedHours;
  final String longitude;
  final String latitude;
  final String token;
  final String location;
  final String address;
  // final bool rememberMe;
  const BookingClickedEvent(
      {required this.address,
      required this.service,
      required this.provider,
      required this.start_date_time,
      required this.expectedHours,
      required this.longitude,
      required this.latitude,
      required this.token,
      required this.location});
}
