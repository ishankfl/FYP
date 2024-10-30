// part of 'ExpectedHours_cubit.dart';

import 'package:equatable/equatable.dart';

class ExpectedHoursState extends Equatable {
  final int expectedHours;
  const ExpectedHoursState({required this.expectedHours});

  @override
  List<Object> get props => [expectedHours];
}
