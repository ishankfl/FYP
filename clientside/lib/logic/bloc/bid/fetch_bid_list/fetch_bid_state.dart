import 'dart:convert';
import 'package:bookme/data/model/model_export.dart';
import 'package:equatable/equatable.dart';

sealed class FetchBidListState extends Equatable {
  const FetchBidListState();

  @override
  List<Object> get props => [];
}

class FetchBidListInitial extends FetchBidListState {}

class FetchBidListLoading extends FetchBidListState {}

class FetchBidListLoaded extends FetchBidListState {
  final List<BidModel> loginModel;

  const FetchBidListLoaded({required this.loginModel});

  @override
  List<Object> get props => [loginModel];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'model': loginModel.toList(),
    };
  }

  factory FetchBidListLoaded.fromMap(Map<String, dynamic> map) {
    try {
      return FetchBidListLoaded(
        loginModel: [BidModel.fromMap(map['model'])],
      );
    } catch (e) {
      FetchBidListInitial();
      return FetchBidListLoaded(
        loginModel: [BidModel.fromMap(map['model'])],
      );
    }
  }

  String toJson() => json.encode(toMap());

  factory FetchBidListLoaded.fromJson(String source) =>
      FetchBidListLoaded.fromMap(json.decode(source) as Map<String, dynamic>);
}

class FetchBidListError extends FetchBidListState {
  final String message;

  const FetchBidListError({required this.message});

  @override
  List<Object> get props => [message];
}


class FetchBidListEmpty extends FetchBidListState {
  const FetchBidListEmpty();

  @override
  List<Object> get props => [];
}
