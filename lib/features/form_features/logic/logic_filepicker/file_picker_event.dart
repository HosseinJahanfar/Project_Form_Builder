part of 'file_picker_bloc.dart';

@immutable
sealed class FilePickerEvent {}

final class CallUploadFileRequest extends FilePickerEvent {
  final String uploadFile;

  CallUploadFileRequest({required this.uploadFile});
}
