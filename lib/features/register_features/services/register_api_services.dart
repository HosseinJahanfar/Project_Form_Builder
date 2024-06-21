import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio_service;

import '../../../const/connection.dart';

class RegisterApiServices {
  final Dio _dio = Dio();

  /// call register api
  Future<Response> callRegisterApi(String email, String phoneNumber,
      String password, String fullName) async {
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.sendTimeout = const Duration(seconds: 30);
    try {
      final Response response = await _dio.post('${apiUrl}register',
          data: dio_service.FormData.fromMap({
            'email': email,
            'phone': phoneNumber,
            'password': password,
            'fullname': fullName
          }),
          options: Options(headers: {'Content-Type': 'multipart/form-data'}));
      return response;
    } catch (e) {
      print('Error calling login token API: $e');
      throw e;
    }
  }
}
