// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bookme/data/model/model_export.dart';

class NotificationModel {
  int? id;
  String? title;
  bool? success;
  String? type;
  String? body;
  String? url;
  String? notification_type;
  bool? is_positive;
  UserModel? sender;
  UserModel? rece;
  String? error;
  String? time;
  NotificationModel(
      {this.id,
      this.title,
      this.success,
      this.type,
      this.body,
      this.url,
      this.notification_type,
      this.is_positive,
      this.sender,
      this.rece,
      this.error,
      this.time});
  NotificationModel.initError(this.error);

  NotificationModel copyWith(
      {int? id,
      String? title,
      bool? success,
      String? type,
      String? body,
      String? url,
      String? notification_type,
      bool? is_positive,
      UserModel? sender,
      UserModel? rece,
      String? error,
      String? time}) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      success: success ?? this.success,
      type: type ?? this.type,
      body: body ?? this.body,
      url: url ?? this.url,
      notification_type: notification_type ?? this.notification_type,
      is_positive: is_positive ?? this.is_positive,
      sender: sender ?? this.sender,
      rece: rece ?? this.rece,
      error: error ?? this.error,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'success': success,
      'type': type,
      'body': body,
      'url': url,
      'notification_type': notification_type,
      'is_positive': is_positive,
      'sender': sender?.toMap(),
      'rece': rece?.toMap(),
      'error': error,
      'time': time,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      success: map['success'] != null ? map['success'] as bool : null,
      type: map['type'] != null ? map['type'] as String : null,
      body: map['body'] != null ? map['body'] as String : null,
      url: map['url'] != null ? map['url'] as String : null,
      notification_type: map['notification_type'] != null
          ? map['notification_type'] as String
          : null,
      is_positive:
          map['is_positive'] != null ? map['is_positive'] as bool : null,
      sender: map['sender'] != null
          ? UserModel.fromMap(map['sender'] as Map<String, dynamic>)
          : null,
      rece: map['rece'] != null
          ? UserModel.fromMap(map['rece'] as Map<String, dynamic>)
          : null,
      error: map['error'] != null ? map['error'] as String : null,
      time: map['time'] != null ? map['time'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NotificationModel(id: $id, title: $title, success: $success, type: $type, body: $body, url: $url, notification_type: $notification_type, is_positive: $is_positive, sender: $sender, rece: $rece, error: $error)';
  }

  @override
  bool operator ==(covariant NotificationModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.success == success &&
        other.type == type &&
        other.body == body &&
        other.url == url &&
        other.notification_type == notification_type &&
        other.is_positive == is_positive &&
        other.sender == sender &&
        other.rece == rece &&
        other.error == error &&
        other.time == time;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        success.hashCode ^
        type.hashCode ^
        body.hashCode ^
        url.hashCode ^
        notification_type.hashCode ^
        is_positive.hashCode ^
        sender.hashCode ^
        rece.hashCode ^
        time.hashCode ^
        error.hashCode;
  }
}
