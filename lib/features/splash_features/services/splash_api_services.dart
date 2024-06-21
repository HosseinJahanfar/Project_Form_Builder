import 'package:dio/dio.dart';
import '../../../const/connection.dart';
class SplashApiServices{

  final Dio _dio = Dio();

  /// call SplashApiServices api
  Future<Response> callSplashApi() async {
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.sendTimeout = const Duration(seconds: 30);

    final Response response = await _dio.get(apiApps);
    return response;
  }
}