import 'package:bookme/data/model/request_count_model.dart';
import 'package:bookme/data/repository/provider_home.dart';
import 'package:bookme/logic/bloc_export.dart';

class FetchRequestCountBloc
    extends Bloc<FetchRequestCountEvent, FetchRequestCountState> {
  final ProviderHomeRepo repo = ProviderHomeRepo();
  FetchRequestCountBloc() : super(const FetchRequestCountState()) {
    on<FetchRequestCountHit>((event, emit) async {
      emit(FetchRequestCountLoadingState());
      List<RequestCountModel> services =
          await repo.fetchRequestCount(token: event.token);
      if (services[0].message != null) {
        return emit(FetchRequestCountErrorState(message: services[0].message!));
      }
      return emit(FetchRequestCountLoadedState(model: services));
    });
  }
}
