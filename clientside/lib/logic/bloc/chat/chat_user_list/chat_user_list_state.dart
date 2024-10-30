// part of 'login_bloc.dart';

import 'dart:convert';

import 'package:bookme/data/model/user_model.dart';
import 'package:equatable/equatable.dart';

sealed class ChatUserListState extends Equatable {
  const ChatUserListState();

  @override
  List<Object> get props => [];
}

class ChatUserListInitial extends ChatUserListState {}

class ChatUserListLoading extends ChatUserListState {}

class ChatUserListLoaded extends ChatUserListState {
  final List<UserModel> userModel;
  // final bool rememberMe;

  const ChatUserListLoaded({required this.userModel});

  @override
  List<Object> get props => [userModel];

  factory ChatUserListLoaded.fromMap(Map<String, dynamic> map) {
    return ChatUserListLoaded(
      userModel: [UserModel.fromMap(map['model'])],
    );
  }

  // String toJson() => json.encode(toMap());

  factory ChatUserListLoaded.fromJson(String source) =>
      ChatUserListLoaded.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ChatUserListError extends ChatUserListState {
  final String? error;

  ChatUserListError({required this.error}) {
    if (error == "") {
      error != "error";
    }
  }

  @override
  List<Object> get props => [error!];
}

class ChatUserListEmpty extends ChatUserListState {
  final bool? isempty;

  ChatUserListEmpty({required this.isempty}) {
    // isempty=true;
  }

  @override
  List<Object> get props => [isempty!];
}
