import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ViewRequestPageState extends Equatable {
  // int counter;
  int? index;

  ViewRequestPageState({this.index});

  @override
  List<Object> get props {
    if (index != null) {
      return [index!];
    }
    return [];
  }
}
