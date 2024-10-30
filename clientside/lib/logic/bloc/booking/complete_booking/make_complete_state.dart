import 'dart:convert';
import 'package:bookme/data/model/book_related_models/update_bookin_model.dart';
import 'package:equatable/equatable.dart';

sealed class MakeCompleteState extends Equatable {
  const MakeCompleteState();

  @override
  List<Object> get props => [];
}

class MakeCompleteInitial extends MakeCompleteState {}

class MakeCompleteLoading extends MakeCompleteState {}

class MakeCompleteLoaded extends MakeCompleteState {
  final List<BookingUpdateModel> updateModel;

  const MakeCompleteLoaded({required this.updateModel});

  @override
  List<Object> get props => [updateModel];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'updateModel': updateModel,
    };
  }

  factory MakeCompleteLoaded.fromMap(Map<String, dynamic> map) {
    print(map);
    if (map.containsKey('updateModel') && map['updateModel'] != null) {
      return MakeCompleteLoaded(
        updateModel: [BookingUpdateModel.fromMap(map['updateModel'])],
      );
    } else {
      return MakeCompleteLoaded(updateModel: []);
    }
  }

  String toJson() => json.encode(toMap());

  factory MakeCompleteLoaded.fromJson(String source) =>
      MakeCompleteLoaded.fromMap(json.decode(source) as Map<String, dynamic>);
}

class MakeCompleteError extends MakeCompleteState {
  final String? message;

  const MakeCompleteError({required this.message});

  @override
  List<Object> get props => [message!];
}
