// part of 'FetchReschedule_bloc.dart';

import 'package:equatable/equatable.dart';

sealed class RescheduleEvent extends Equatable {
  const RescheduleEvent();

  @override
  List<Object> get props => [];
}

class RescheduleClickedEvent extends RescheduleEvent {
  // final String email;

  final String start_date_time;
  final String expectedHours;
  final String token;
  final String bookId;

  // final bool rememberMe;
  const RescheduleClickedEvent({
    required this.start_date_time,
    required this.expectedHours,
    required this.token,
    required this.bookId,
  });
}
