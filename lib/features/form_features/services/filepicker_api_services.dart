import 'package:dio/dio.dart';
import '../../../const/string/key_data_base.dart';
import '../../public_features/functions/secure_storage.dart';

class FilePickerApiServices {
  final Dio _dio = Dio();

  Future<Response> callUploadFile(String filePath) async {
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.sendTimeout = const Duration(seconds: 30);
    final token = await SecureStorageClass().getUserToken(KeyDataBase.token);
    final headers = {
      'Authorization': 'Bearer $token',
    };

    final data = {
      'file': filePath == ''
          ? ''
          : await MultipartFile.fromFile(
        filePath,
      ),
    };

    try {
      Response response = await _dio.post('http://form.netopen.ir/form/uploadfile',
          data: FormData.fromMap(data), options: Options(headers: headers));
      return response;
    } catch (e) {
      print('Error uploading file: $e');
      throw e;
    }
  }
}