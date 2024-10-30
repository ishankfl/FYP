import 'package:bookme/data/model/model_export.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/api/api_export.dart';

sealed class AddBidCommentState extends Equatable {
  const AddBidCommentState();

  @override
  List<Object> get props => [];
}

class AddBidCommentInitial extends AddBidCommentState {}

class AddBidCommentLoading extends AddBidCommentState {}

class AddBidCommentSuccess extends AddBidCommentState {
  final List<BidCommentModel> model;

  const AddBidCommentSuccess({required this.model});

  @override
  List<Object> get props => [model];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'model': model,
    };
  }

  factory AddBidCommentSuccess.fromMap(Map<String, dynamic> map) {
    print(map);
    if (map.containsKey('model') && map['model'] != null) {
      return AddBidCommentSuccess(
        model: [BidCommentModel.fromMap(map['model'])],
      );
    } else {
      return AddBidCommentSuccess(model: []);
    }
  }

  String toJson() => json.encode(toMap());

  factory AddBidCommentSuccess.fromJson(String source) =>
      AddBidCommentSuccess.fromMap(json.decode(source) as Map<String, dynamic>);
}

class AddBidCommentError extends AddBidCommentState {
  final String? message;

  const AddBidCommentError({required this.message});

  @override
  List<Object> get props => [message!];
}
