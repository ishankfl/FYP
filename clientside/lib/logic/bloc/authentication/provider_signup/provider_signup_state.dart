import 'dart:convert';

import 'package:bookme/data/model/loginsignupmodel/provider_signup_responsemodel.dart';
import 'package:equatable/equatable.dart';

sealed class ProviderSignupUserState extends Equatable {
  const ProviderSignupUserState();

  @override
  List<Object> get props => [];
}

class ProviderSignupUserInitial extends ProviderSignupUserState {}

class ProviderSignupUserLoading extends ProviderSignupUserState {}

class ProviderSignupUserLoaded extends ProviderSignupUserState {
  final ProviderSignupModel userModel;
  // final bool rememberMe;

  const ProviderSignupUserLoaded({required this.userModel});

  @override
  List<Object> get props => [userModel];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'signUpModel': userModel.toMap(),
    };
  }

  factory ProviderSignupUserLoaded.fromMap(Map<String, dynamic> map) {
    return ProviderSignupUserLoaded(
      userModel: ProviderSignupModel.fromMap(map['providerSignupModel']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProviderSignupUserLoaded.fromJson(String source) =>
      ProviderSignupUserLoaded.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

class ProviderSignupUserError extends ProviderSignupUserState {
  final String? message;

  ProviderSignupUserError({required this.message}) {
    if (message == "") {
      message != "error";
    }
  }

  @override
  List<Object> get props => [message!];
}
