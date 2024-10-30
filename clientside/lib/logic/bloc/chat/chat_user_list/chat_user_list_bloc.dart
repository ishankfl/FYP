import 'dart:convert';
import 'package:bookme/data/model/user_model.dart';
import 'package:bookme/data/repository/chat/chat_user_list_repo.dart';
import 'package:bookme/data/repository/authetication/usersignup_repo.dart';
import 'package:bookme/logic/bloc/chat/chat_user_list/chat_user_list_event.dart';
import 'package:bookme/logic/bloc/chat/chat_user_list/chat_user_list_state.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
// part 'user_signup_event.dart';
// part 'user_signup_state.dart';

class ChatUserListBloc extends Bloc<ChatUserListEvent, ChatUserListState> {
  ChatUserListBloc({required ChatUserListRepo repo})
      : super(ChatUserListInitial()) {
    on<FetchChatUserListEvent>((event, emit) async {
      emit(ChatUserListLoading());
      try {
        final chatUserList = await repo.fetchBooking(token: event.token);
        print(chatUserList);
        print("Chat user list");
        if (chatUserList.isEmpty) {
          emit(ChatUserListEmpty(isempty: true));
          return;
        }
        if (chatUserList[0].error != null) {
          emit(ChatUserListError(error: chatUserList[0].message));
          return;
        }
        if (chatUserList.isEmpty) {
          emit(ChatUserListEmpty(isempty: true));
        }
        emit(ChatUserListLoaded(
          userModel: chatUserList,
        ));
      } catch (exception) {
        emit(ChatUserListError(error: "Is your device is offline?"));
      }
    });
  }
  @override
  void onChange(Change<ChatUserListState> change) {
    print(
        "Current State ${change.currentState}, next state ${change.nextState}");
    super.onChange(change);
    // print(super.storageToken);
  }

  @override
  ChatUserListState fromJson(Map<String, dynamic> json) {
    try {
      print(json);
      return ChatUserListLoaded.fromMap(json);
    } catch (e) {
      return ChatUserListInitial();
    }
  }

  @override
  List? toJson(ChatUserListState state) {
    if (state is ChatUserListLoaded) {
      return state.userModel.toList();
    }
    return [];
  }
}
