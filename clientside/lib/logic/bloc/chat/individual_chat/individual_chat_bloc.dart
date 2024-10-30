import 'package:bookme/data/repository/repo_export.dart';
import 'package:bookme/logic/bloc_export.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
// part 'user_signup_event.dart';
// part 'user_signup_state.dart';

class IndividualChatBloc
    extends Bloc<IndividualChatEvent, IndividualChatState> {
  IndividualChatBloc({required ChatUserListRepo repo})
      : super(IndividualChatInitial()) {
    on<FetchIndividualChatEvent>((event, emit) async {
      emit(IndividualChatLoading());
      try {
        final chatUserList =
            await repo.individualChat(token: event.token, toId: event.toId);
        if (chatUserList[0].error != null) {
          emit(IndividualChatError(error: chatUserList[0].message));
          return;
        }
        emit(IndividualChatLoaded(
          chatModel: chatUserList,
        ));
      } catch (exception) {
        emit(IndividualChatError(error: "Is your device is offline?"));
      }
    });
  }
  @override
  void onChange(Change<IndividualChatState> change) {
    print(
        "Current State ${change.currentState}, next state ${change.nextState}");
    super.onChange(change);
    // print(super.storageToken);
  }

  @override
  IndividualChatState fromJson(Map<String, dynamic> json) {
    try {
      print(json);
      return IndividualChatLoaded.fromMap(json);
    } catch (e) {
      return IndividualChatInitial();
    }
  }

  @override
  List? toJson(IndividualChatState state) {
    if (state is IndividualChatLoaded) {
      return state.chatModel.toList();
    }
    return [];
  }
}
