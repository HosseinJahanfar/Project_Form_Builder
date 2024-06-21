import 'package:dio/dio.dart';
import 'package:project_form_builder/features/register_features/services/register_api_services.dart';

import '../model/register_model.dart';

class RegisterRepository {
  // ignore: unused_field
  final RegisterApiServices _apiRegisterServices = RegisterApiServices();

  Future<RegisterModel> callRegisterRepository(String email, String phoneNumber,
      String password, String fullName) async {
    Response response = await _apiRegisterServices.callRegisterApi(
        email, phoneNumber, password, fullName);
    final RegisterModel registerModel = RegisterModel.fromJson(response.data);
    return registerModel;
  }
}
