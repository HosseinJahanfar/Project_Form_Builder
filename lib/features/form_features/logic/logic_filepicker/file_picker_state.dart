part of 'file_picker_bloc.dart';

@immutable
sealed class FilePickerState {}

final class FilePickerInitial extends FilePickerState {}

final class FilePickerLoadingState extends FilePickerState {}

final class FilePickerCompletedState extends FilePickerState {
  final UploadFileModel uploadFileModel;

  FilePickerCompletedState({required this.uploadFileModel});
}

final class FilePickerError extends FilePickerState {
  final String error;

  FilePickerError({required this.error});
}
