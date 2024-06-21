import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import '../../../public_features/error/error_exception.dart';
import '../../services/form_repository.dart';

part 'send_data_event.dart';

part 'send_data_state.dart';

class SendDataBloc extends Bloc<SendDataEvent, SendDataState> {
  final FormRepository formRepository;

  SendDataBloc(this.formRepository) : super(SendDataInitial()) {
    on<CallSendDataFormBuilderEvent>(_callSendDataFormBuilder);
    on<CallEditSendDataFormBuilderEvent>(_callEditSendDataFormBuilder);
  }

  FutureOr<void> _callSendDataFormBuilder(
      CallSendDataFormBuilderEvent event, Emitter<SendDataState> emit) async {
    emit(FormBuilderSendDataLoadingState());

    try {
      await formRepository.callSendModelRepository(event.data, event.appId);
      emit(FormBuilderSendDataCompletedState(
          sendMsg: 'اطلاعات با موفقیت ثبت شد!'));
    } on DioException catch (e) {
      emit(FormBuilderSendDataErrorState(
          errorMsg: ErrorExceptions().fromError(e).toString()));
    }
  }

  FutureOr<void> _callEditSendDataFormBuilder(
      CallEditSendDataFormBuilderEvent event,
      Emitter<SendDataState> emit) async {
    emit(FormBuilderSendDataLoadingState());

    try {
      await formRepository.callEditSendModelRepository(
           event.data, event.dataId);
      emit(FormBuilderSendDataCompletedState(
          sendMsg: 'اطلاعات با موفقیت ویرایش شد!'));
    } on DioException catch (e) {
      emit(FormBuilderSendDataErrorState(
          errorMsg: ErrorExceptions().fromError(e).toString()));
    }
  }
}
