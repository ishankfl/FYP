import 'package:equatable/equatable.dart';

class IndexState extends Equatable {
  final int index;
  const IndexState({required this.index});

  @override
  List<Object> get props => [index];
}
