import 'dart:convert';

import 'package:bookme/data/model/model_export.dart';
import 'package:equatable/equatable.dart';

sealed class FetchPaymentState extends Equatable {
  const FetchPaymentState();

  @override
  List<Object> get props => [];
}

class FetchPaymentInitial extends FetchPaymentState {}

class FetchPaymentLoading extends FetchPaymentState {}

class FetchPaymentLoaded extends FetchPaymentState {
  final List<PaymentModel> model;

  const FetchPaymentLoaded({required this.model});

  @override
  List<Object> get props => [model];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'model': model.toList(),
    };
  }

  factory FetchPaymentLoaded.fromMap(Map<String, dynamic> map) {
    try {
      return FetchPaymentLoaded(
        model: [PaymentModel.fromMap(map['model'])],
      );
    } catch (e) {
      FetchPaymentInitial();
      return FetchPaymentLoaded(
        model: [PaymentModel.fromMap(map['model'])],
      );
    }
  }

  String toJson() => json.encode(toMap());

  factory FetchPaymentLoaded.fromJson(String source) =>
      FetchPaymentLoaded.fromMap(json.decode(source) as Map<String, dynamic>);
}

class FetchPaymentError extends FetchPaymentState {
  final String message;

  const FetchPaymentError({required this.message});

  @override
  List<Object> get props => [message];
}
