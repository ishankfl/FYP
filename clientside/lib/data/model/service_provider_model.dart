// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';
import 'package:bookme/data/model/model_export.dart';

class ServiceProviderModel {
  int? id;
  UserModel? user;
  String? experience;
  String? certificate;
  bool? verification_status;
  bool? is_available;
  bool? is_booked;
  int? total_services;
  int? services_offered;
  ServicesModel? services;
  String? error;
  String? message;
  double? averagerating;
  ServiceProviderModel({
    this.id,
    this.user,
    this.experience,
    this.certificate,
    this.verification_status,
    this.is_available,
    this.is_booked,
    this.total_services,
    this.services_offered,
    this.services,
    this.error,
    this.message,
    this.averagerating,
  });

  ServiceProviderModel.initError(this.error);

  ServiceProviderModel copyWith({
    int? id,
    UserModel? user,
    String? experience,
    String? certificate,
    bool? verification_status,
    bool? is_available,
    bool? is_booked,
    int? total_services,
    int? services_offered,
    ServicesModel? services,
    String? error,
    String? message,
    double? averagerating,
  }) {
    return ServiceProviderModel(
      id: id ?? this.id,
      user: user ?? this.user,
      experience: experience ?? this.experience,
      certificate: certificate ?? this.certificate,
      verification_status: verification_status ?? this.verification_status,
      is_available: is_available ?? this.is_available,
      is_booked: is_booked ?? this.is_booked,
      total_services: total_services ?? this.total_services,
      services_offered: services_offered ?? this.services_offered,
      services: services ?? this.services,
      error: error ?? this.error,
      message: message ?? this.message,
      averagerating: averagerating ?? this.averagerating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user': user?.toMap(),
      'experience': experience,
      'certificate': certificate,
      'verification_status': verification_status,
      'is_available': is_available,
      'is_booked': is_booked,
      'total_services': total_services,
      'services_offered': services_offered,
      'services': services?.toMap(),
      'error': error,
      'message': message,
      'averagerating': averagerating,
    };
  }

  factory ServiceProviderModel.fromMap(Map<String, dynamic> map) {
    return ServiceProviderModel(
      id: map['id'] != null ? map['id'] as int : null,
      user: map['user'] != null
          ? UserModel.fromMap(map['user'] as Map<String, dynamic>)
          : null,
      experience:
          map['experience'] != null ? map['experience'] as String : null,
      certificate:
          map['certificate'] != null ? map['certificate'] as String : null,
      verification_status: map['verification_status'] != null
          ? map['verification_status'] as bool
          : null,
      is_available:
          map['is_available'] != null ? map['is_available'] as bool : null,
      is_booked: map['is_booked'] != null ? map['is_booked'] as bool : null,
      total_services:
          map['total_services'] != null ? map['total_services'] as int : null,
      services_offered: map['services_offered'] != null
          ? map['services_offered'] as int
          : null,
      services: map['services'] != null
          ? ServicesModel.fromMap(map['services'] as Map<String, dynamic>)
          : null,
      error: map['error'] != null ? map['error'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
      averagerating:
          map['averagerating'] != null ? map['averagerating'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceProviderModel.fromJson(String source) =>
      ServiceProviderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ServiceProviderModel(id: $id, user: $user, experience: $experience, certificate: $certificate, verification_status: $verification_status, is_available: $is_available, is_booked: $is_booked, total_services: $total_services, services_offered: $services_offered, services: $services, error: $error, message: $message, averagerating: $averagerating)';
  }

  @override
  bool operator ==(covariant ServiceProviderModel other) {
    if (identical(this, other)) return true;
  
    return other.id == id &&
        other.user == user &&
        other.experience == experience &&
        other.certificate == certificate &&
        other.verification_status == verification_status &&
        other.is_available == is_available &&
        other.is_booked == is_booked &&
        other.total_services == total_services &&
        other.services_offered == services_offered &&
        other.services == services &&
        other.error == error &&
        other.message == message &&
        other.averagerating == averagerating;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user.hashCode ^
        experience.hashCode ^
        certificate.hashCode ^
        verification_status.hashCode ^
        is_available.hashCode ^
        is_booked.hashCode ^
        total_services.hashCode ^
        services_offered.hashCode ^
        services.hashCode ^
        error.hashCode ^
        message.hashCode ^
        averagerating.hashCode;
  }
}
