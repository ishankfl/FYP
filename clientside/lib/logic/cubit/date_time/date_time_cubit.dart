import 'package:bookme/logic/cubit/date_time/date_time_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DateCubit extends Cubit<DateState> {
  DateCubit() : super(DateState());
  void addition({required DateTime date}) {
    // print("In cubit");
    // print(date);
    emit(DateState(date: date));
  }

  void timeChange({required DateTime time}) {}
}

class TimeCubit extends Cubit<TimeState> {
  TimeCubit() : super(TimeState());
  void addition({required TimeOfDay time}) {
    // print("In cubit");
    print(time);
    emit(TimeState(time: time));
  }
}
