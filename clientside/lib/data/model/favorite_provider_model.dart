// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bookme/data/model/model_export.dart';

class FavoriteProviderModel {
  int? error;
  int? success;
  String? message;
  UserModel? by_user;
  UserModel? to_user;
  bool? is_favorit;
  FavoriteProviderModel({
    this.error,
    this.success,
    this.message,
    this.by_user,
    this.to_user,
    this.is_favorit,
  });
  FavoriteProviderModel.InitError(this.message);
  FavoriteProviderModel copyWith({
    int? error,
    int? success,
    String? message,
    UserModel? by_user,
    UserModel? to_user,
    bool? is_favorit,
  }) {
    return FavoriteProviderModel(
      error: error ?? this.error,
      success: success ?? this.success,
      message: message ?? this.message,
      by_user: by_user ?? this.by_user,
      to_user: to_user ?? this.to_user,
      is_favorit: is_favorit ?? this.is_favorit,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'error': error,
      'success': success,
      'message': message,
      'by_user': by_user?.toMap(),
      'to_user': to_user?.toMap(),
      'is_favorit': is_favorit,
    };
  }

  factory FavoriteProviderModel.fromMap(Map<String, dynamic> map) {
    return FavoriteProviderModel(
      error: map['error'] != null ? map['error'] as int : null,
      success: map['success'] != null ? map['success'] as int : null,
      message: map['message'] != null ? map['message'] as String : null,
      by_user: map['by_user'] != null
          ? UserModel.fromMap(map['by_user'] as Map<String, dynamic>)
          : null,
      to_user: map['to_user'] != null
          ? UserModel.fromMap(map['to_user'] as Map<String, dynamic>)
          : null,
      is_favorit: map['is_favorit'] != null ? map['is_favorit'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FavoriteProviderModel.fromJson(String source) =>
      FavoriteProviderModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FavoriteProviderModel(error: $error, success: $success, message: $message, by_user: $by_user, to_user: $to_user, is_favorit: $is_favorit)';
  }

  @override
  bool operator ==(covariant FavoriteProviderModel other) {
    if (identical(this, other)) return true;

    return other.error == error &&
        other.success == success &&
        other.message == message &&
        other.by_user == by_user &&
        other.to_user == to_user &&
        other.is_favorit == is_favorit;
  }

  @override
  int get hashCode {
    return error.hashCode ^
        success.hashCode ^
        message.hashCode ^
        by_user.hashCode ^
        to_user.hashCode ^
        is_favorit.hashCode;
  }
}
