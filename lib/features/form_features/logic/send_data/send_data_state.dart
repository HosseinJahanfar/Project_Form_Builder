part of 'send_data_bloc.dart';

@immutable
sealed class SendDataState {}

final class SendDataInitial extends SendDataState {}
///send data

final class FormBuilderSendDataLoadingState extends SendDataState {}

final class FormBuilderSendDataCompletedState extends SendDataState {
  final String sendMsg;

  FormBuilderSendDataCompletedState({required this.sendMsg});
}
final class FormBuilderSendDataErrorState extends SendDataState {
  final String errorMsg;

  FormBuilderSendDataErrorState({required this.errorMsg});
}