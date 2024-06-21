import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio_service;
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

import '../../../const/connection.dart';

class LoginApiServices {
  final Dio _dio = Dio();

  /// call login api login
  Future<Response> callLoginToken(String phoneNumber, String password) async {
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.sendTimeout = const Duration(seconds: 30);
    final Response response = await _dio.post('${apiUrl}login',
        data: dio_service.FormData.fromMap(
            {'phone': phoneNumber, 'password': password}),
        options: Options(headers: {'Content-Type': 'multipart/form-data'}));
    return response;
  }

  /// call send-otp login
  Future<Response> callSendOtpLogin(String phoneNumber) async {
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.sendTimeout = const Duration(seconds: 30);
    final Response response = await _dio.post('${apiUrl}send-otp',
        data: dio_service.FormData.fromMap({'phone': phoneNumber}),
        options: Options(headers: {'Content-Type': 'multipart/form-data'}));
    return response;
  }

  /// call verify-otp login
  Future<Response> callVerifyLoginApi(String phoneNumber, String code) async {
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.sendTimeout = const Duration(seconds: 30);
    final Response response = await _dio.post('${apiUrl}verify-otp',
        data:
            dio_service.FormData.fromMap({'phone': phoneNumber, 'code': code}),
        options: Options(headers: {'Content-Type': 'multipart/form-data'}));
    return response;
  }
}
