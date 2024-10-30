// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bookme/data/model/user_model.dart';

class ProfileModel {
  UserModel? data;
  int? success;
  ProfileModel({
    this.data,
    this.success,
  });

  ProfileModel copyWith({
    UserModel? data,
    int? success,
  }) {
    return ProfileModel(
      data: data ?? this.data,
      success: success ?? this.success,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data?.toMap(),
      'success': success,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      data: map['data'] != null
          ? UserModel.fromMap(map['data'] as Map<String, dynamic>)
          : null,
      success: map['success'] != null ? map['success'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) =>
      ProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ProfileModel(data: $data, success: $success)';

  @override
  bool operator ==(covariant ProfileModel other) {
    if (identical(this, other)) return true;

    return other.data == data && other.success == success;
  }

  @override
  int get hashCode => data.hashCode ^ success.hashCode;

  ProfileModel.InitError(String error);

  ProfileModel.withError(String error) {
    //  = error;
  }
}
