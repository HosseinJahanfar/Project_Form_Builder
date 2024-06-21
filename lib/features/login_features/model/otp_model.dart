class OtpModel {
  OtpModel({
      this.success, 
      this.statusCode, 
      this.message, 
      this.accessToken, 
      this.refreshToken,});

  OtpModel.fromJson(dynamic json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }
  bool? success;
  int? statusCode;
  String? message;
  String? accessToken;
  String? refreshToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['statusCode'] = statusCode;
    map['message'] = message;
    map['access_token'] = accessToken;
    map['refresh_token'] = refreshToken;
    return map;
  }

}