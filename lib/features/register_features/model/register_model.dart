class RegisterModel {
  RegisterModel({
      this.success, 
      this.statusCode, 
      this.message, 
      this.accessToken, 
      this.refreshToken, 
      this.user,});

  RegisterModel.fromJson(dynamic json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  bool? success;
  int? statusCode;
  String? message;
  String? accessToken;
  String? refreshToken;
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['statusCode'] = statusCode;
    map['message'] = message;
    map['access_token'] = accessToken;
    map['refresh_token'] = refreshToken;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}

class User {
  User({
      this.phone, 
      this.fullname, 
      this.email, 
      this.password,});

  User.fromJson(dynamic json) {
    phone = json['phone'];
    fullname = json['fullname'];
    email = json['email'];
    password = json['password'];
  }
  String? phone;
  String? fullname;
  String? email;
  String? password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phone'] = phone;
    map['fullname'] = fullname;
    map['email'] = email;
    map['password'] = password;
    return map;
  }

}