import 'dart:convert';
import 'package:bookme/data/model/model_export.dart';
import 'package:equatable/equatable.dart';

sealed class FetchCommentState extends Equatable {
  const FetchCommentState();

  @override
  List<Object> get props => [];
}

class FetchCommentInitial extends FetchCommentState {}

class FetchCommentLoading extends FetchCommentState {}

class FetchCommentLoaded extends FetchCommentState {
  final List<BidCommentModel> model;

  const FetchCommentLoaded({required this.model});

  @override
  List<Object> get props => [model];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'model': model.toList(),
    };
  }

  factory FetchCommentLoaded.fromMap(Map<String, dynamic> map) {
    try {
      return FetchCommentLoaded(
        model: [BidCommentModel.fromMap(map['model'])],
      );
    } catch (e) {
      FetchCommentInitial();
      return FetchCommentLoaded(
        model: [BidCommentModel.fromMap(map['model'])],
      );
    }
  }

  String toJson() => json.encode(toMap());

  factory FetchCommentLoaded.fromJson(String source) =>
      FetchCommentLoaded.fromMap(json.decode(source) as Map<String, dynamic>);
}

class FetchCommentError extends FetchCommentState {
  final String message;

  const FetchCommentError({required this.message});

  @override
  List<Object> get props => [message];
}

class FetchCommentEmpty extends FetchCommentState {
  const FetchCommentEmpty();

  @override
  List<Object> get props => [];
}
