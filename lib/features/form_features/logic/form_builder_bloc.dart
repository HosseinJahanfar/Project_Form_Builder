import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../public_features/error/error_exception.dart';
import '../model/form_model.dart';
import '../services/form_repository.dart';

part 'form_builder_event.dart';

part 'form_builder_state.dart';

class FormBuilderBloc extends Bloc<FormBuilderEvent, FormBuilderState> {
  final FormRepository formRepository;
  List<dynamic> dataList=[];
  FormBuilderBloc(this.formRepository) : super(FormBuilderInitial()) {
    on<CallFormBuilderEvent>(_callFormBuilder);
  }

  FutureOr<void> _callFormBuilder(
      CallFormBuilderEvent event, Emitter<FormBuilderState> emit) async {
    emit(FormBuilderLoadingState());

    try {
      dataList.clear();
       dataList =
          await formRepository.callFormRepository(event.activeForm);
      emit(FormBuilderCompletedState(
          listData: dataList,
          typeData: formRepository.typeData,
          formModel: formRepository.formModel!));
    } on DioException catch (e) {
      emit(FormBuilderErrorState(
          errorMsg: ErrorExceptions().fromError(e).toString()));
    }
  }
}
