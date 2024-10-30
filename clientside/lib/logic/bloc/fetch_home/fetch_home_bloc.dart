import 'package:bloc/bloc.dart';
import 'package:bookme/data/model/services_model.dart';
import 'package:bookme/data/repository/services_repository.dart';
import 'package:equatable/equatable.dart';
part 'fetch_home_event.dart';
part 'fetch_home_state.dart';

class FetchHomeBloc extends Bloc<FetchHomeEvent, FetchHomeState> {
  final ServicesRepository _servicesRepository = ServicesRepository();
  FetchHomeBloc() : super(const FetchHomeState()) {
    on<FetchHomeHit>((event, emit) async {
      emit(FetchLoadingState());
      List<ServicesModel> services = await _servicesRepository.getServices();
      if (services[0].errorMessage != null) {
        return emit(FetchErrorState(message: services[0].errorMessage!));
      }
      return emit(FetchLoadedState(servicesModel: services));
    });
  }
}
