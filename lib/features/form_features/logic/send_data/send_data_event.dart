part of 'send_data_bloc.dart';

@immutable
sealed class SendDataEvent {}

final class CallSendDataFormBuilderEvent extends SendDataEvent {
  final String data;
  final String appId;

  CallSendDataFormBuilderEvent({required this.data, required this.appId});
}

final class CallEditSendDataFormBuilderEvent extends SendDataEvent {
  final String data;
  final String dataId;

  CallEditSendDataFormBuilderEvent(
      {required this.data, required this.dataId});
}
