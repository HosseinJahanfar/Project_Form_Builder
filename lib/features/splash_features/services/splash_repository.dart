import 'package:dio/dio.dart';
import 'package:project_form_builder/features/splash_features/services/splash_api_services.dart';

import '../model/apps_model.dart';

class SplashRepository{
  final SplashApiServices _apiService = SplashApiServices();

  Future<AppsModel> callSplashApiRepository() async {
    final Response response = await _apiService.callSplashApi();
    final AppsModel appsModel = AppsModel.fromJson(response.data);
    return appsModel;
  }
}