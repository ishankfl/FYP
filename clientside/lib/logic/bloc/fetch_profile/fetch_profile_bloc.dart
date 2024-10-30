import 'package:bloc/bloc.dart';
import 'package:bookme/data/model/user_model.dart';
import 'package:bookme/data/repository/fetch_profile_repo.dart';
import 'package:bookme/logic/bloc_export.dart';

class FetchProfileBloc extends Bloc<FetchProfileEvent, FetchProfileState> {
  FetchProfileBloc() : super(const FetchProfileState()) {
    on<FetchProfileHit>((event, emit) async {
      try {
        emit(FetchProfileLoadingState());

        List<UserModel> user = await FetchProfileRepository().getUserProfile(
          token: event.newToken.toString(),
        );
        // print("on bloc");
        // print(user);

        if (user.isNotEmpty && user[0].error != null) {
          print("erro");
          emit(FetchProfileErrorState(message: user[0].error!));
        } else {
          emit(FetchProfileLoadedState(userModel: user[0]));
        }
      } catch (e, stackTrace) {
        print('Error in FetchProfileBloc: $e');
        print('Stack Trace: $stackTrace');
        emit(const FetchProfileErrorState(message: 'An error occurred.'));
      }
    });
  }
}
