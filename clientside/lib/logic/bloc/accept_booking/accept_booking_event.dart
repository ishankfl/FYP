// part of 'AcceptBooking_bloc.dart';

import 'package:equatable/equatable.dart';

sealed class AcceptBookingEvent extends Equatable {
  const AcceptBookingEvent();

  @override
  List<Object> get props => [];
}

class AcceptBookingDetailsClickedEvent extends AcceptBookingEvent {
  // final String email;
  final String token;
  final String bookId;
  // final bool rememberMe;
  const AcceptBookingDetailsClickedEvent(
      {required this.token, required this.bookId});
}

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
