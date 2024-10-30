import 'package:bookme/data/repository/bid/bid_repo.dart';
import 'package:bookme/logic/bloc_export.dart';

class FetchCommentBloc
    extends HydratedBloc<FetchCommentEvent, FetchCommentState> {
  FetchCommentBloc({required BidRepo apiRepository})
      : super(FetchCommentInitial()) {
    on<FetchCommentClickedEvent>((event, emit) async {
      // try {
      emit(FetchCommentLoading());
      final model = await apiRepository.fetchCommnet(
          token: event.token, bidId: event.bidId);

      if (model.isEmpty) {
        emit(const FetchCommentEmpty());
        return;
      }

      if (model[0].error != null) {
        emit(FetchCommentError(message: model[0].error!));
        return;
      }
      emit(FetchCommentLoaded(
        model: model,
      ));
      // } catch (exe) {
      //   print(exe);
      //   emit(const FetchCommentError(
      //       message: "Failed to fetch data, is your device online?"));
      // }
    });
  }
  @override
  void onChange(Change<FetchCommentState> change) {
    print(
        "Current State ${change.currentState}, next state ${change.nextState}");
    super.onChange(change);
  }

  @override
  FetchCommentState fromJson(Map<String, dynamic> json) {
    try {
      return FetchCommentLoaded.fromMap(json);
    } catch (e) {
      return FetchCommentInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(FetchCommentState state) {
    if (state is FetchCommentLoaded) {
      return state.toMap();
    }
    return {};
  }
}
