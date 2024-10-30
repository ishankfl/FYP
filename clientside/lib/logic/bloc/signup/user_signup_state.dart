// part of 'login_bloc.dart';
part of 'user_signup_bloc.dart';

sealed class SignUpUserState extends Equatable {
  const SignUpUserState();

  @override
  List<Object> get props => [];
}

class SignUpUserInitial extends SignUpUserState {}

class SignUpUserLoading extends SignUpUserState {}

class SignUpUserLoaded extends SignUpUserState {
  final UserModel userModel;
  // final bool rememberMe;

  const SignUpUserLoaded({required this.userModel});

  @override
  List<Object> get props => [userModel];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'signUpModel': userModel.toMap(),
    };
  }

  factory SignUpUserLoaded.fromMap(Map<String, dynamic> map) {
    return SignUpUserLoaded(
      userModel: UserModel.fromMap(map['signUpModel']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SignUpUserLoaded.fromJson(String source) =>
      SignUpUserLoaded.fromMap(json.decode(source) as Map<String, dynamic>);
}

class SignUpUserError extends SignUpUserState {
  final String? message;

  SignUpUserError({required this.message}) {
    if (message == "") {
      message != "error";
    }
  }

  @override
  List<Object> get props => [message!];
}

class UpdateUserInitial extends SignUpUserState {}

class UpdateUserLoading extends SignUpUserState {}

class UpdateUserLoaded extends SignUpUserState {
  final UserModel userModel;
  // final bool rememberMe;

  const UpdateUserLoaded({required this.userModel});

  @override
  List<Object> get props => [userModel];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'signUpModel': userModel.toMap(),
    };
  }

  factory UpdateUserLoaded.fromMap(Map<String, dynamic> map) {
    return UpdateUserLoaded(
      userModel: UserModel.fromMap(map['signUpModel']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateUserLoaded.fromJson(String source) =>
      UpdateUserLoaded.fromMap(json.decode(source) as Map<String, dynamic>);
}

class UpdateUserError extends SignUpUserState {
  final String? message;

  UpdateUserError({required this.message}) {
    if (message == "") {
      message != "error";
    }
  }

  @override
  List<Object> get props => [message!];
}
