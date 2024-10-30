// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BookingUpdateModel {
  int? error;
  int? success;
  String? message;
  BookingUpdateModel({
    this.error,
    this.success,
    this.message,
  });

  BookingUpdateModel copyWith({
    int? error,
    int? success,
    String? message,
  }) {
    return BookingUpdateModel(
      error: error ?? this.error,
      success: success ?? this.success,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'error': error,
      'success': success,
      'message': message,
    };
  }

  factory BookingUpdateModel.fromMap(Map<String, dynamic> map) {
    return BookingUpdateModel(
      error: map['error'] != null ? map['error'] as int : null,
      success: map['success'] != null ? map['success'] as int : null,
      message: map['message'] != null ? map['message'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingUpdateModel.fromJson(String source) =>
      BookingUpdateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'BookingUpdateModel(error: $error, success: $success, message: $message)';

  @override
  bool operator ==(covariant BookingUpdateModel other) {
    if (identical(this, other)) return true;

    return other.error == error &&
        other.success == success &&
        other.message == message;
  }

  @override
  int get hashCode => error.hashCode ^ success.hashCode ^ message.hashCode;

  BookingUpdateModel.initError(this.message);
}
