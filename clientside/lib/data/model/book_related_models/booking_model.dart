// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bookme/data/model/customer_model.dart';
import 'package:bookme/data/model/favorite_provider_model.dart';
import 'package:bookme/data/model/loginsignupmodel/provider_signup_responsemodel.dart';
import 'package:bookme/data/model/service_provider_model.dart';
import 'package:bookme/data/model/services_model.dart';
import 'package:bookme/data/model/user_model.dart';

class BookModel {
  int? id;
  CustomerModel? by;
  ServicesModel? service;
  ServiceProviderModel? to;
  String? location;
  double? longitude;
  double? latitude;
  String? address;
  bool? is_complete;
  String? status;
  String? booking_start_date_time;
  String? booking_end_date_time;
  String? expected_hour;
  String? success;
  String? error;
  String? message;
  bool? is_paid;
  String? image;
  FavoriteProviderModel? favorite_provider;
  BookModel({
    this.id,
    this.by,
    this.service,
    this.to,
    this.location,
    this.longitude,
    this.latitude,
    this.address,
    this.is_complete,
    this.status,
    this.booking_start_date_time,
    this.booking_end_date_time,
    this.expected_hour,
    this.success,
    this.error,
    this.message,
    this.is_paid,
    this.image,
    this.favorite_provider,
  });

  BookModel.initError(String error) {
    this.error = error;
    this.message = error;
  }

  BookModel copyWith({
    int? id,
    CustomerModel? by,
    ServicesModel? service,
    ServiceProviderModel? to,
    String? location,
    double? longitude,
    double? latitude,
    String? address,
    bool? is_complete,
    String? status,
    String? booking_start_date_time,
    String? booking_end_date_time,
    String? expected_hour,
    String? success,
    String? error,
    String? message,
    bool? is_paid,
    String? image,
    FavoriteProviderModel? favorite_provider,
  }) {
    return BookModel(
      id: id ?? this.id,
      by: by ?? this.by,
      service: service ?? this.service,
      to: to ?? this.to,
      location: location ?? this.location,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      address: address ?? this.address,
      is_complete: is_complete ?? this.is_complete,
      status: status ?? this.status,
      booking_start_date_time:
          booking_start_date_time ?? this.booking_start_date_time,
      booking_end_date_time:
          booking_end_date_time ?? this.booking_end_date_time,
      expected_hour: expected_hour ?? this.expected_hour,
      success: success ?? this.success,
      error: error ?? this.error,
      message: message ?? this.message,
      is_paid: is_paid ?? this.is_paid,
      image: image ?? this.image,
      favorite_provider: favorite_provider ?? this.favorite_provider,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'by': by?.toMap(),
      'service': service?.toMap(),
      'to': to?.toMap(),
      'location': location,
      'longitude': longitude,
      'latitude': latitude,
      'address': address,
      'is_complete': is_complete,
      'status': status,
      'booking_start_date_time': booking_start_date_time,
      'booking_end_date_time': booking_end_date_time,
      'expected_hour': expected_hour,
      'success': success,
      'error': error,
      'message': message,
      'is_paid': is_paid,
      'image': image,
      'favorite_provider': favorite_provider?.toMap(),
    };
  }

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      id: map['id'] != null ? map['id'] as int : null,
      by: map['by'] != null
          ? CustomerModel.fromMap(map['by'] as Map<String, dynamic>)
          : null,
      service: map['service'] != null
          ? ServicesModel.fromMap(map['service'] as Map<String, dynamic>)
          : null,
      to: map['to'] != null
          ? ServiceProviderModel.fromMap(map['to'] as Map<String, dynamic>)
          : null,
      location: map['location'] != null ? map['location'] as String : null,
      longitude: map['longitude'] != null ? map['longitude'] as double : null,
      latitude: map['latitude'] != null ? map['latitude'] as double : null,
      address: map['address'] != null ? map['address'] as String : null,
      is_complete:
          map['is_complete'] != null ? map['is_complete'] as bool : null,
      status: map['status'] != null ? map['status'] as String : null,
      booking_start_date_time: map['booking_start_date_time'] != null
          ? map['booking_start_date_time'] as String
          : null,
      booking_end_date_time: map['booking_end_date_time'] != null
          ? map['booking_end_date_time'] as String
          : null,
      expected_hour:
          map['expected_hour'] != null ? map['expected_hour'] as String : null,
      success: map['success'] != null ? map['success'] as String : null,
      error: map['error'] != null ? map['error'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
      is_paid: map['is_paid'] != null ? map['is_paid'] as bool : null,
      image: map['image'] != null ? map['image'] as String : null,
      favorite_provider: map['favorite_provider'] != null
          ? FavoriteProviderModel.fromMap(
              map['favorite_provider'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookModel.fromJson(String source) =>
      BookModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BookModel(id: $id, by: $by, service: $service, to: $to, location: $location, longitude: $longitude, latitude: $latitude, address: $address, is_complete: $is_complete, status: $status, booking_start_date_time: $booking_start_date_time, booking_end_date_time: $booking_end_date_time, expected_hour: $expected_hour, success: $success, error: $error, message: $message, is_paid: $is_paid, image: $image, favorite_provider: $favorite_provider)';
  }

  @override
  bool operator ==(covariant BookModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.by == by &&
        other.service == service &&
        other.to == to &&
        other.location == location &&
        other.longitude == longitude &&
        other.latitude == latitude &&
        other.address == address &&
        other.is_complete == is_complete &&
        other.status == status &&
        other.booking_start_date_time == booking_start_date_time &&
        other.booking_end_date_time == booking_end_date_time &&
        other.expected_hour == expected_hour &&
        other.success == success &&
        other.error == error &&
        other.message == message &&
        other.is_paid == is_paid &&
        other.image == image &&
        other.favorite_provider == favorite_provider;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        by.hashCode ^
        service.hashCode ^
        to.hashCode ^
        location.hashCode ^
        longitude.hashCode ^
        latitude.hashCode ^
        address.hashCode ^
        is_complete.hashCode ^
        status.hashCode ^
        booking_start_date_time.hashCode ^
        booking_end_date_time.hashCode ^
        expected_hour.hashCode ^
        success.hashCode ^
        error.hashCode ^
        message.hashCode ^
        is_paid.hashCode ^
        image.hashCode ^
        favorite_provider.hashCode;
  }
}
