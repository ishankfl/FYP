import 'package:bookme/logic/bloc_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

String getAccessToken(BuildContext context) {
  LoginState statelogin = context.read<LoginBloc>().state;
  String token = '';
  if (statelogin is LoginLoaded) {
    token = statelogin.loginModel.access!;
    return token;
  }
  return "";
}
