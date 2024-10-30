// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bookme/data/model/services_model.dart';
import 'package:bookme/data/model/user_model.dart';

class BidModel {
  UserModel? user;
  ServicesModel? service;
  String? textcontent;
  String? image;
  String? timestamp;
  String? report_count;
  double? lon;
  double? lat;
  String? location;
  int? error;
  String? message;
  int? success;
  int? id;
  BidModel({
    this.user,
    this.service,
    this.textcontent,
    this.image,
    this.timestamp,
    this.report_count,
    this.lon,
    this.lat,
    this.location,
    this.error,
    this.message,
    this.success,
    this.id,
  });
  BidModel.InitError(this.message) {
    this.error = 1;
  }

  BidModel copyWith({
    UserModel? user,
    ServicesModel? service,
    String? textcontent,
    String? image,
    String? timestamp,
    String? report_count,
    double? lon,
    double? lat,
    String? location,
    int? error,
    String? message,
    int? success,
    int? id,
  }) {
    return BidModel(
      user: user ?? this.user,
      service: service ?? this.service,
      textcontent: textcontent ?? this.textcontent,
      image: image ?? this.image,
      timestamp: timestamp ?? this.timestamp,
      report_count: report_count ?? this.report_count,
      lon: lon ?? this.lon,
      lat: lat ?? this.lat,
      location: location ?? this.location,
      error: error ?? this.error,
      message: message ?? this.message,
      success: success ?? this.success,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user?.toMap(),
      'service': service?.toMap(),
      'textcontent': textcontent,
      'image': image,
      'timestamp': timestamp,
      'report_count': report_count,
      'lon': lon,
      'lat': lat,
      'location': location,
      'error': error,
      'message': message,
      'success': success,
      'id': id,
    };
  }

  factory BidModel.fromMap(Map<String, dynamic> map) {
    return BidModel(
      user: map['user'] != null
          ? UserModel.fromMap(map['user'] as Map<String, dynamic>)
          : null,
      service: map['service'] != null
          ? ServicesModel.fromMap(map['service'] as Map<String, dynamic>)
          : null,
      textcontent:
          map['textcontent'] != null ? map['textcontent'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      timestamp: map['timestamp'] != null ? map['timestamp'] as String : null,
      report_count:
          map['report_count'] != null ? map['report_count'] as String : null,
      lon: map['lon'] != null ? map['lon'] as double : null,
      lat: map['lat'] != null ? map['lat'] as double : null,
      location: map['location'] != null ? map['location'] as String : null,
      error: map['error'] != null ? map['error'] as int : null,
      message: map['message'] != null ? map['message'] as String : null,
      success: map['success'] != null ? map['success'] as int : null,
      id: map['id'] != null ? map['id'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BidModel.fromJson(String source) =>
      BidModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BidModel(user: $user, service: $service, textcontent: $textcontent, image: $image, timestamp: $timestamp, report_count: $report_count, lon: $lon, lat: $lat, location: $location, error: $error, message: $message, success: $success, id: $id)';
  }

  @override
  bool operator ==(covariant BidModel other) {
    if (identical(this, other)) return true;
  
    return other.user == user &&
        other.service == service &&
        other.textcontent == textcontent &&
        other.image == image &&
        other.timestamp == timestamp &&
        other.report_count == report_count &&
        other.lon == lon &&
        other.lat == lat &&
        other.location == location &&
        other.error == error &&
        other.message == message &&
        other.success == success &&
        other.id == id;
  }

  @override
  int get hashCode {
    return user.hashCode ^
        service.hashCode ^
        textcontent.hashCode ^
        image.hashCode ^
        timestamp.hashCode ^
        report_count.hashCode ^
        lon.hashCode ^
        lat.hashCode ^
        location.hashCode ^
        error.hashCode ^
        message.hashCode ^
        success.hashCode ^
        id.hashCode;
  }
}
