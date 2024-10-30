// part of 'FetchBooking_bloc.dart';

import 'package:equatable/equatable.dart';

sealed class FetchBookingEvent extends Equatable {
  const FetchBookingEvent();

  @override
  List<Object> get props => [];
}

class FetchBookingDetailsClickedEvent extends FetchBookingEvent {
  // final String email;
  final String token;
  // final bool rememberMe;
  const FetchBookingDetailsClickedEvent({required this.token});
}

class ClearBookingDetailsClickedEvent extends FetchBookingEvent {}
// class BookingClickedEvent extends BookingEvent {
//   // final String email;
//   final String service;
//   final String provider;
//   final String start_date_time;
//   final String expectedHours;
//   final String longitude;
//   final String latitude;
//   final String token;
//   final String location;
//   // final bool rememberMe;
//   const BookingClickedEvent(
//       {required this.service,
//       required this.provider,
//       required this.start_date_time,
//       required this.expectedHours,
//       required this.longitude,
//       required this.latitude,
//       required this.token,
//       required this.location});
// }
