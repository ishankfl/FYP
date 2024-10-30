import 'dart:convert';

import 'package:bookme/data/model/model_export.dart';
import 'package:equatable/equatable.dart';

sealed class BookPaymentState extends Equatable {
  const BookPaymentState();

  @override
  List<Object> get props => [];
}

class BookPaymentInitial extends BookPaymentState {}

class BookPaymentLoading extends BookPaymentState {}

class BookPaymentLoaded extends BookPaymentState {
  final PaymentModel loginModel;

  const BookPaymentLoaded({required this.loginModel});

  @override
  List<Object> get props => [loginModel];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'model': loginModel.toMap(),
    };
  }

  factory BookPaymentLoaded.fromMap(Map<String, dynamic> map) {
    try {
      return BookPaymentLoaded(
        loginModel: PaymentModel.fromMap(map['model']),
      );
    } catch (e) {
      BookPaymentInitial();
      return BookPaymentLoaded(
        loginModel: PaymentModel.fromMap(map['model']),
      );
    }
  }

  String toJson() => json.encode(toMap());

  factory BookPaymentLoaded.fromJson(String source) =>
      BookPaymentLoaded.fromMap(json.decode(source) as Map<String, dynamic>);
}

class BookPaymentError extends BookPaymentState {
  final String? message;

  const BookPaymentError({required this.message});

  @override
  List<Object> get props => [message!];
}
