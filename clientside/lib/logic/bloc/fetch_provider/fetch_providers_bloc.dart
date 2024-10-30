import 'package:bloc/bloc.dart';
import 'package:bookme/data/model/service_provider_model.dart';
import 'package:bookme/logic/bloc/fetch_provider/fetch_providers_event.dart';
import 'package:bookme/logic/bloc/fetch_provider/fetch_providers_state.dart';

import '../../../data/repository/fetch_providers_repo.dart';

class FetchProviderBloc extends Bloc<FetchProviderEvent, FetchProviderState> {
  FetchProviderBloc() : super(const FetchProviderState()) {
    on<FetchProviderHit>((event, emit) async {
      try {
        print("on bloc");
        emit(FetchProviderLoadingState());

        List<ServiceProviderModel> user = await FetchProvidersRepository()
            .fetchProvidersDetails(
                id: event.id, token: event.newToken.toString());
        print("provider lenght");
        if (user.length == 0) {
          emit(FetchProviderEmptyState(message: "Empty"));
          return;
        }

        if (user[0].error != null) {
          emit(FetchProviderErrorState(message: user[0].error.toString()));
          return;
        }

        emit(FetchProviderLoadedState(providerModel: user));
        // }
      } catch (e, stackTrace) {
        emit(const FetchProviderErrorState(message: 'An error occurred.'));
      }
    });

    //       return emit(FetchProviderErrorState(message: user[0].error!));
    //     }
    //     return emit(FetchProviderLoadedState(userModel: user));
    //   });
  }
  // final FetchProviderRepository _servicesRepository = FetchProviderRepository();
  // FetchProviderBloc() : super(const FetchProviderState()) {
  //   on<FetchProviderHit>((event, emit) async {
  //     print("On bloc");
  //     print(event.newToken);
  //     emit(FetchProviderLoadingState());
  //     List<UserModel> user = await _servicesRepository.getUserProfile(
  //         token: event.newToken.toString());
  //     if (user[0].error != null) {
  //       return emit(FetchProviderErrorState(message: user[0].error!));
  //     }
  //     return emit(FetchProviderLoadedState(userModel: user));
  //   });
  // }
}
