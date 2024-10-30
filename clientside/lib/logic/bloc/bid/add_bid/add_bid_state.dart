import 'dart:convert';
import 'package:bookme/data/model/bid/bid_model.dart';
import 'package:equatable/equatable.dart';

sealed class AddBidState extends Equatable {
  const AddBidState();
  @override
  List<Object> get props => [];
}

class AddBidInitial extends AddBidState {}

class AddBidLoading extends AddBidState {}

class AddBidSuccess extends AddBidState {
  final List<BidModel> model;

  const AddBidSuccess({required this.model});

  @override
  List<Object> get props => [model];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'model': model,
    };
  }

  factory AddBidSuccess.fromMap(Map<String, dynamic> map) {
    print(map);
    if (map.containsKey('model') && map['model'] != null) {
      return AddBidSuccess(
        model: [BidModel.fromMap(map['model'])],
      );
    } else {
      return AddBidSuccess(model: []);
    }
  }

  String toJson() => json.encode(toMap());

  factory AddBidSuccess.fromJson(String source) =>
      AddBidSuccess.fromMap(json.decode(source) as Map<String, dynamic>);
}

class AddBidError extends AddBidState {
  final String? message;

  const AddBidError({required this.message});

  @override
  List<Object> get props => [message!];
}
