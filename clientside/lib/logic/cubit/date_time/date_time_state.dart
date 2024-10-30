import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DateState extends Equatable {
  // int counter;
  DateTime? date;

  DateState({this.date});

  @override
  List<Object> get props {
    if (date != null) {
      return [date!];
    }
    return [];
  }
}

class TimeState extends Equatable {
  // int counter;
  TimeOfDay? time;

  TimeState({this.time});

  @override
  List<Object> get props {
    if (time != null) {
      return [time!];
    }
    return [];
  }
}
