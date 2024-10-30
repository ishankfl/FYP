// part of 'login_bloc.dart';
part of 'verification_bloc.dart';

sealed class VerificationState extends Equatable {
  const VerificationState();

  @override
  List<Object> get props => [];
}

class VerificationInitial extends VerificationState {}

class VerificationLoading extends VerificationState {}

class VerificationLoaded extends VerificationState {
  final VerificationResponseModel verifyModel;
  // final bool rememberMe;

  const VerificationLoaded({required this.verifyModel});

  @override
  List<Object> get props => [verifyModel];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'verificationModel': verifyModel.toMap(),
    };
  }

  factory VerificationLoaded.fromMap(Map<String, dynamic> map) {
    return VerificationLoaded(
      verifyModel: VerificationResponseModel.fromMap(map['verificationModel']),
    );
  }

  String toJson() => json.encode(toMap());

  factory VerificationLoaded.fromJson(String source) =>
      VerificationLoaded.fromMap(json.decode(source) as Map<String, dynamic>);
}

class VerificationError extends VerificationState {
  final String? message;

  const VerificationError({required this.message});

  @override
  List<Object> get props => [message!];
}
