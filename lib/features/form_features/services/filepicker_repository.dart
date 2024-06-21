import 'package:dio/dio.dart';
import 'package:project_form_builder/features/form_features/model/upload_file_model.dart';
import 'filepicker_api_services.dart';

class FilePickerRepository {
  final FilePickerApiServices _filePickerApiServices = FilePickerApiServices();

  ///call UploadFileModel model
  Future<UploadFileModel> callProfileRepository(String filePath) async {
    final Response response =
        await _filePickerApiServices.callUploadFile(filePath);
    UploadFileModel uploadFileModel = UploadFileModel.fromJson(response.data);

    return uploadFileModel;
  }
}
