// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChatModel {
  String? sender;
  String? receiver;
  String? message;
  bool? isMe = false;
  String? error;

  ChatModel.initError(this.error);

  ChatModel({
    this.sender,
    this.receiver,
    this.message,
    this.isMe,
    this.error,
  });
  // ChatModel({
  //   this.sender,
  //   this.receiver,
  //   this.message,
  //   this.isMe,
  // });

  // ChatModel copyWith({
  //   String? sender,
  //   String? receiver,
  //   String? message,
  //   bool? isMe,
  // }) {
  //   return ChatModel(
  //     sender: sender ?? this.sender,
  //     receiver: receiver ?? this.receiver,
  //     message: message ?? this.message,
  //     isMe: isMe ?? this.isMe,
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'sender': sender,
  //     'receiver': receiver,
  //     'message': message,
  //     'isMe': isMe,
  //   };
  // }

  // factory ChatModel.fromMap(Map<String, dynamic> map) {
  //   return ChatModel(
  //     sender: map['sender'] != null ? map['sender'] as String : null,
  //     receiver: map['receiver'] != null ? map['receiver'] as String : null,
  //     message: map['message'] != null ? map['message'] as String : null,
  //     isMe: map['isMe'] != null ? map['isMe'] as bool : null,
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory ChatModel.fromJson(String source) =>
  //     ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  // @override
  // String toString() {
  //   return 'ChatModel(sender: $sender, receiver: $receiver, message: $message, isMe: $isMe)';
  // }

  // @override
  // bool operator ==(covariant ChatModel other) {
  //   if (identical(this, other)) return true;

  //   return other.sender == sender &&
  //       other.receiver == receiver &&
  //       other.message == message &&
  //       other.isMe == isMe;
  // }

  // @override
  // int get hashCode {
  //   return sender.hashCode ^
  //       receiver.hashCode ^
  //       message.hashCode ^
  //       isMe.hashCode;
  // }

  ChatModel copyWith({
    String? sender,
    String? receiver,
    String? message,
    bool? isMe,
    String? error,
    String? error_message,
  }) {
    return ChatModel(
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      message: message ?? this.message,
      isMe: isMe ?? this.isMe,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sender': sender,
      'receiver': receiver,
      'message': message,
      'isMe': isMe,
      'error': error,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      sender: map['sender'] != null ? map['sender'] as String : null,
      receiver: map['receiver'] != null ? map['receiver'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
      isMe: map['isMe'] != null ? map['isMe'] as bool : null,
      error: map['error'] != null ? map['error'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatModel(sender: $sender, receiver: $receiver, message: $message, isMe: $isMe, error: $error)';
  }

  @override
  bool operator ==(covariant ChatModel other) {
    if (identical(this, other)) return true;
  
    return other.sender == sender &&
        other.receiver == receiver &&
        other.message == message &&
        other.isMe == isMe &&
        other.error == error;
  }

  @override
  int get hashCode {
    return sender.hashCode ^
        receiver.hashCode ^
        message.hashCode ^
        isMe.hashCode ^
        error.hashCode;
  }
}
