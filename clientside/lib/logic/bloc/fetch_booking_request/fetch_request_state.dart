// part of 'FetchBooking_bloc.dart';

// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:bookme/data/model/book_related_models/booking_model.dart';
import 'package:equatable/equatable.dart';

sealed class FetchBookingState extends Equatable {
  const FetchBookingState();

  @override
  List<Object> get props => [];
}

class FetchBookingInitial extends FetchBookingState {}

class FetchBookingLoading extends FetchBookingState {}

class FetchBookingLoaded extends FetchBookingState {
  List<BookModel>? bookModel;

  FetchBookingLoaded({this.bookModel});

  @override
  List<Object> get props {
    if (this.bookModel != null) {
      return [this.bookModel!];
    }
    return [];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bookModel': bookModel,
    };
  }
}

class FetchBookingError extends FetchBookingState {
  final String? message;

  const FetchBookingError({required this.message});

  @override
  List<Object> get props => [message!];
}

class FetchBookingEmpty extends FetchBookingState {}
