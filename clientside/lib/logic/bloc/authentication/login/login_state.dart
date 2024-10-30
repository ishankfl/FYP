import 'package:bookme/data/api/api_export.dart';
import 'package:bookme/data/model/model_export.dart';
import 'package:equatable/equatable.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
  final LoginModel loginModel;

  const LoginLoaded({required this.loginModel});

  @override
  List<Object> get props => [loginModel];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'loginModel': loginModel.toMap(),
    };
  }

  factory LoginLoaded.fromMap(Map<String, dynamic> map) {
    try {
      return LoginLoaded(
        loginModel: LoginModel.fromMap(map['loginModel']),
      );
    } catch (e) {
      LoginInitial();
      return LoginLoaded(
        loginModel: LoginModel.fromMap(map['loginModel']),
      );
    }
  }

  String toJson() => json.encode(toMap());

  factory LoginLoaded.fromJson(String source) =>
      LoginLoaded.fromMap(json.decode(source) as Map<String, dynamic>);
}

class LoginError extends LoginState {
  final String? message;

  const LoginError({required this.message});

  @override
  List<Object> get props => [message!];
}
