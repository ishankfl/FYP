// part of 'index_cubit.dart';

import 'dart:io';

import 'package:equatable/equatable.dart';

class PathState extends Equatable {
  final File path;
  const PathState({required this.path});

  @override
  List<Object> get props => [path];
}

class FilePathState extends Equatable {
  final File path;
  const FilePathState({required this.path});

  @override
  List<Object> get props => [path];
}
