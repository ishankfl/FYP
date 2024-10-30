import 'package:equatable/equatable.dart';

class NavigationState extends Equatable {
  final int index;
  final bool navView;
  const NavigationState({required this.index, required this.navView});

  @override
  List<Object> get props => [index];
}

class NavigationChangeState extends NavigationState {
  NavigationChangeState({required super.index, required super.navView});
}
