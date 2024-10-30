// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class ProviderSignupModel {
  String? error;
  String? success;
  ProviderSignupModel({
    this.error,
    this.success,
  });

  ProviderSignupModel copyWith({
    String? error,
    String? success,
  }) {
    return ProviderSignupModel(
      error: error ?? this.error,
      success: success ?? this.success,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'error': error,
      'success': success,
    };
  }

  factory ProviderSignupModel.fromMap(Map<String, dynamic> map) {
    return ProviderSignupModel(
      error: map['error'] != null ? map['error'] as String : null,
      success: map['success'] != null ? map['success'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProviderSignupModel.fromJson(String source) =>
      ProviderSignupModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ProviderSignupModel(error: $error, success: $success)';

  @override
  bool operator ==(covariant ProviderSignupModel other) {
    if (identical(this, other)) return true;

    return other.error == error && other.success == success;
  }

  ProviderSignupModel.InitError(String error) {
    this.error = error;
  }

  @override
  int get hashCode => error.hashCode ^ success.hashCode;
}
