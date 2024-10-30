// part of 'login_bloc.dart';

import 'dart:convert';

import 'package:bookme/data/model/model_export.dart';
import 'package:bookme/data/model/user_model.dart';
import 'package:equatable/equatable.dart';

sealed class IndividualChatState extends Equatable {
  const IndividualChatState();

  @override
  List<Object> get props => [];
}

class IndividualChatInitial extends IndividualChatState {}

class IndividualChatLoading extends IndividualChatState {}

class IndividualChatLoaded extends IndividualChatState {
  final List<ChatModel> chatModel;
  // final bool rememberMe;

  const IndividualChatLoaded({required this.chatModel});

  @override
  List<Object> get props => [chatModel];

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'model': chatModel.toMap(),
  //   };
  // }

  factory IndividualChatLoaded.fromMap(Map<String, dynamic> map) {
    return IndividualChatLoaded(
      chatModel: [ChatModel.fromMap(map['model'])],
    );
  }

  // String toJson() => json.encode(toMap());

  factory IndividualChatLoaded.fromJson(String source) =>
      IndividualChatLoaded.fromMap(json.decode(source) as Map<String, dynamic>);
}

class IndividualChatError extends IndividualChatState {
  final String? error;

  IndividualChatError({required this.error}) {
    if (error == "") {
      error != "error";
    }
  }

  @override
  List<Object> get props => [error!];
}
