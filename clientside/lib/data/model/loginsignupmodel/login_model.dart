// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginModel {
  String? access;
  String? refreshtoken;
  String? user_type;
  String? success;
  String? error;

  LoginModel(
      {this.access,
      this.refreshtoken,
      this.user_type,
      this.success,
      this.error});

  LoginModel copyWith({
    String? access,
    String? refreshtoken,
    String? user_type,
    String? success,
    String? error,
  }) {
    return LoginModel(
      access: access ?? this.access,
      refreshtoken: refreshtoken ?? this.refreshtoken,
      user_type: user_type ?? this.user_type,
      success: success ?? this.success,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'access': access,
      'refreshtoken': refreshtoken,
      'user_type': user_type,
      'success': success,
      'error': error,
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      access: map['access'] != null ? map['access'] as String : null,
      refreshtoken:
          map['refreshtoken'] != null ? map['refreshtoken'] as String : null,
      user_type: map['user_type'] != null ? map['user_type'] as String : null,
      success: map['success'] != null ? map['success'] as String : null,
      error: map['error'] != null ? map['error'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginModel.fromJson(String source) =>
      LoginModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LoginModel(access: $access, refreshtoken: $refreshtoken, user_type: $user_type, success: $success)';
  }

  @override
  bool operator ==(covariant LoginModel other) {
    if (identical(this, other)) return true;

    return other.access == access &&
        other.refreshtoken == refreshtoken &&
        other.user_type == user_type &&
        other.success == success;
  }

  @override
  int get hashCode {
    return access.hashCode ^
        refreshtoken.hashCode ^
        user_type.hashCode ^
        success.hashCode;
  }

  LoginModel.InitError(String error) {
    this.error = error;
  }
}
