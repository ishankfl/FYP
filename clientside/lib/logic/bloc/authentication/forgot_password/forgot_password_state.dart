import 'package:bookme/data/api/api_export.dart';
import 'package:bookme/data/model/model_export.dart';
import 'package:equatable/equatable.dart';

sealed class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object> get props => [];
}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordLoaded extends ForgotPasswordState {
  final UserModel forgotPasswordModel;

  const ForgotPasswordLoaded({required this.forgotPasswordModel});

  @override
  List<Object> get props => [forgotPasswordModel];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'forgotPasswordModel': forgotPasswordModel.toMap(),
    };
  }

  factory ForgotPasswordLoaded.fromMap(Map<String, dynamic> map) {
    try {
      return ForgotPasswordLoaded(
        forgotPasswordModel: UserModel.fromMap(map['forgotPasswordModel']),
      );
    } catch (e) {
      ForgotPasswordInitial();
      return ForgotPasswordLoaded(
        forgotPasswordModel: UserModel.fromMap(map['forgotPasswordModel']),
      );
    }
  }

  String toJson() => json.encode(toMap());

  factory ForgotPasswordLoaded.fromJson(String source) =>
      ForgotPasswordLoaded.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ForgotPasswordError extends ForgotPasswordState {
  final String? message;

  const ForgotPasswordError({required this.message});

  @override
  List<Object> get props => [message!];
}
