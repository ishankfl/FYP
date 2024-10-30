import 'dart:convert';
import 'package:bookme/data/model/book_related_models/review_rate_model.dart';
import 'package:bookme/data/model/book_related_models/update_bookin_model.dart';
import 'package:equatable/equatable.dart';

sealed class AddReviewState extends Equatable {
  const AddReviewState();

  @override
  List<Object> get props => [];
}

class AddReviewInitial extends AddReviewState {}

class AddReviewLoading extends AddReviewState {}

class AddReviewLoaded extends AddReviewState {
  final List<RateProviderResponseModel> updateModel;

  const AddReviewLoaded({required this.updateModel});

  @override
  List<Object> get props => [updateModel];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'reviewModel': updateModel,
    };
  }

  factory AddReviewLoaded.fromMap(Map<String, dynamic> map) {
    print(map);
    if (map.containsKey('updateModel') && map['updateModel'] != null) {
      return AddReviewLoaded(
        updateModel: [RateProviderResponseModel.fromMap(map['updateModel'])],
      );
    } else {
      return AddReviewLoaded(updateModel: []);
    }
  }

  String toJson() => json.encode(toMap());

  factory AddReviewLoaded.fromJson(String source) =>
      AddReviewLoaded.fromMap(json.decode(source) as Map<String, dynamic>);
}

class AddReviewError extends AddReviewState {
  final String? message;

  const AddReviewError({required this.message});

  @override
  List<Object> get props => [message!];
}
