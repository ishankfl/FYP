// part of 'CancelBooking_bloc.dart';

import 'dart:convert';

import 'package:bookme/data/model/book_related_models/booking_model.dart';
import 'package:bookme/data/model/book_related_models/update_bookin_model.dart';
import 'package:equatable/equatable.dart';

sealed class CancelBookingState extends Equatable {
  const CancelBookingState();

  @override
  List<Object> get props => [];
}

class CancelBookingInitial extends CancelBookingState {}

class CancelBookingLoading extends CancelBookingState {}

class CancelBookingSuccess extends CancelBookingState {
  final List<BookingUpdateModel> model;

  const CancelBookingSuccess({required this.model});

  @override
  List<Object> get props => [model];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'model': model,
    };
  }

  factory CancelBookingSuccess.fromMap(dynamic data) {
    if (data is Map<String, dynamic>) {
      // Handle the case when data is a single map
      return CancelBookingSuccess(
        model: [BookingUpdateModel.fromMap(data)],
      );
    } else if (data is List<Map<String, dynamic>>) {
      // Handle the case when data is a list of maps
      return CancelBookingSuccess(
        model: data.map((map) => BookingUpdateModel.fromMap(map)).toList(),
      );
    } else {
      // Handle other cases or throw an error
      throw ArgumentError("Invalid data type");
    }
  }

  String toJson() => json.encode(toMap());

  factory CancelBookingSuccess.fromJson(String source) =>
      CancelBookingSuccess.fromMap(json.decode(source) as Map<String, dynamic>);
}

class CancelBookingError extends CancelBookingState {
  final String? message;

  const CancelBookingError({required this.message});

  @override
  List<Object> get props => [message!];
}
