// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class VerificationResponseModel {
  String? error;
  String? success;
  String? user_type;
  String? email;
  String? services;
  String? is_forgot_password;
  VerificationResponseModel({
    this.error,
    this.success,
    this.user_type,
    this.email,
    this.services,
    this.is_forgot_password,
  });

  VerificationResponseModel.InitError(String error) {
    this.error = error;
  }

  VerificationResponseModel copyWith({
    String? error,
    String? success,
    String? user_type,
    String? email,
    String? services,
    String? is_forgot_password,
  }) {
    return VerificationResponseModel(
      error: error ?? this.error,
      success: success ?? this.success,
      user_type: user_type ?? this.user_type,
      email: email ?? this.email,
      services: services ?? this.services,
      is_forgot_password: is_forgot_password ?? this.is_forgot_password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'error': error,
      'success': success,
      'user_type': user_type,
      'email': email,
      'services': services,
      'is_forgot_password': is_forgot_password,
    };
  }

  factory VerificationResponseModel.fromMap(Map<String, dynamic> map) {
    return VerificationResponseModel(
      error: map['error'] != null ? map['error'] as String : null,
      success: map['success'] != null ? map['success'] as String : null,
      user_type: map['user_type'] != null ? map['user_type'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      services: map['services'] != null ? map['services'] as String : null,
      is_forgot_password: map['is_forgot_password'] != null
          ? map['is_forgot_password'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VerificationResponseModel.fromJson(String source) =>
      VerificationResponseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VerificationResponseModel(error: $error, success: $success, user_type: $user_type, email: $email, services: $services, is_forgot_password: $is_forgot_password)';
  }

  @override
  bool operator ==(covariant VerificationResponseModel other) {
    if (identical(this, other)) return true;
  
    return other.error == error &&
        other.success == success &&
        other.user_type == user_type &&
        other.email == email &&
        other.services == services &&
        other.is_forgot_password == is_forgot_password;
  }

  @override
  int get hashCode {
    return error.hashCode ^
        success.hashCode ^
        user_type.hashCode ^
        email.hashCode ^
        services.hashCode ^
        is_forgot_password.hashCode;
  }
}
