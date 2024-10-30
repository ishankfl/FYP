import 'dart:convert';
import 'package:bookme/data/model/book_related_models/update_bookin_model.dart';
import 'package:equatable/equatable.dart';

sealed class RescheduleState extends Equatable {
  const RescheduleState();

  @override
  List<Object> get props => [];
}

class RescheduleInitial extends RescheduleState {}

class RescheduleLoading extends RescheduleState {}

class RescheduleLoaded extends RescheduleState {
  final List<BookingUpdateModel> updateModel;

  const RescheduleLoaded({required this.updateModel});

  @override
  List<Object> get props => [updateModel];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'updateModel': updateModel,
    };
  }

  factory RescheduleLoaded.fromMap(Map<String, dynamic> map) {
    print(map);
    if (map.containsKey('updateModel') && map['updateModel'] != null) {
      return RescheduleLoaded(
        updateModel: [BookingUpdateModel.fromMap(map['updateModel'])],
      );
    } else {
      return RescheduleLoaded(updateModel: []);
    }
  }

  String toJson() => json.encode(toMap());

  factory RescheduleLoaded.fromJson(String source) =>
      RescheduleLoaded.fromMap(json.decode(source) as Map<String, dynamic>);
}

class RescheduleError extends RescheduleState {
  final String? message;

  const RescheduleError({required this.message});

  @override
  List<Object> get props => [message!];
}
