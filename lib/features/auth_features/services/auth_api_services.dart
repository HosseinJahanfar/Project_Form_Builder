import 'package:dio/dio.dart';

import '../../../const/connection.dart';

class AuthApiServices {
  final Dio _dio = Dio();

  /// call authentication api
  Future<Response> callAuthApi(String phoneNumber) async {
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.sendTimeout = const Duration(seconds: 30);
    final Response response = await _dio.get('$apiAuth$phoneNumber');
    // print(response.data);
    return response;
  }
}
