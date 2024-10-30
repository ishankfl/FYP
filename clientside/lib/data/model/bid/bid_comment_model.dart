// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bookme/data/model/bid/bid_model.dart';
import 'package:bookme/data/model/user_model.dart';

class BidCommentModel {
  UserModel? user;
  String? text;
  BidModel? bid;
  String? timestamp;
  bool? isFinal;
  String? error;
  BidCommentModel({
    this.user,
    this.text,
    this.bid,
    this.timestamp,
    this.isFinal,
    this.error,
  });

  BidCommentModel copyWith({
    UserModel? user,
    String? text,
    BidModel? bid,
    String? timestamp,
    bool? isFinal,
    String? error,
  }) {
    return BidCommentModel(
      user: user ?? this.user,
      text: text ?? this.text,
      bid: bid ?? this.bid,
      timestamp: timestamp ?? this.timestamp,
      isFinal: isFinal ?? this.isFinal,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user?.toMap(),
      'text': text,
      'bid': bid?.toMap(),
      'timestamp': timestamp,
      'isFinal': isFinal,
      'error': error,
    };
  }

  factory BidCommentModel.fromMap(Map<String, dynamic> map) {
    return BidCommentModel(
      user: map['user'] != null
          ? UserModel.fromMap(map['user'] as Map<String, dynamic>)
          : null,
      text: map['text'] != null ? map['text'] as String : null,
      bid: map['bid'] != null
          ? BidModel.fromMap(map['bid'] as Map<String, dynamic>)
          : null,
      timestamp: map['timestamp'] != null ? map['timestamp'] as String : null,
      isFinal: map['isFinal'] != null ? map['isFinal'] as bool : null,
      error: map['error'] != null ? map['error'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BidCommentModel.fromJson(String source) =>
      BidCommentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BidCommentModel(user: $user, text: $text, bid: $bid, timestamp: $timestamp, isFinal: $isFinal, error: $error)';
  }

  @override
  bool operator ==(covariant BidCommentModel other) {
    if (identical(this, other)) return true;

    return other.user == user &&
        other.text == text &&
        other.bid == bid &&
        other.timestamp == timestamp &&
        other.isFinal == isFinal &&
        other.error == error;
  }

  @override
  int get hashCode {
    return user.hashCode ^
        text.hashCode ^
        bid.hashCode ^
        timestamp.hashCode ^
        isFinal.hashCode ^
        error.hashCode;
  }

  BidCommentModel.initError(this.error);
}
