import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio_service;
import '../../../const/connection.dart';
import '../../../const/string/key_data_base.dart';
import '../../public_features/functions/secure_storage.dart';

class FormApiServices {
  final Dio _dio = Dio();

  //!wgt woken
  FormApiServices() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Add the access token to the request header
        final accessToken =
            await SecureStorageClass().getUserToken(KeyDataBase.token);
        options.headers['Authorization'] = 'Bearer $accessToken';
        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401) {
          // If a 401 response is received, refresh the access token
          final newAccessToken = await callRefreshToken();
          if (newAccessToken != null) {
            // Update the request header with the new access token
            e.requestOptions.headers['Authorization'] =
                'Bearer $newAccessToken';
            // Retry the request with the updated header
            return handler.resolve(await _dio.fetch(e.requestOptions));
          } else {
            // Handle token refresh failure
            // For example, logout user or show error message
            return handler.next(e);
          }
        }
        return handler.next(e);
      },
    ));
  }

  //! call refresh api token
  Future<String?> callRefreshToken() async {
    try {
      final tokenKey =
          await SecureStorageClass().getUserToken(KeyDataBase.refreshToken);
      final Response response = await _dio.post(apiRefresh,
          data: dio_service.FormData.fromMap({'refresh': tokenKey}),
          options: Options(headers: {'Content-Type': 'multipart/form-data'}));
      final newAccessToken = response.data['access'];
      // Update the access token in secure storage
      await SecureStorageClass()
          .saveUserToken(KeyDataBase.token, newAccessToken);
      return newAccessToken;
    } catch (e) {
      print('Error calling refresh token API: $e');
      return null;
    }
  }

  //!call send data form
  Future<Response> callSendDataForm(String inputs, String form) async {
    try {
      _dio.options.connectTimeout = const Duration(seconds: 30);
      _dio.options.receiveTimeout = const Duration(seconds: 30);
      _dio.options.sendTimeout = const Duration(seconds: 30);

      // final token = await SecureStorageClass().getUserToken();
      final token = await SecureStorageClass().getUserToken(KeyDataBase.token);
      // Adding the token to the request headers
      Options options = Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data'
        },
      );

      final Response response = await _dio.post(
        apiSend,
        data: dio_service.FormData.fromMap({'inputs': inputs, 'form': form}),
        options: options, // Using the request headers
      );
      return response;
    } catch (e) {
      print('Error calling login token API: $e');
      throw e;
    }
  }

  //!call edit send data form
  Future<Response> callEditSendDataForm(String inputs, String dataId) async {
    try {
      _dio.options.connectTimeout = const Duration(seconds: 30);
      _dio.options.receiveTimeout = const Duration(seconds: 30);
      _dio.options.sendTimeout = const Duration(seconds: 30);

      // final token = await SecureStorageClass().getUserToken();
      final token = await SecureStorageClass().getUserToken(KeyDataBase.token);
      // Adding the token to the request headers
      Options options = Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data'
        },
      );

      final Response response = await _dio.put(
        'http://form.netopen.ir/form/data/$dataId',
        data: dio_service.FormData.fromMap({
          'inputs': inputs,
        }),
        options: options, // Using the request headers
      );
      return response;
    } catch (e) {
      print('Error calling login token API: $e');
      throw e;
    }
  }

  /// call data form
  Future<Response> callDataForm(String activeForm) async {
    try {
      _dio.options.connectTimeout = const Duration(seconds: 30);
      _dio.options.receiveTimeout = const Duration(seconds: 30);
      _dio.options.sendTimeout = const Duration(seconds: 30);

      // final token = await SecureStorageClass().getUserToken();
      final token = await SecureStorageClass().getUserToken(KeyDataBase.token);
      // Adding the token to the request headers
      Options options = Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      final Response response = await _dio.get(
        '$apiForm/get/$activeForm',
        options: options, // Using the request headers
      );
      return response;
    } catch (e) {
      print('Error calling login token API: $e');
      throw e;
    }
  }

  ///call form registration  list
  Future<Response> callFormRegistrationList() async {
    try {
      _dio.options.connectTimeout = const Duration(seconds: 30);
      _dio.options.receiveTimeout = const Duration(seconds: 30);
      _dio.options.sendTimeout = const Duration(seconds: 30);

      // final token = await SecureStorageClass().getUserToken();
      final token = await SecureStorageClass().getUserToken(KeyDataBase.token);
      // Adding the token to the request headers
      Options options = Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      final Response response = await _dio.get(
        '$apiForm/list',
        options: options, // Using the request headers
      );
      return response;
    } catch (e) {
      print('Error calling login token API: $e');
      throw e;
    }
  }

  /// call show report form
  Future<Response> callReportForm(String activeForm) async {
    try {
      _dio.options.connectTimeout = const Duration(seconds: 30);
      _dio.options.receiveTimeout = const Duration(seconds: 30);
      _dio.options.sendTimeout = const Duration(seconds: 30);

      final token = await SecureStorageClass().getUserToken(KeyDataBase.token);
      // Adding the token to the request headers
      Options options = Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      final Response response = await _dio.get(
        '$apiForm/data-report/$activeForm',
        options: options, // Using the request headers
      );
      return response;
    } catch (e) {
      print('Error calling login token API: $e');
      throw e;
    }
  }

  //call form form report list
  Future<Response> callFormReportList() async {
    try {
      _dio.options.connectTimeout = const Duration(seconds: 30);
      _dio.options.receiveTimeout = const Duration(seconds: 30);
      _dio.options.sendTimeout = const Duration(seconds: 30);

      // final token = await SecureStorageClass().getUserToken();
      final token = await SecureStorageClass().getUserToken(KeyDataBase.token);
      // Adding the token to the request headers
      Options options = Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      final Response response = await _dio.get(
        '$apiForm/user-data',
        options: options, // Using the request headers
      );
      return response;
    } catch (e) {
      print('Error calling login token API: $e');
      throw e;
    }
  }
}
