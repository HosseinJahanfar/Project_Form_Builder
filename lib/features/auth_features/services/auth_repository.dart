import 'package:dio/dio.dart';

import 'auth_api_services.dart';

class AuthRepository {
  final AuthApiServices _apiService = AuthApiServices();

  Future<bool> callAuthApiRepository(String phoneNumber) async {
    final Response response = await _apiService.callAuthApi(phoneNumber);
    final bool userStatus = response.data['userExistence'];
    return userStatus;
  }
}
