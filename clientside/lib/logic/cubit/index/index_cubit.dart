import 'package:bloc/bloc.dart';
import 'package:bookme/logic/bloc_export.dart';
import 'package:bookme/presentation/screen/loginsignup/choosonscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// part 'index_state.dart';

class IndexCubit extends Cubit<IndexState> {
  IndexCubit() : super(const IndexState(index: 0));

  void skip() {
    // if (state.index < 2) {

    // }
    // else{

    // }
    // emit(state)
  }

  void increment(BuildContext context) {
    if (state.index == 1) {
      emit(IndexState(index: state.index));
      // Navigator.pop(MaterialApp(
      //   home: ,
      // ))

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginSignUpChoosen()),
      );
    } else {
      emit(IndexState(index: state.index + 1));
    }
  }
}
