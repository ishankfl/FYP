import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bookme/logic/cubit/image_upload/image_upload_state.dart';
import 'package:bookme/presentation/screen/loginsignup/choosonscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilePathCubit extends Cubit<FilePathState> {
  File path;
  FilePathCubit(this.path) : super(FilePathState(path: path));

  void increment(BuildContext context) {
    if (state.path == 1) {
      emit(FilePathState(path: state.path));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginSignUpChoosen()),
      );
    } else {
      emit(FilePathState(path: state.path));
    }
  }
}
