// ignore_for_file: avoid_print

import 'package:bookme/data/repository/fetch_booking_repo.dart';
import 'package:bookme/data/repository/review_rate_repo.dart';
import 'package:bookme/logic/bloc_export.dart';

class AddReviewBloc extends HydratedBloc<AddReviewEvent, AddReviewState> {
  AddReviewBloc({required ReviewRateRepository apiRepository})
      : super(AddReviewInitial()) {
    on<AddReviewClickedEvent>((event, emit) async {
      emit(AddReviewLoading());
      try {
        final updateModel = await apiRepository.giveReview(
          bookId: event.bookId,
          description: event.description,
          rate: event.rate,
          token: event.token,
        );

        print(updateModel);
        print("on bloc model");

        if (updateModel[0].message != null || updateModel[0].error != null) {
          emit(AddReviewError(message: updateModel[0].message));
          return;
        }
        emit(AddReviewLoaded(
          updateModel: updateModel,
        ));
      } catch (err) {
        emit(const AddReviewError(
          message: "Internal server error",
        ));
        print("error on bloc $err");
      }
    });
  }
  @override
  void onChange(Change<AddReviewState> change) {
    print(
        "Current State ${change.currentState}, next state ${change.nextState}");
    super.onChange(change);
  }

  @override
  AddReviewState fromJson(Map<String, dynamic> json) {
    try {
      return AddReviewLoaded.fromMap(json);
    } catch (e) {
      return AddReviewInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(AddReviewState state) {
    if (state is AddReviewLoaded) {
      return state.toMap();
    }
    return {};
  }
}
