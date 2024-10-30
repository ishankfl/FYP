// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  int? id;
  String? fullname;
  String? full_name;
  String? email;
  String? city;
  String? phonenumber;
  String? password;
  String? error;
  String? message;
  String? secret_code;
  String? user_type;
  String? profile;
  String? username;
  String? access;
  UserModel({
    this.id,
    this.fullname,
    this.full_name,
    this.email,
    this.city,
    this.phonenumber,
    this.password,
    this.error,
    this.message,
    this.secret_code,
    this.user_type,
    this.profile,
    this.username,
    this.access,
  });

  UserModel.InitError(String error) {
    this.error = error;
  }

  UserModel.withError(String error) {
    this.error = error;
  }

  UserModel copyWith({
    int? id,
    String? fullname,
    String? full_name,
    String? email,
    String? city,
    String? phonenumber,
    String? password,
    String? error,
    String? message,
    String? secret_code,
    String? user_type,
    String? profile,
    String? username,
    String? access,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
      full_name: full_name ?? this.full_name,
      email: email ?? this.email,
      city: city ?? this.city,
      phonenumber: phonenumber ?? this.phonenumber,
      password: password ?? this.password,
      error: error ?? this.error,
      message: message ?? this.message,
      secret_code: secret_code ?? this.secret_code,
      user_type: user_type ?? this.user_type,
      profile: profile ?? this.profile,
      username: username ?? this.username,
      access: access ?? this.access,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullname': fullname,
      'full_name': full_name,
      'email': email,
      'city': city,
      'phonenumber': phonenumber,
      'password': password,
      'error': error,
      'message': message,
      'secret_code': secret_code,
      'user_type': user_type,
      'profile': profile,
      'username': username,
      'access': access,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as int : null,
      fullname: map['fullname'] != null ? map['fullname'] as String : null,
      full_name: map['full_name'] != null ? map['full_name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      phonenumber:
          map['phonenumber'] != null ? map['phonenumber'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      error: map['error'] != null ? map['error'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
      secret_code:
          map['secret_code'] != null ? map['secret_code'] as String : null,
      user_type: map['user_type'] != null ? map['user_type'] as String : null,
      profile: map['profile'] != null ? map['profile'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      access: map['access'] != null ? map['access'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, fullname: $fullname, full_name: $full_name, email: $email, city: $city, phonenumber: $phonenumber, password: $password, error: $error, message: $message, secret_code: $secret_code, user_type: $user_type, profile: $profile, username: $username, access: $access)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return other.id == id &&
        other.fullname == fullname &&
        other.full_name == full_name &&
        other.email == email &&
        other.city == city &&
        other.phonenumber == phonenumber &&
        other.password == password &&
        other.error == error &&
        other.message == message &&
        other.secret_code == secret_code &&
        other.user_type == user_type &&
        other.profile == profile &&
        other.username == username &&
        other.access == access;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fullname.hashCode ^
        full_name.hashCode ^
        email.hashCode ^
        city.hashCode ^
        phonenumber.hashCode ^
        password.hashCode ^
        error.hashCode ^
        message.hashCode ^
        secret_code.hashCode ^
        user_type.hashCode ^
        profile.hashCode ^
        username.hashCode ^
        access.hashCode;
  }

  UserModel.initError(this.error);
}
