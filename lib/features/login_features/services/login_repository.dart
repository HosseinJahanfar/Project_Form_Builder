import 'package:dio/dio.dart';

import '../model/login_model.dart';
import '../model/otp_model.dart';
import 'login_api_services.dart';

class LoginRepository {
  // ignore: unused_field
  final LoginApiServices _apiLoginServices = LoginApiServices();

  Future<LoginModel> callLoginRepository(
      String phoneNumber, String password) async {
    Response response =
        await _apiLoginServices.callLoginToken(phoneNumber, password);

    final LoginModel loginToken = LoginModel.fromJson(response.data);
    return loginToken;
  }

  Future<void> callOtpLogin(String phoneNumber) async {
    await _apiLoginServices.callSendOtpLogin(phoneNumber);
  }

  Future<OtpModel> callVerifyLoginRepository(
      String phoneNumber, String code) async {
    Response response =
        await _apiLoginServices.callVerifyLoginApi(phoneNumber, code);

    final OtpModel otpModel = OtpModel.fromJson(response.data);
    return otpModel;
  }
}
