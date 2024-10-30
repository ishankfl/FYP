import 'dart:convert';
import 'package:bookme/data/model/chart_model.dart';
import 'package:equatable/equatable.dart';

sealed class ChartState extends Equatable {
  const ChartState();

  @override
  List<Object> get props => [];
}

class ChartInitial extends ChartState {}

class ChartLoading extends ChartState {}

class ChartLoaded extends ChartState {
  final List<ChartModel> bookModel;

  const ChartLoaded({required this.bookModel});

  @override
  List<Object> get props => [bookModel];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bookModel': bookModel,
    };
  }

  factory ChartLoaded.fromMap(Map<String, dynamic> map) {
    // print(map);
    if (map.containsKey('bookModel') && map['bookModel'] != null) {
      return ChartLoaded(
        bookModel: [ChartModel.fromMap(map['bookModel'])],
      );
    } else {
      return const ChartLoaded(bookModel: []);
    }
  }

  String toJson() => json.encode(toMap());

  factory ChartLoaded.fromJson(String source) =>
      ChartLoaded.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ChartError extends ChartState {
  final String? message;

  const ChartError({required this.message});

  @override
  List<Object> get props => [message!];
}
