import 'package:bloc/bloc.dart';
import 'package:bookme/logic/cubit/dropdown_change.dart/dropdown_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// part 'index_state.dart';

class DropDownCubit extends Cubit<DropDownState> {
  DropDownCubit() : super(const DropDownState(index: 1));

  void change(BuildContext context) {
    if (state.index == 0) {
      emit(const DropDownState(index: 1));
    } else {
      emit(const DropDownState(index: 0));
    }
  }
}
