import 'package:bookme/logic/bloc_export.dart';

// part 'index_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(index: 0, navView: true));

  void changePage({required int index, bool? navView}) {
    print("Changed$index");
    NavigationState(index: state.index, navView: navView ?? true);
    // emit(NavigationState(index: state.index));
    emit(NavigationChangeState(index: index, navView: navView ?? true));
  }
}
