import 'package:bloc/bloc.dart';
import 'dart:async';

abstract class DropdownState {}

class DropdownInitial extends DropdownState {}

class DropdownSelected extends DropdownState {
  final String selectedValue;

  DropdownSelected(this.selectedValue);
}

abstract class DropdownEvent {}

class DropdownItemSelected extends DropdownEvent {
  final String selectedValue;

  DropdownItemSelected(this.selectedValue);
}

class DropdownBloc extends Bloc<DropdownEvent, DropdownState> {
  DropdownBloc() : super(DropdownInitial());

  Stream<DropdownState> mapEventToState(DropdownEvent event) async* {
    if (event is DropdownItemSelected) {
      yield DropdownSelected(event.selectedValue);
    }
  }
}
