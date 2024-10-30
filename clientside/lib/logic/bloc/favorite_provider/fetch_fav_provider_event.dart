// part of 'FetchFavProvider_bloc.dart';

import 'package:equatable/equatable.dart';

sealed class FetchFavProviderEvent extends Equatable {
  const FetchFavProviderEvent();

  @override
  List<Object> get props => [];
}

class FetchFavProviderDetailsClickedEvent extends FetchFavProviderEvent {
  // final String email;
  final String token;
  // final bool rememberMe;
  const FetchFavProviderDetailsClickedEvent({required this.token});
}

class ClearFetchPoviderEvent extends FetchFavProviderEvent {}
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
