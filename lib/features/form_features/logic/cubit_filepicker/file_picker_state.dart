part of 'file_picker_cubit.dart';

@immutable
sealed class FilePickerStateCubit {}

final class FilePickerInitialCubit extends FilePickerStateCubit {}

final class FilePickerLoadingStateCubit extends FilePickerStateCubit {}

final class FilePickerCompletedStateCubit extends FilePickerStateCubit {
  final UploadFileModel responseUploadFile;

  FilePickerCompletedStateCubit({required this.responseUploadFile});
}

final class FilePickerErrorStateCubit extends FilePickerStateCubit {
  final String errorMessage;

  FilePickerErrorStateCubit({required this.errorMessage});
}
