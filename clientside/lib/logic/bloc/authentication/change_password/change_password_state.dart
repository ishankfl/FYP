import 'package:bookme/data/api/api_export.dart';
import 'package:bookme/data/model/model_export.dart';
import 'package:equatable/equatable.dart';

sealed class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState {}

class ChangePasswordLoaded extends ChangePasswordState {
  final UserModel ChangePasswordModel;

  const ChangePasswordLoaded({required this.ChangePasswordModel});

  @override
  List<Object> get props => [ChangePasswordModel];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ChangePasswordModel': ChangePasswordModel.toMap(),
    };
  }

  factory ChangePasswordLoaded.fromMap(Map<String, dynamic> map) {
    try {
      return ChangePasswordLoaded(
        ChangePasswordModel: UserModel.fromMap(map['ChangePasswordModel']),
      );
    } catch (e) {
      ChangePasswordInitial();
      return ChangePasswordLoaded(
        ChangePasswordModel: UserModel.fromMap(map['ChangePasswordModel']),
      );
    }
  }

  String toJson() => json.encode(toMap());

  factory ChangePasswordLoaded.fromJson(String source) =>
      ChangePasswordLoaded.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ChangePasswordError extends ChangePasswordState {
  final String? message;

  const ChangePasswordError({required this.message});

  @override
  List<Object> get props => [message!];
}
