// ignore_for_file: avoid_print

import 'package:bookme/data/repository/provider_home.dart';
import 'package:bookme/logic/bloc_export.dart';

class ChartBloc extends Bloc<ChartEvent, ChartState> {
  ChartBloc({required ProviderHomeRepo apiRepository}) : super(ChartInitial()) {
    on<ChartClickedEvent>((event, emit) async {
      emit(ChartLoading());
      try {
        print("in bloc");
        final updateModel = await apiRepository.fetchChartData(
          token: event.token,
        );

        print(updateModel);
        print("on bloc model");

        if (updateModel[0].message != null || updateModel[0].error != null) {
          emit(ChartError(message: updateModel[0].message));
          return;
        }
        emit(ChartLoaded(
          bookModel: updateModel,
        ));
      } catch (err) {
        emit(const ChartError(
          message: "Internal server error",
        ));
        print("error on bloc $err");
      }
    });
  }
  @override
  void onChange(Change<ChartState> change) {
    print(
        "Current State ${change.currentState}, next state ${change.nextState}");
    super.onChange(change);
  }

  @override
  ChartState fromJson(Map<String, dynamic> json) {
    try {
      return ChartLoaded.fromMap(json);
    } catch (e) {
      return ChartInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(ChartState state) {
    if (state is ChartLoaded) {
      return state.toMap();
    }
    return {};
  }
}
