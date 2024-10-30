// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RateProviderResponseModel {
  String? message;
  int? error;
  int? success;
  RateProviderResponseModel({
    this.message,
    this.error,
    this.success,
  });

  RateProviderResponseModel.initError(this.message);
  RateProviderResponseModel copyWith({
    String? message,
    int? error,
    int? success,
  }) {
    return RateProviderResponseModel(
      message: message ?? this.message,
      error: error ?? this.error,
      success: success ?? this.success,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'error': error,
      'success': success,
    };
  }

  factory RateProviderResponseModel.fromMap(Map<String, dynamic> map) {
    return RateProviderResponseModel(
      message: map['message'] != null ? map['message'] as String : null,
      error: map['error'] != null ? map['error'] as int : null,
      success: map['success'] != null ? map['success'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RateProviderResponseModel.fromJson(String source) =>
      RateProviderResponseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'RateProviderResponseModel(message: $message, error: $error, success: $success)';

  @override
  bool operator ==(covariant RateProviderResponseModel other) {
    if (identical(this, other)) return true;

    return other.message == message &&
        other.error == error &&
        other.success == success;
  }

  @override
  int get hashCode => message.hashCode ^ error.hashCode ^ success.hashCode;
}
