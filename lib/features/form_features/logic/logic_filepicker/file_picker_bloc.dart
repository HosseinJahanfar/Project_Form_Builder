import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:project_form_builder/features/form_features/model/upload_file_model.dart';
import '../../../public_features/error/error_exception.dart';
import '../../services/filepicker_repository.dart';

part 'file_picker_event.dart';

part 'file_picker_state.dart';

class FilePickerBloc extends Bloc<FilePickerEvent, FilePickerState> {
  final FilePickerRepository _filePickerRepository;
  String url = '';

  FilePickerBloc(this._filePickerRepository) : super(FilePickerInitial()) {
    on<CallUploadFileRequest>((event, emit) async {
      emit(FilePickerLoadingState());
      try {
        final UploadFileModel uploadFileModel =
            await _filePickerRepository.callProfileRepository(event.uploadFile);
        url = uploadFileModel.file.toString();
        emit(FilePickerCompletedState(uploadFileModel: uploadFileModel));
      } on DioException catch (e) {
        emit(FilePickerError(error: ErrorExceptions().fromError(e).toString()));
      }
    });
  }
}
