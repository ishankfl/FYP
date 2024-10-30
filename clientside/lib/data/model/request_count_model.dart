// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RequestCountModel {
  int? new_requests_count;
  int? accepted_requests_count;
  int? completed_requests_count;
  int? error;
  int? success;
  String? message;
  RequestCountModel({
    this.new_requests_count,
    this.accepted_requests_count,
    this.completed_requests_count,
    this.error,
    this.success,
    this.message,
  });
  RequestCountModel.initError(this.message);

  RequestCountModel copyWith({
    int? new_requests_count,
    int? accepted_requests_count,
    int? completed_requests_count,
    int? error,
    int? success,
    String? message,
  }) {
    return RequestCountModel(
      new_requests_count: new_requests_count ?? this.new_requests_count,
      accepted_requests_count:
          accepted_requests_count ?? this.accepted_requests_count,
      completed_requests_count:
          completed_requests_count ?? this.completed_requests_count,
      error: error ?? this.error,
      success: success ?? this.success,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'new_requests_count': new_requests_count,
      'accepted_requests_count': accepted_requests_count,
      'completed_requests_count': completed_requests_count,
      'error': error,
      'success': success,
      'message': message,
    };
  }

  factory RequestCountModel.fromMap(Map<String, dynamic> map) {
    return RequestCountModel(
      new_requests_count: map['new_requests_count'] != null
          ? map['new_requests_count'] as int
          : null,
      accepted_requests_count: map['accepted_requests_count'] != null
          ? map['accepted_requests_count'] as int
          : null,
      completed_requests_count: map['completed_requests_count'] != null
          ? map['completed_requests_count'] as int
          : null,
      error: map['error'] != null ? map['error'] as int : null,
      success: map['success'] != null ? map['success'] as int : null,
      message: map['message'] != null ? map['message'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestCountModel.fromJson(String source) =>
      RequestCountModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RequestCountModel(new_requests_count: $new_requests_count, accepted_requests_count: $accepted_requests_count, completed_requests_count: $completed_requests_count, error: $error, success: $success, message: $message)';
  }

  @override
  bool operator ==(covariant RequestCountModel other) {
    if (identical(this, other)) return true;

    return other.new_requests_count == new_requests_count &&
        other.accepted_requests_count == accepted_requests_count &&
        other.completed_requests_count == completed_requests_count &&
        other.error == error &&
        other.success == success &&
        other.message == message;
  }

  @override
  int get hashCode {
    return new_requests_count.hashCode ^
        accepted_requests_count.hashCode ^
        completed_requests_count.hashCode ^
        error.hashCode ^
        success.hashCode ^
        message.hashCode;
  }
}
