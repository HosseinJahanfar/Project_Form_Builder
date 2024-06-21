class LoginModel {
  LoginModel({
      this.success, 
      this.statusCode, 
      this.message, 
      this.access, 
      this.refresh, 
      this.authenticatedUser,});

  LoginModel.fromJson(dynamic json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    access = json['access'];
    refresh = json['refresh'];
    authenticatedUser = json['authenticatedUser'] != null ? AuthenticatedUser.fromJson(json['authenticatedUser']) : null;
  }
  bool? success;
  int? statusCode;
  String? message;
  String? access;
  String? refresh;
  AuthenticatedUser? authenticatedUser;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['statusCode'] = statusCode;
    map['message'] = message;
    map['access'] = access;
    map['refresh'] = refresh;
    if (authenticatedUser != null) {
      map['authenticatedUser'] = authenticatedUser?.toJson();
    }
    return map;
  }

}

class AuthenticatedUser {
  AuthenticatedUser({
      this.phone, 
      this.role,});

  AuthenticatedUser.fromJson(dynamic json) {
    phone = json['phone'];
    role = json['role'];
  }
  String? phone;
  int? role;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phone'] = phone;
    map['role'] = role;
    return map;
  }

}