// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class TimeValidationModel {
  int? available;
  String? error;
  String? success;
  String? message;
  List<String>? booked_time;
  TimeValidationModel({
    this.available,
    this.error,
    this.success,
    this.message,
    this.booked_time,
  });

  TimeValidationModel copyWith({
    int? available,
    String? error,
    String? success,
    String? message,
    List<String>? booked_time,
  }) {
    return TimeValidationModel(
      available: available ?? this.available,
      error: error ?? this.error,
      success: success ?? this.success,
      message: message ?? this.message,
      booked_time: booked_time ?? this.booked_time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'available': available,
      'error': error,
      'success': success,
      'message': message,
      'booked_time': booked_time,
    };
  }

  factory TimeValidationModel.fromMap(Map<String, dynamic> map) {
    return TimeValidationModel(
        available: map['available'] != null ? map['available'] as int : null,
        error: map['error'] != null ? map['error'] as String : null,
        success: map['success'] != null ? map['success'] as String : null,
        message: map['message'] != null ? map['message'] as String : null,
        booked_time: map['booked_time'] != null
            ? List<String>.from(map['booked_time'] as List<String>)
            : null);
  }

  String toJson() => json.encode(toMap());

  factory TimeValidationModel.fromJson(String source) =>
      TimeValidationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TimeValidationModel(available: $available, error: $error, success: $success, message: $message, booked_time: $booked_time)';
  }

  @override
  bool operator ==(covariant TimeValidationModel other) {
    if (identical(this, other)) return true;

    return other.available == available &&
        other.error == error &&
        other.success == success &&
        other.message == message &&
        listEquals(other.booked_time, booked_time);
  }

  @override
  int get hashCode {
    return available.hashCode ^
        error.hashCode ^
        success.hashCode ^
        message.hashCode ^
        booked_time.hashCode;
  }

  TimeValidationModel.InitError(String error) {
    this.error = error;
  }

  TimeValidationModel.withError(String error) {
    this.error = error;
  }
}
