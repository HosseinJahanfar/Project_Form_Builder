import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:meta/meta.dart';
import 'package:project_form_builder/features/form_features/model/upload_file_model.dart';

import '../../services/filepicker_repository.dart';

part 'file_picker_state.dart';

class FilePickerCubit extends Cubit<FilePickerStateCubit> {
  FilePickerCubit() : super(FilePickerInitialCubit());

  static const String fileNotSelectedMessage = 'فایل مورد نظر انتخاب نشده است.';
  static const String errorPickingFileMessage = 'خطا در انتخاب فایل: ';

  void reset() {
    emit(FilePickerInitialCubit());
  }

  Future<void> pickFile() async {
    emit(FilePickerLoadingStateCubit());
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null && result.files.isNotEmpty) {
        // FilePickerResult gives you a list of picked files (result.files),
        // so you should access the path from the first file in the list.
        String? filePath = result.files.first.path;

        if (filePath != null && filePath.isNotEmpty) {
        UploadFileModel uploadFileModel =  await FilePickerRepository().callProfileRepository(filePath);
          print('+++++++++++++++++++++++');
          emit(FilePickerCompletedStateCubit(responseUploadFile: uploadFileModel));
        } else {
          emit(FilePickerErrorStateCubit(errorMessage: 'مسیر فایل خالی است.'));
        }
      } else {
        emit(FilePickerErrorStateCubit(errorMessage: fileNotSelectedMessage));
      }
    } catch (e) {
      emit(FilePickerErrorStateCubit(
          errorMessage: '$errorPickingFileMessage$e'));
    }
  }
}