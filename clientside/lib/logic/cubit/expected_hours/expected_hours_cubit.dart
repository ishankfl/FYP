import 'package:bloc/bloc.dart';
import 'package:bookme/logic/cubit/expected_hours/expected_hours_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// part 'ExpectedHours_state.dart';

class ExpectedHoursCubit extends Cubit<ExpectedHoursState> {
  ExpectedHoursCubit() : super(const ExpectedHoursState(expectedHours: 1));

  void increment(BuildContext context) {
    emit(ExpectedHoursState(expectedHours: state.expectedHours + 1));
    print("In cubit");
    print(state.expectedHours);
  }

  void decrement(BuildContext context) {
    if (state.expectedHours <= 0) {
      emit(ExpectedHoursState(expectedHours: 0));
    } else {
      emit(ExpectedHoursState(expectedHours: state.expectedHours - 1));
    }
  }
}
