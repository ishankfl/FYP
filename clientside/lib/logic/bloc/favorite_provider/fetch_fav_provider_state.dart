// part of 'FetchFavProvider_bloc.dart';

import 'dart:convert';

import 'package:bookme/data/model/book_related_models/booking_model.dart';
import 'package:bookme/data/model/favorite_provider_model.dart';
import 'package:equatable/equatable.dart';

sealed class FetchFavProviderState extends Equatable {
  const FetchFavProviderState();

  @override
  List<Object> get props => [];
}

class FetchFavProviderInitial extends FetchFavProviderState {}

class FetchFavProviderLoading extends FetchFavProviderState {}

class FetchFavProviderLoaded extends FetchFavProviderState {
  final List<FavoriteProviderModel> bookModel;

  const FetchFavProviderLoaded({required this.bookModel});

  @override
  List<Object> get props => [bookModel];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bookModel': bookModel,
    };
  }

  factory FetchFavProviderLoaded.fromMap(dynamic data) {
    if (data is Map<String, dynamic>) {
      // Handle the case when data is a single map
      return FetchFavProviderLoaded(
        bookModel: [FavoriteProviderModel.fromMap(data)],
      );
    } else if (data is List<Map<String, dynamic>>) {
      // Handle the case when data is a list of maps
      return FetchFavProviderLoaded(
        bookModel:
            data.map((map) => FavoriteProviderModel.fromMap(map)).toList(),
      );
    } else {
      // Handle other cases or throw an error
      throw ArgumentError("Invalid data type");
    }
  }

  String toJson() => json.encode(toMap());

  factory FetchFavProviderLoaded.fromJson(String source) =>
      FetchFavProviderLoaded.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

class FetchFavProviderError extends FetchFavProviderState {
  final String? message;

  const FetchFavProviderError({required this.message});

  @override
  List<Object> get props => [message!];
}

class FetchFavProviderEmpty extends FetchFavProviderState {
  const FetchFavProviderEmpty();

  @override
  List<Object> get props => [];
}
