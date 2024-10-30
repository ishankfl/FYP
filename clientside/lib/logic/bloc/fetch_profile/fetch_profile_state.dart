// part of 'fetch_profile_bloc.dart';

import 'package:bookme/data/model/user_model.dart';
import 'package:equatable/equatable.dart';

class FetchProfileState extends Equatable {
  const FetchProfileState();

  @override
  List<Object> get props {
    return [];
  }
}

class FetchProfileLoadingState extends FetchProfileState {}

class FetchProfileErrorState extends FetchProfileState {
  final String message;

  const FetchProfileErrorState({required this.message});

  @override
  List<Object> get props {
    return [message];
  }
}

// ignore: must_be_immutable
class FetchProfileLoadedState extends FetchProfileState {
  final UserModel userModel;

  const FetchProfileLoadedState({required this.userModel});

  @override
  List<Object> get props {
    return [userModel];
  }
}
