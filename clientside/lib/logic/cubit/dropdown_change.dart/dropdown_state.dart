// part of 'dropdown_cubit.dart';

import 'package:equatable/equatable.dart';

class DropDownState extends Equatable {
  final int index;
  const DropDownState({required this.index});

  @override
  List<Object> get props => [index];
}
