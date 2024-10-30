// part of 'AcceptBooking_bloc.dart';

import 'dart:convert';
import 'package:bookme/data/model/book_related_models/update_bookin_model.dart';
import 'package:equatable/equatable.dart';

sealed class AcceptBookingState extends Equatable {
  const AcceptBookingState();

  @override
  List<Object> get props => [];
}

class AcceptBookingInitial extends AcceptBookingState {}

class AcceptBookingLoading extends AcceptBookingState {}

class AcceptBookingSuccess extends AcceptBookingState {
  final List<BookingUpdateModel> model;

  const AcceptBookingSuccess({required this.model});

  @override
  List<Object> get props => [model];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'model': model,
    };
  }

  factory AcceptBookingSuccess.fromMap(dynamic data) {
    if (data is Map<String, dynamic>) {
      // Handle the case when data is a single map
      return AcceptBookingSuccess(
        model: [BookingUpdateModel.fromMap(data)],
      );
    } else if (data is List<Map<String, dynamic>>) {
      // Handle the case when data is a list of maps
      return AcceptBookingSuccess(
        model: data.map((map) => BookingUpdateModel.fromMap(map)).toList(),
      );
    } else {
      // Handle other cases or throw an error
      throw ArgumentError("Invalid data type");
    }
  }

  String toJson() => json.encode(toMap());

  factory AcceptBookingSuccess.fromJson(String source) =>
      AcceptBookingSuccess.fromMap(json.decode(source) as Map<String, dynamic>);
}

class AcceptBookingError extends AcceptBookingState {
  final String? message;

  const AcceptBookingError({required this.message});

  @override
  List<Object> get props => [message!];
}
