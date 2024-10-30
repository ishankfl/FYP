import 'package:bookme/logic/cubit/view_request_page_change/view_request_page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewRequestPageCubit extends Cubit<ViewRequestPageState> {
  ViewRequestPageCubit() : super(ViewRequestPageState());
  void addition({required int index}) {
    emit(ViewRequestPageState(index: index));
  }

  void pageChange({required int index}) {
    emit(ViewRequestPageState(index: index));
  }
}
