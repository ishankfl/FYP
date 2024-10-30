// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LogoutResponseModel {
  int? success;
  int? error;
  String? message;
  LogoutResponseModel({
    required this.success,
    required this.error,
    required this.message,
  });

  LogoutResponseModel copyWith({
    int? success,
    int? error,
    String? message,
  }) {
    return LogoutResponseModel(
      success: success ?? this.success,
      error: error ?? this.error,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'error': error,
      'message': message,
    };
  }

  factory LogoutResponseModel.fromMap(Map<String, dynamic> map) {
    return LogoutResponseModel(
      success: map['success'] as int,
      error: map['error'] as int,
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LogoutResponseModel.fromJson(String source) =>
      LogoutResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'LogoutResponseModel(success: $success, error: $error, message: $message)';

  @override
  bool operator ==(covariant LogoutResponseModel other) {
    if (identical(this, other)) return true;

    return other.success == success &&
        other.error == error &&
        other.message == message;
  }

  @override
  int get hashCode => success.hashCode ^ error.hashCode ^ message.hashCode;

  LogoutResponseModel.InitError(this.message) {}
}
