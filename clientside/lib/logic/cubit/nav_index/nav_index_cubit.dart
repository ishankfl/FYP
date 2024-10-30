import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'nav_index_state.dart';

class NavIndexCubit extends Cubit<NavIndexState> {
  NavIndexCubit() : super(NavIndexState(0));
  void changeIndex(int index) => emit(NavIndexState(index));
  @override
  void onChange(Change<NavIndexState> change) {
    print(
        "CUrrent State ${change.currentState} next state ${change.nextState}");
    super.onChange(change);
  }
}
