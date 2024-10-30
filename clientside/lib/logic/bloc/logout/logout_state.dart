import 'package:bookme/data/api/api_export.dart';
import 'package:bookme/data/model/logout_response_model.dart';
import 'package:bookme/data/model/model_export.dart';
import 'package:equatable/equatable.dart';

sealed class LogoutState extends Equatable {
  const LogoutState();

  @override
  List<Object> get props => [];
}

class LogoutInitial extends LogoutState {}

class LogoutLoading extends LogoutState {}

class LogoutLoaded extends LogoutState {
  final LogoutResponseModel loginModel;

  const LogoutLoaded({required this.loginModel});

  @override
  List<Object> get props => [loginModel];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'logoutModel': loginModel.toMap(),
    };
  }

  factory LogoutLoaded.fromMap(Map<String, dynamic> map) {
    try {
      return LogoutLoaded(
        loginModel: LogoutResponseModel.fromMap(map['loginModel']),
      );
    } catch (e) {
      LogoutInitial();
      return LogoutLoaded(
        loginModel: LogoutResponseModel.fromMap(map['loginModel']),
      );
    }
  }

  String toJson() => json.encode(toMap());

  factory LogoutLoaded.fromJson(String source) =>
      LogoutLoaded.fromMap(json.decode(source) as Map<String, dynamic>);
}

class LogoutError extends LogoutState {
  final String? message;

  const LogoutError({required this.message});

  @override
  List<Object> get props => [message!];
}
