// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bookme/data/model/user_model.dart';

class CustomerModel {
  UserModel? user;
  String? date;
  bool? verify_status;
  int? total_services;
  CustomerModel({
    this.user,
    this.date,
    this.verify_status,
    this.total_services,
  });

  CustomerModel copyWith({
    UserModel? user,
    String? date,
    bool? verify_status,
    int? total_services,
  }) {
    return CustomerModel(
      user: user ?? this.user,
      date: date ?? this.date,
      verify_status: verify_status ?? this.verify_status,
      total_services: total_services ?? this.total_services,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user?.toMap(),
      'date': date,
      'verify_status': verify_status,
      'total_services': total_services,
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      user: map['user'] != null
          ? UserModel.fromMap(map['user'] as Map<String, dynamic>)
          : null,
      date: map['date'] != null ? map['date'] as String : null,
      verify_status:
          map['verify_status'] != null ? map['verify_status'] as bool : null,
      total_services:
          map['total_services'] != null ? map['total_services'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerModel.fromJson(String source) =>
      CustomerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CustomerModel(user: $user, date: $date, verify_status: $verify_status, total_services: $total_services)';
  }

  @override
  bool operator ==(covariant CustomerModel other) {
    if (identical(this, other)) return true;

    return other.user == user &&
        other.date == date &&
        other.verify_status == verify_status &&
        other.total_services == total_services;
  }

  @override
  int get hashCode {
    return user.hashCode ^
        date.hashCode ^
        verify_status.hashCode ^
        total_services.hashCode;
  }
}
