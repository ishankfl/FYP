// ignore_for_file: must_be_immutable

import 'package:bookme/data/model/notification_model.dart';
import 'package:equatable/equatable.dart';

sealed class FetchNotificationState extends Equatable {
  const FetchNotificationState();
  @override
  List<Object> get props => [];
}

class FetchNotificationInitial extends FetchNotificationState {}

class FetchNotificationLoading extends FetchNotificationState {}

class FetchNotificationLoaded extends FetchNotificationState {
  List<NotificationModel> model;

  FetchNotificationLoaded({required this.model});

  @override
  List<Object> get props {
    return [model];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'model': model,
    };
  }
}

class FetchNotificationError extends FetchNotificationState {
  final String? message;

  const FetchNotificationError({required this.message});

  @override
  List<Object> get props => [message!];
}

class FetchNotificationEmpty extends FetchNotificationState {}
