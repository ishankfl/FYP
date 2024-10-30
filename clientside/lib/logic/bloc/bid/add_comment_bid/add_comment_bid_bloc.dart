import 'package:bookme/data/repository/repo_export.dart';
import 'package:bookme/logic/bloc_export.dart';

class AddBidCommentBloc
    extends HydratedBloc<AddBidCommentBtnPressed, AddBidCommentState> {
  AddBidCommentBloc({required BidRepo apiRepository})
      : super(AddBidCommentInitial()) {
    on<AddBidCommentBtnPressed>((event, emit) async {
      emit(AddBidCommentLoading());
      final model = await apiRepository.addComment(
          textContent: event.text, bidId: event.bidId, token: event.token);

      if (model[0].error != null) {
        emit(AddBidCommentError(message: model[0].error));
        return;
      }
      emit(AddBidCommentSuccess(
        model: model,
      ));
    });
  }
  @override
  void onChange(Change<AddBidCommentState> change) {
    print(
        "Current State ${change.currentState}, next state ${change.nextState}");
    super.onChange(change);
  }

  @override
  AddBidCommentState fromJson(Map<String, dynamic> json) {
    try {
      return AddBidCommentSuccess.fromMap(json);
    } catch (e) {
      return AddBidCommentInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(AddBidCommentState state) {
    if (state is AddBidCommentSuccess) {
      return state.toMap();
    }
    return {};
  }
}
