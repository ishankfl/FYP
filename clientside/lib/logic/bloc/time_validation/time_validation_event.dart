// part of 'fetch_profile_bloc.dart';
import 'package:equatable/equatable.dart';

sealed class TimeValidationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TimeValidationHit extends TimeValidationEvent {
  final String token;
  final int providerId;
  final String date_time;
  final String expectedHours;
  TimeValidationHit(
      {required this.expectedHours,
      required this.token,
      required this.providerId,
      required this.date_time})
      : super();

  @override
  List<Object> get props => [token, providerId, date_time];
}
