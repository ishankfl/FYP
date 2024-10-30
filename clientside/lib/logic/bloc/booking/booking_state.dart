

import 'dart:convert';

import 'package:bookme/data/model/book_related_models/booking_model.dart';
import 'package:equatable/equatable.dart';

sealed class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object> get props => [];
}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingLoaded extends BookingState {
  final List<BookModel> bookModel;

  const BookingLoaded({required this.bookModel});

  @override
  List<Object> get props => [bookModel];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bookModel': bookModel,
    };
  }

  factory BookingLoaded.fromMap(Map<String, dynamic> map) {
    print(map);
    if (map.containsKey('bookModel') && map['bookModel'] != null) {
      return BookingLoaded(
        bookModel: [BookModel.fromMap(map['bookModel'])],
      );
    } else {
      return BookingLoaded(bookModel: []);
    }
  }

  String toJson() => json.encode(toMap());

  factory BookingLoaded.fromJson(String source) =>
      BookingLoaded.fromMap(json.decode(source) as Map<String, dynamic>);
}

class BookingError extends BookingState {
  final String? message;

  const BookingError({required this.message});

  @override
  List<Object> get props => [message!];
}
